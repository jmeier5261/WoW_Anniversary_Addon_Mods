-- HealEngine.lua — Core + Public API
-- Purpose-built heal prediction engine for TBC Anniversary (Interface 20505)
-- Wire-compatible with LHC40 protocol for cross-addon interoperability
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn
-- Modifications by PineappleTuesday
--
-- Architecture: Hash-based record storage, zero garbage-table API calls,
-- single-expansion code path (no Wrath/SoD/Classic Era branches)
-- Split into: HealEngine, Utilities, Modifiers, Communication,
--             CastTracking, SpellData, Init

if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return end

local LIB_NAME  = "HealEngine-1.0"
local LIB_MINOR = 2

assert(LibStub, LIB_NAME .. " requires LibStub.")
local Engine = LibStub:NewLibrary(LIB_NAME, LIB_MINOR)
if not Engine then return end

-- Version detection: true on TBC Anniversary (20000+), false on Classic Era (11504)
Engine.isTBC = (select(4, GetBuildInfo()) or 0) >= 20000

---------------------------------------------------------------------------
-- Wire protocol prefix — matches LHC40 so other healers see our data
---------------------------------------------------------------------------
Engine.WIRE_PREFIX = "LHC40"
C_ChatInfo.RegisterAddonMessagePrefix(Engine.WIRE_PREFIX)

---------------------------------------------------------------------------
-- Heal type bitmask constants
---------------------------------------------------------------------------
local DIRECT  = 0x01
local CHANNEL = 0x02
local HOT     = 0x04
local ABSORB  = 0x08
local BOMB    = 0x10
local ALL     = bit.bor(DIRECT, CHANNEL, HOT, BOMB)
local CASTED  = bit.bor(DIRECT, CHANNEL)
local TICKING = bit.bor(HOT, CHANNEL)

Engine.DIRECT_HEALS  = DIRECT
Engine.CHANNEL_HEALS = CHANNEL
Engine.HOT_HEALS     = HOT
Engine.ABSORB_SHIELDS = ABSORB
Engine.BOMB_HEALS    = BOMB
Engine.ALL_HEALS     = ALL
Engine.CASTED_HEALS  = CASTED
Engine.OVERTIME_HEALS = TICKING
Engine.ALL_DATA      = 0xFF
Engine.OVERTIME_AND_BOMB_HEALS = bit.bor(HOT, CHANNEL, BOMB)

-- Also expose raw locals for downstream files to alias
Engine._DIRECT  = DIRECT
Engine._CHANNEL = CHANNEL
Engine._HOT     = HOT
Engine._ABSORB  = ABSORB
Engine._BOMB    = BOMB
Engine._ALL     = ALL
Engine._CASTED  = CASTED
Engine._TICKING = TICKING

---------------------------------------------------------------------------
-- Player state (writable by Init.lua and Modifiers.lua)
---------------------------------------------------------------------------
Engine.myGUID    = nil
Engine.myName    = nil
Engine.myLevel   = nil
Engine.myHealMod = 1

---------------------------------------------------------------------------
-- Internal tables
---------------------------------------------------------------------------
if not Engine.unitMap    then Engine.unitMap    = {} end
if not Engine.groupMap   then Engine.groupMap   = {} end
if not Engine.targetMods then Engine.targetMods = {} end
if not Engine.inbound    then Engine.inbound    = {} end
if not Engine.ticking    then Engine.ticking    = {} end
if not Engine.hotCount   then Engine.hotCount   = {} end

-- Local aliases for API methods (hot path)
local inbound    = Engine.inbound
local ticking    = Engine.ticking
local hotCount   = Engine.hotCount
local targetMods = Engine.targetMods

---------------------------------------------------------------------------
-- Spell data tables (populated by SpellData.lua class loader)
---------------------------------------------------------------------------
if not Engine.castInfo   then Engine.castInfo   = {} end
if not Engine.tickInfo   then Engine.tickInfo   = {} end
if not Engine.talentMods then Engine.talentMods = {} end
if not Engine.gearSets   then Engine.gearSets   = {} end
if not Engine.gearCount  then Engine.gearCount  = {} end

---------------------------------------------------------------------------
-- Spell rank mapping: rankOf[spellID] = rank (1-based)
---------------------------------------------------------------------------
local RANK_SEEDS = {
    -- Verified against TBC 2.4.3 / Anniversary 2.5.5 spell database
    -- Rejuv, Regrowth, HT, Tranq, HL, FoL, Renew, GH, PoH, FH, Heal, LH,
    -- CH, HW, LHW, MendPet, HealthFunnel, DrainLife, FirstAid, Lifebloom, BindingHeal
    [1]  = { 774, 8936, 5185, 740, 635, 19750, 139, 2060, 596, 2061, 2054, 2050, 1064, 331, 8004, 136, 755, 689, 746, 33763, 32546 },
    [2]  = { 1058, 8938, 5186, 8918, 639, 19939, 6074, 10963, 996, 9472, 2055, 2052, 10622, 332, 8008, 3111, 3698, 699, 1159 },
    [3]  = { 1430, 8939, 5187, 9862, 647, 19940, 6075, 10964, 10960, 9473, 6063, 2053, 10623, 547, 8010, 3661, 3699, 709, 3267 },
    [4]  = { 2090, 8940, 5188, 9863, 1026, 19941, 6076, 10965, 10961, 9474, 6064, 25422, 913, 10466, 3662, 3700, 7651, 3268 },
    [5]  = { 2091, 8941, 5189, 26983, 1042, 19942, 6077, 22009, 25314, 25316, 10915, 25423, 939, 10467, 13542, 11693, 11699, 7926 },
    [6]  = { 3627, 9750, 6778, 3472, 19943, 6078, 25210, 25308, 10916, 959, 10468, 13543, 11694, 11700, 7927 },
    [7]  = { 8910, 9856, 8903, 10328, 27137, 10927, 25213, 10917, 8005, 25420, 13544, 11695, 27219, 10838 },
    [8]  = { 9839, 9857, 9758, 10329, 10928, 25233, 10395, 27046, 27259, 27220, 10839 },
    [9]  = { 9840, 9858, 9888, 25292, 10929, 25235, 10396, 18608 },
    [10] = { 9841, 26980, 9889, 27135, 25315, 25357, 18610 },
    [11] = { 25299, 25297, 27136, 25221, 25391, 27030 },
    [12] = { 26981, 26978, 25222, 25396, 27031 },
    [13] = { 26982, 26979 },
}

if not Engine.rankOf then
    Engine.rankOf = {}
    for rank, list in pairs(RANK_SEEDS) do
        for _, id in ipairs(list) do
            Engine.rankOf[id] = rank
        end
    end
end

---------------------------------------------------------------------------
-- GUID compression / decompression (wire format)
-- Player GUIDs: "Player-xxx" ↔ "xxx"
-- Pet GUIDs:    "Creature-xxx" / "Pet-xxx" ↔ "p-ownerSuffix"
-- Matches LHC40 protocol for interoperability
---------------------------------------------------------------------------
if not Engine.activePets then Engine.activePets = {} end -- unit→petGUID, populated by CastTracking

local strsub  = string.sub
local strmatch = string.match

Engine.compressGUID = setmetatable({}, { __index = function(t, guid)
        if not guid then return nil end
        local str
        if strsub(guid, 1, 6) ~= "Player" then
            -- Non-player GUID (pet) — find the owner's suffix via activePets
            for unit, pguid in pairs(Engine.activePets) do
                if pguid == guid and UnitExists(unit) then
                    str = "p-" .. strmatch(UnitGUID(unit), "^%w*-([-%w]*)$")
                end
            end
            -- Friendly NPC/vehicle/out-of-group pet: use raw GUID as-is
            -- parseDirect/parseChannel already do `decompressCache[tgt] or tgt`
            -- so the raw GUID passes through correctly to addTarget()
            if not str then str = guid end
        else
            str = strmatch(guid, "^%w*-([-%w]*)$")
        end
        rawset(t, guid, str)
        return str
    end })

Engine.decompressGUID = setmetatable({}, { __index = function(t, short)
        if not short then return nil end
        local guid
        if strsub(short, 1, 2) == "p-" then
            -- Pet GUID: look up owner unit from unitMap, then get pet GUID from activePets
            local ownerGUID = "Player-" .. strsub(short, 3)
            local ownerUnit = Engine.unitMap[ownerGUID]
            if not ownerUnit then return nil end
            guid = Engine.activePets[ownerUnit]
        elseif short:find("^%a+%-") and strsub(short, 1, 6) ~= "Player" then
            -- Raw GUID passed through from compressGUID (NPC/vehicle/out-of-group pet)
            guid = short
        else
            guid = "Player-" .. short
        end
        if guid then rawset(t, short, guid) end
        return guid
    end })

---------------------------------------------------------------------------
-- Callback system (via CallbackHandler-1.0)
---------------------------------------------------------------------------
if not Engine.callbacks then
    Engine.callbacks = LibStub("CallbackHandler-1.0"):New(Engine)
end

---------------------------------------------------------------------------
-- Tooltip for scanning (relic item IDs)
---------------------------------------------------------------------------
if not Engine.scanTip then
    local tip = CreateFrame("GameTooltip")
    tip:SetOwner(UIParent, "ANCHOR_NONE")
    tip.left  = tip:CreateFontString()
    tip.right = tip:CreateFontString()
    tip:AddFontStrings(tip.left, tip.right)
    Engine.scanTip = tip
end

---------------------------------------------------------------------------
-- Unit → pet mapping
---------------------------------------------------------------------------
if not Engine.petLookup then
    Engine.petLookup = {}
    for i = 1, MAX_PARTY_MEMBERS do
        Engine.petLookup["party" .. i] = "partypet" .. i
    end
    for i = 1, MAX_RAID_MEMBERS do
        Engine.petLookup["raid" .. i] = "raidpet" .. i
    end
    Engine.petLookup["player"] = "pet"
end

---------------------------------------------------------------------------
-- RECORD MANAGEMENT — Hash-based O(1) operations
---------------------------------------------------------------------------
-- A "spell record" holds per-target entries:
--   record = {
--       healType  = DIRECT/HOT/CHANNEL/BOMB,
--       spellID   = number,
--       spellName = string,
--       endTime   = number,
--       interval  = number (tick interval, nil for direct),
--       totalTicks = number,
--       multiTarget = bool,
--       hasBomb   = bool,
--       targets   = { [guid] = { amount, stacks, endTime, ticksLeft } },
--   }

local function newRecord(healType, spellID, spellName)
    return {
        healType   = healType,
        spellID    = spellID,
        spellName  = spellName,
        endTime    = 0,
        interval   = 0,
        totalTicks = 0,
        multiTarget = false,
        hasBomb    = false,
        targets    = {},
    }
end

local function addTarget(record, guid, amount, stacks, endTime, ticksLeft)
    record.targets[guid] = record.targets[guid] or {}
    local e = record.targets[guid]
    e[1] = amount
    e[2] = stacks or 1
    e[3] = endTime or 0
    e[4] = ticksLeft or 0

    if record.healType == HOT or record.healType == CHANNEL then
        hotCount[guid] = (hotCount[guid] or 0) + 1
    end
end

local function dropTarget(record, guid)
    if not record.targets[guid] then return end
    record.targets[guid] = nil

    if record.healType == HOT or record.healType == CHANNEL then
        if hotCount[guid] then
            hotCount[guid] = hotCount[guid] - 1
            if hotCount[guid] <= 0 then hotCount[guid] = nil end
        end
    end
end

local function wipeAllTargets(record)
    for guid in pairs(record.targets) do
        dropTarget(record, guid)
    end
end

local function purgeGUID(guid)
    for caster, spells in pairs(inbound) do
        for sid, rec in pairs(spells) do
            if rec.targets[guid] then
                dropTarget(rec, guid)
                if not next(rec.targets) then spells[sid] = nil end
            end
        end
        if not next(spells) then inbound[caster] = nil end
    end
    for caster, spells in pairs(ticking) do
        for sname, rec in pairs(spells) do
            if rec.targets[guid] then
                dropTarget(rec, guid)
                if not next(rec.targets) then spells[sname] = nil end
            end
        end
        if not next(spells) then ticking[caster] = nil end
    end
end

local function purgeAll()
    for caster, spells in pairs(inbound) do
        for sid, rec in pairs(spells) do wipeAllTargets(rec) end
    end
    for caster, spells in pairs(ticking) do
        for sname, rec in pairs(spells) do wipeAllTargets(rec) end
    end
    wipe(inbound)
    wipe(ticking)
    wipe(hotCount)
end

-- Export record management for downstream files
Engine.newRecord      = newRecord
Engine.addTarget      = addTarget
Engine.dropTarget     = dropTarget
Engine.wipeAllTargets = wipeAllTargets
Engine.purgeGUID      = purgeGUID
Engine.purgeAll       = purgeAll

---------------------------------------------------------------------------
-- Seen healers (for raid check)
---------------------------------------------------------------------------
if not Engine.seenHealers then Engine.seenHealers = {} end

function Engine:GUIDHasHealed(guid)
    return Engine.seenHealers[guid] or false
end

---------------------------------------------------------------------------
-- PUBLIC API — GetHealModifier
---------------------------------------------------------------------------
function Engine:GetHealModifier(guid)
    return targetMods[guid] or 1
end

---------------------------------------------------------------------------
-- PUBLIC API — GetHealAmount (single caster or all)
---------------------------------------------------------------------------
local bit_band  = bit.band
local mathfloor = math.floor
local mathmin   = math.min
local mathmax   = math.max
local GetTime   = GetTime

function Engine:GetHealAmount(guid, typeMask, timeLimit, casterFilter)
    local total = 0
    local now = GetTime()
    typeMask = typeMask or ALL

    local function scanCaster(casterGUID)
        local spells = inbound[casterGUID]
        if spells then
            for _, rec in pairs(spells) do
                if bit_band(rec.healType, typeMask) > 0 then
                    local e = rec.targets[guid]
                    if e then
                        local eTime = e[3] > 0 and e[3] or rec.endTime
                        if eTime > now then
                            if rec.healType == DIRECT or rec.healType == BOMB then
                                if not timeLimit or eTime <= timeLimit then
                                    total = total + e[1] * e[2]
                                end
                            elseif rec.healType == CHANNEL or rec.healType == HOT then
                                local ticksLeft = e[4]
                                local secLeft = eTime - now
                                local band = timeLimit and (timeLimit - now) or secLeft
                                local numTicks = mathfloor(mathmin(band, secLeft) / rec.interval)
                                local nextIn = secLeft % rec.interval
                                local frac = band % rec.interval
                                if nextIn > 0 and nextIn < frac then numTicks = numTicks + 1 end
                                numTicks = mathmin(numTicks, ticksLeft)
                                total = total + e[1] * e[2] * numTicks
                            end
                        end
                    end
                end
            end
        end
        local tspells = ticking[casterGUID]
        if tspells then
            for _, rec in pairs(tspells) do
                if bit_band(rec.healType, typeMask) > 0 then
                    local e = rec.targets[guid]
                    if e then
                        local eTime = e[3] > 0 and e[3] or rec.endTime
                        if eTime > now then
                            local ticksLeft = e[4]
                            local secLeft = eTime - now
                            local band = timeLimit and (timeLimit - now) or secLeft
                            local numTicks = mathfloor(mathmin(band, secLeft) / rec.interval)
                            local nextIn = secLeft % rec.interval
                            local frac = band % rec.interval
                            if nextIn > 0 and nextIn < frac then numTicks = numTicks + 1 end
                            numTicks = mathmin(numTicks, ticksLeft)
                            total = total + e[1] * e[2] * numTicks
                        end
                    end
                end
            end
        end
    end

    if casterFilter then
        scanCaster(casterFilter)
    else
        for casterGUID in pairs(inbound) do scanCaster(casterGUID) end
        for casterGUID in pairs(ticking) do
            if not inbound[casterGUID] then scanCaster(casterGUID) end
        end
    end

    return total > 0 and total or nil
end

---------------------------------------------------------------------------
-- PUBLIC API — GetOthersHealAmount (everyone except player)
---------------------------------------------------------------------------
function Engine:GetOthersHealAmount(guid, typeMask, timeLimit)
    local total = 0
    local now = GetTime()
    typeMask = typeMask or ALL
    local myG = Engine.myGUID

    local function accum(store)
        for casterGUID, spells in pairs(store) do
            if casterGUID ~= myG then
                for _, rec in pairs(spells) do
                    if bit_band(rec.healType, typeMask) > 0 then
                        local e = rec.targets[guid]
                        if e then
                            local eTime = e[3] > 0 and e[3] or rec.endTime
                            if eTime > now then
                                if rec.healType == DIRECT or rec.healType == BOMB then
                                    if not timeLimit or eTime <= timeLimit then
                                        total = total + e[1] * e[2]
                                    end
                                else
                                    local ticksLeft = e[4]
                                    local secLeft = eTime - now
                                    local band = timeLimit and (timeLimit - now) or secLeft
                                    local numTicks = mathfloor(mathmin(band, secLeft) / rec.interval)
                                    local nextIn = secLeft % rec.interval
                                    local frac = band % rec.interval
                                    if nextIn > 0 and nextIn < frac then numTicks = numTicks + 1 end
                                    numTicks = mathmin(numTicks, ticksLeft)
                                    total = total + e[1] * e[2] * numTicks
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    accum(inbound)
    accum(ticking)

    return total > 0 and total or nil
end

---------------------------------------------------------------------------
-- PUBLIC API — GetHealAmountEx (split self vs others, with timeframes)
-- Returns: othersInTime, othersBeyondTime, selfInTime, selfBeyondTime
---------------------------------------------------------------------------
function Engine:GetHealAmountEx(dstGUID, dstMask, dstTime, srcGUID, srcMask, srcTime)
    local otherIn, otherAll, selfIn, selfAll = 0, 0, 0, 0
    local now = GetTime()
    dstMask = dstMask or ALL
    srcMask = srcMask or ALL

    local stores = { inbound, ticking }

    for si = 1, 2 do
        local store = stores[si]
        for casterGUID, spells in pairs(store) do
            local isSelf = (casterGUID == srcGUID)
            local mask = isSelf and srcMask or dstMask
            local limit = isSelf and srcTime or dstTime

            for _, rec in pairs(spells) do
                if bit_band(rec.healType, mask) > 0 then
                    local e = rec.targets[dstGUID]
                    if e then
                        local eTime = e[3] > 0 and e[3] or rec.endTime
                        if eTime > now then
                            local inTime, allTime = 0, 0

                            if rec.healType == DIRECT or rec.healType == BOMB then
                                local amt = e[1] * e[2]
                                if not limit or eTime <= limit then
                                    inTime = amt
                                end
                                allTime = amt
                            else
                                local ticksLeft = e[4]
                                local secLeft = eTime - now

                                if limit then
                                    local band = mathmax(limit - now, 0)
                                    local n = mathfloor(mathmin(band, secLeft) / rec.interval)
                                    local nextIn = secLeft % rec.interval
                                    local frac = band % rec.interval
                                    if nextIn > 0 and nextIn < frac then n = n + 1 end
                                    inTime = e[1] * e[2] * mathmin(n, ticksLeft)
                                else
                                    inTime = e[1] * e[2] * ticksLeft
                                end

                                allTime = e[1] * e[2] * ticksLeft
                            end

                            if isSelf then
                                selfIn  = selfIn  + inTime
                                selfAll = selfAll + allTime
                            else
                                otherIn  = otherIn  + inTime
                                otherAll = otherAll + allTime
                            end
                        end
                    end
                end
            end
        end
    end

    otherAll = otherAll - otherIn
    selfAll  = selfAll  - selfIn

    return (otherIn  > 0 and otherIn  or nil),
           (otherAll > 0 and otherAll or nil),
           (selfIn   > 0 and selfIn   or nil),
           (selfAll  > 0 and selfAll  or nil)
end

---------------------------------------------------------------------------
-- PUBLIC API — GetCasterHealAmount (total across all targets for a caster)
---------------------------------------------------------------------------
function Engine:GetCasterHealAmount(casterGUID, typeMask, timeLimit)
    local total = 0
    local now = GetTime()
    typeMask = typeMask or ALL

    local function scanStore(store)
        local spells = store[casterGUID]
        if not spells then return end
        for _, rec in pairs(spells) do
            if bit_band(rec.healType, typeMask) > 0 then
                for _, e in pairs(rec.targets) do
                    local eTime = e[3] > 0 and e[3] or rec.endTime
                    if eTime > now then
                        if rec.healType == DIRECT or rec.healType == BOMB then
                            if not timeLimit or eTime <= timeLimit then
                                total = total + e[1] * e[2]
                            end
                        else
                            local ticksLeft = e[4]
                            local secLeft = eTime - now
                            local band = timeLimit and (timeLimit - now) or secLeft
                            local numTicks = mathfloor(mathmin(band, secLeft) / rec.interval)
                            local nextIn = secLeft % rec.interval
                            local frac = band % rec.interval
                            if nextIn > 0 and nextIn < frac then numTicks = numTicks + 1 end
                            numTicks = mathmin(numTicks, ticksLeft)
                            total = total + e[1] * e[2] * numTicks
                        end
                    end
                end
            end
        end
    end

    scanStore(inbound)
    scanStore(ticking)

    return total > 0 and total or nil
end

---------------------------------------------------------------------------
-- PUBLIC API — GetGUIDUnitMapTable (read-only proxy)
---------------------------------------------------------------------------
local unitMap = Engine.unitMap

if not Engine.unitMapProxy then
    Engine.unitMapProxy = setmetatable({}, {
        __index    = function(_, k) return unitMap[k] end,
        __newindex = function() error("Read-only table", 2) end,
        __metatable = false,
    })
end

function Engine:GetGUIDUnitMapTable()
    return Engine.unitMapProxy
end

---------------------------------------------------------------------------
-- PUBLIC API — GetPlayerHealingMod
-- Returns the player's personal healing output modifier (debuffs like
-- Stolen Soul, Vile Slime, etc.)
---------------------------------------------------------------------------
function Engine:GetPlayerHealingMod()
    return Engine.myHealMod or 1
end

---------------------------------------------------------------------------
-- PUBLIC API — GetNumHeals
-- Counts direct heals being cast on a given GUID (optionally within time)
---------------------------------------------------------------------------
function Engine:GetNumHeals(guid, typeMask, timeLimit)
    local num = 0
    local now = GetTime()
    typeMask = typeMask or ALL

    for casterGUID, spells in pairs(inbound) do
        for _, rec in pairs(spells) do
            if bit_band(rec.healType, typeMask) > 0 then
                local e = rec.targets[guid]
                if e then
                    local eTime = e[3] > 0 and e[3] or rec.endTime
                    if eTime > now then
                        if not timeLimit or eTime <= timeLimit then
                            num = num + 1
                        end
                    end
                end
            end
        end
    end

    return num
end

---------------------------------------------------------------------------
-- PUBLIC API — GetNextHealAmount
-- Returns: endTime, casterGUID, amount for the next incoming heal on guid
---------------------------------------------------------------------------
function Engine:GetNextHealAmount(guid, typeMask, timeLimit, ignoreGUID, srcGUID)
    local healTime, healAmount, healFrom
    local now = GetTime()
    typeMask = typeMask or ALL

    local stores = { inbound, ticking }
    for si = 1, 2 do
        local store = stores[si]
        for casterGUID, spells in pairs(store) do
            if (not ignoreGUID or ignoreGUID ~= casterGUID) and (not srcGUID or srcGUID == casterGUID) then
                for _, rec in pairs(spells) do
                    if bit_band(rec.healType, typeMask) > 0 then
                        local e = rec.targets[guid]
                        if e then
                            local eTime = e[3] > 0 and e[3] or rec.endTime
                            if eTime > now then
                                if rec.healType == DIRECT or rec.healType == BOMB then
                                    if not timeLimit or eTime <= timeLimit then
                                        if not healTime or eTime < healTime then
                                            healTime = eTime
                                            healAmount = e[1] * e[2]
                                            healFrom = casterGUID
                                        end
                                    end
                                elseif rec.healType == CHANNEL or rec.healType == HOT then
                                    local secLeft = eTime - now
                                    local nextTick = now + (secLeft % (rec.interval > 0 and rec.interval or 1))
                                    if not timeLimit or nextTick <= timeLimit then
                                        if not healTime or nextTick < healTime then
                                            healTime = nextTick
                                            healAmount = e[1] * e[2]
                                            healFrom = casterGUID
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return healTime, healFrom, healAmount
end

---------------------------------------------------------------------------
-- PUBLIC API — GetHealAmountSorted
-- Returns: otherBefore, selfAmount, otherAfter, myHotAmount, otherHotAmount
---------------------------------------------------------------------------
function Engine:GetHealAmountSorted(dstGUID, otherMask, selfMask)
    local otherBefore, selfAmount, otherAfter, hotAmount, otherHotAmount = 0, 0, 0, 0, 0
    local now = GetTime()
    local myG = Engine.myGUID
    otherMask = otherMask or ALL
    selfMask = selfMask or ALL

    local myEndTime = 1/0
    local mySpells = inbound[myG]
    if mySpells then
        for _, rec in pairs(mySpells) do
            if rec.healType == DIRECT or rec.healType == CHANNEL then
                local e = rec.targets[dstGUID]
                if e then
                    local eTime = e[3] > 0 and e[3] or rec.endTime
                    if eTime > now and eTime < myEndTime then
                        myEndTime = eTime
                    end
                end
            end
        end
    end

    local stores = { inbound, ticking }
    for si = 1, 2 do
        local store = stores[si]
        for casterGUID, spells in pairs(store) do
            local isSelf = (casterGUID == myG)
            local mask = isSelf and selfMask or otherMask

            for _, rec in pairs(spells) do
                if bit_band(rec.healType, mask) > 0 then
                    local e = rec.targets[dstGUID]
                    if e then
                        local eTime = e[3] > 0 and e[3] or rec.endTime
                        if eTime > now then
                            local amt = 0
                            if rec.healType == DIRECT or rec.healType == BOMB then
                                amt = e[1] * e[2]
                            elseif rec.healType == CHANNEL or rec.healType == HOT then
                                amt = e[1] * e[2] * e[4]
                            end

                            if amt > 0 then
                                if rec.healType == HOT then
                                    -- Split HoTs by caster into dedicated slots
                                    -- so foreign HoTs render with OtherHoT color
                                    -- rather than borrowing the my-color palette.
                                    if isSelf then
                                        hotAmount = hotAmount + amt
                                    else
                                        otherHotAmount = otherHotAmount + amt
                                    end
                                elseif isSelf then
                                    selfAmount = selfAmount + amt
                                else
                                    if eTime <= myEndTime then
                                        otherBefore = otherBefore + amt
                                    else
                                        otherAfter = otherAfter + amt
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return otherBefore, selfAmount, otherAfter, hotAmount, otherHotAmount
end

---------------------------------------------------------------------------
-- PUBLIC API — GetHealAmountByCaster
-- Returns heals grouped by caster for class-colored bars
-- Format: { {casterGUID, amount, isSelf, endTime, spellType}, ... }
-- Sorted by landing time (earliest first)
---------------------------------------------------------------------------
function Engine:GetHealAmountByCaster(dstGUID, mask)
    if not dstGUID then return {} end
    mask = mask or ALL
    local now = GetTime()
    local myG = Engine.myGUID
    local result = {}
    
    local stores = { inbound, ticking }
    for si = 1, 2 do
        local store = stores[si]
        for casterGUID, spells in pairs(store) do
            local isSelf = (casterGUID == myG)
            local casterTotal = 0
            local earliestEnd = 1/0
            local hasDirect = false
            local hasHot = false
            
            for _, rec in pairs(spells) do
                if bit_band(rec.healType, mask) > 0 then
                    local e = rec.targets[dstGUID]
                    if e then
                        local eTime = e[3] > 0 and e[3] or rec.endTime
                        if eTime > now then
                            local amt = 0
                            if rec.healType == DIRECT or rec.healType == BOMB then
                                amt = e[1] * e[2]
                                hasDirect = true
                            elseif rec.healType == CHANNEL or rec.healType == HOT then
                                amt = e[1] * e[2] * e[4]
                                hasHot = true
                            end
                            casterTotal = casterTotal + amt
                            if eTime < earliestEnd then
                                earliestEnd = eTime
                            end
                        end
                    end
                end
            end
            
            if casterTotal > 0 then
                table.insert(result, {
                    caster = casterGUID,
                    amount = casterTotal,
                    isSelf = isSelf,
                    endTime = earliestEnd,
                    spellType = hasDirect and (hasHot and "both" or "direct") or "hot"
                })
            end
        end
    end
    
    -- Sort by landing time (earliest first), self heals prioritized
    table.sort(result, function(a, b)
        if a.isSelf ~= b.isSelf then
            return a.isSelf -- Self heals first
        end
        return a.endTime < b.endTime
    end)
    
    return result
end

---------------------------------------------------------------------------
-- PUBLIC API — GetActiveCasterCount
-- Returns the number of unique caster GUIDs with active heals on a target
---------------------------------------------------------------------------
function Engine:GetActiveCasterCount(dstGUID)
    if not dstGUID then return 0 end
    local casters = {}
    local now = GetTime()

    local stores = { inbound, ticking }
    for si = 1, 2 do
        local store = stores[si]
        for casterGUID, spells in pairs(store) do
            if not casters[casterGUID] then
                for _, rec in pairs(spells) do
                    local e = rec.targets[dstGUID]
                    if e then
                        local eTime = e[3] > 0 and e[3] or rec.endTime
                        if eTime > now then
                            casters[casterGUID] = true
                            break
                        end
                    end
                end
            end
        end
    end

    local count = 0
    for _ in pairs(casters) do count = count + 1 end
    return count
end

---------------------------------------------------------------------------
-- PUBLIC API — GetHealTimeline
-- Returns individual heal entries for a target, sorted by landing time.
-- Each entry: { caster, spellName, amount, landTime, healType, isSelf }
-- Used by the Heal Queue Timeline display.
---------------------------------------------------------------------------
function Engine:GetHealTimeline(dstGUID, lookahead)
    if not dstGUID then return {} end
    local now = GetTime()
    local cutoff = lookahead and (now + lookahead) or (now + 10)
    local myG = Engine.myGUID
    local result = {}

    local stores = { inbound, ticking }
    for si = 1, 2 do
        local store = stores[si]
        for casterGUID, spells in pairs(store) do
            local isSelf = (casterGUID == myG)
            for _, rec in pairs(spells) do
                local e = rec.targets[dstGUID]
                if e then
                    if rec.healType == DIRECT or rec.healType == BOMB then
                        local eTime = e[3] > 0 and e[3] or rec.endTime
                        if eTime > now and eTime <= cutoff then
                            table.insert(result, {
                                caster    = casterGUID,
                                spellName = rec.spellName,
                                amount    = e[1] * e[2],
                                landTime  = eTime,
                                healType  = rec.healType,
                                isSelf    = isSelf,
                            })
                        end
                    elseif rec.healType == CHANNEL or rec.healType == HOT then
                        local eTime = e[3] > 0 and e[3] or rec.endTime
                        if eTime > now then
                            local interval = rec.interval > 0 and rec.interval or 1
                            local secLeft = eTime - now
                            local nextTick = now + (secLeft % interval)
                            if nextTick <= now then nextTick = nextTick + interval end
                            -- Add each upcoming tick within the lookahead window
                            while nextTick <= cutoff and nextTick <= eTime do
                                table.insert(result, {
                                    caster    = casterGUID,
                                    spellName = rec.spellName,
                                    amount    = e[1] * e[2],
                                    landTime  = nextTick,
                                    healType  = rec.healType,
                                    isSelf    = isSelf,
                                })
                                nextTick = nextTick + interval
                            end
                        end
                    end
                end
            end
        end
    end

    table.sort(result, function(a, b)
        return a.landTime < b.landTime
    end)

    return result
end
