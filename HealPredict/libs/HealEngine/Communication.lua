-- Communication.lua — Wire Protocol, Parsing, Bucket System
-- Part of HealEngine-1.0 split architecture
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn

local Engine = LibStub("HealEngine-1.0")
if not Engine then return end

---------------------------------------------------------------------------
-- Local aliases from Engine
---------------------------------------------------------------------------
local WIRE_PREFIX    = Engine.WIRE_PREFIX
local inbound        = Engine.inbound
local ticking        = Engine.ticking
local unitMap        = Engine.unitMap
local hotCount       = Engine.hotCount
local decompressCache = Engine.decompressGUID
local compressCache   = Engine.compressGUID
local newRecord      = Engine.newRecord
local addTarget      = Engine.addTarget
local dropTarget     = Engine.dropTarget
local wipeAllTargets = Engine.wipeAllTargets

local DIRECT  = Engine._DIRECT
local CHANNEL = Engine._CHANNEL
local HOT     = Engine._HOT
local BOMB    = Engine._BOMB
local TICKING = Engine._TICKING

local bit_band  = bit.band
local mathmax   = math.max
local GetTime   = GetTime
local GetSpellInfo = GetSpellInfo
local strmatch  = string.match
local strsplit  = strsplit
local strformat = string.format
local strlen    = strlen
local select    = select
local pairs     = pairs
local next      = next
local wipe      = wipe
local tinsert   = table.insert
local tconcat   = table.concat
local unpack    = unpack
local UnitName  = UnitName
local IsInRaid  = IsInRaid
local IsInGroup = IsInGroup
local C_ChatInfo = C_ChatInfo

---------------------------------------------------------------------------
-- COMMUNICATION — Send messages via addon channel
-- Uses ChatThrottleLib for rate-limiting to prevent disconnects in 25-man
---------------------------------------------------------------------------
local distChannel   -- "PARTY" / "RAID" / "INSTANCE_CHAT" / nil
local instType
local CTL = _G.ChatThrottleLib

local function sendWire(msg)
    if distChannel and strlen(msg) <= 240 then
        if CTL then
            CTL:SendAddonMessage("BULK", WIRE_PREFIX, msg, distChannel)
        else
            C_ChatInfo.SendAddonMessage(WIRE_PREFIX, msg, distChannel)
        end
    end
end

local function updateChannel()
    if instType == "pvp" or instType == "arena" or IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        distChannel = "INSTANCE_CHAT"
    elseif IsInRaid() then
        distChannel = "RAID"
    elseif IsInGroup() then
        distChannel = "PARTY"
    else
        distChannel = nil
    end
end

---------------------------------------------------------------------------
-- PARSING DIRECT HEALS (local + remote)
---------------------------------------------------------------------------
local function parseDirect(casterGUID, spellID, amount, duration, ...)
    if not casterGUID then return end
    inbound[casterGUID] = inbound[casterGUID] or {}
    local rec = newRecord(DIRECT, spellID, GetSpellInfo(spellID) or "")
    rec.endTime = GetTime() + duration
    inbound[casterGUID][spellID] = rec

    for i = 1, select("#", ...) do
        local tgt = select(i, ...)
        local guid = decompressCache[tgt] or tgt
        if guid then
            addTarget(rec, guid, amount, 1, rec.endTime, 0)
        end
    end
end

---------------------------------------------------------------------------
-- PARSING CHANNEL HEALS
---------------------------------------------------------------------------
local function parseChannel(casterGUID, spellID, perTick, numTicks, ...)
    if not casterGUID then return end
    local spellName = GetSpellInfo(spellID) or ""
    ticking[casterGUID] = ticking[casterGUID] or {}
    local rec = newRecord(CHANNEL, spellID, spellName)
    rec.interval   = 1
    rec.totalTicks = numTicks
    rec.endTime    = GetTime() + numTicks * rec.interval
    ticking[casterGUID][spellName] = rec

    for i = 1, select("#", ...) do
        local tgt = select(i, ...)
        local guid = decompressCache[tgt] or tgt
        if guid then
            addTarget(rec, guid, perTick, 1, rec.endTime, numTicks)
        end
    end
end

---------------------------------------------------------------------------
-- PARSING HOT HEALS
---------------------------------------------------------------------------
local function parseHoT(casterGUID, isRefresh, spellID, perTick, numTicks, interval, ...)
    if not casterGUID then return end
    local spellName = GetSpellInfo(spellID) or ""
    ticking[casterGUID] = ticking[casterGUID] or {}

    -- If refreshing an existing HoT, drop old targets first
    local old = ticking[casterGUID][spellName]
    if old and isRefresh then
        for i = 1, select("#", ...) do
            local tgt = select(i, ...)
            local guid = decompressCache[tgt] or tgt
            if guid and old.targets[guid] then
                dropTarget(old, guid)
            end
        end
    end

    local rec = old or newRecord(HOT, spellID, spellName)
    rec.spellID    = spellID
    rec.interval   = interval
    rec.totalTicks = numTicks
    rec.endTime    = GetTime() + numTicks * interval
    rec.multiTarget = (select("#", ...) > 1)
    ticking[casterGUID][spellName] = rec

    for i = 1, select("#", ...) do
        local tgt = select(i, ...)
        local guid = decompressCache[tgt] or tgt
        if guid then
            addTarget(rec, guid, perTick, 1, rec.endTime, numTicks)
        end
    end
end

---------------------------------------------------------------------------
-- PARSING BOMB (Lifebloom bloom component)
---------------------------------------------------------------------------
local function parseBomb(casterGUID, isRefresh, spellID, bombAmt, ...)
    if not casterGUID then return end
    local spellName = (GetSpellInfo(spellID) or "") .. "_bomb"
    inbound[casterGUID] = inbound[casterGUID] or {}

    local rec = newRecord(BOMB, spellID, spellName)
    -- Bomb goes off when HoT expires — find corresponding HoT
    local hotRec = ticking[casterGUID] and ticking[casterGUID][GetSpellInfo(spellID) or ""]
    rec.endTime = hotRec and hotRec.endTime or (GetTime() + 7)
    inbound[casterGUID][spellName] = rec

    for i = 1, select("#", ...) do
        local tgt = select(i, ...)
        local guid = decompressCache[tgt] or tgt
        if guid then
            addTarget(rec, guid, bombAmt, 1, rec.endTime, 0)
        end
    end
end

---------------------------------------------------------------------------
-- STOP / REMOVE HEALS
---------------------------------------------------------------------------
local function stopDirect(casterGUID, spellID, ...)
    local spells = inbound[casterGUID]
    if not spells then return end
    local rec = spells[spellID]
    if not rec then return end

    local count = select("#", ...)
    if count == 0 then
        -- Remove all targets
        wipeAllTargets(rec)
        spells[spellID] = nil
    else
        for i = 1, count do
            local tgt = select(i, ...)
            local guid = decompressCache[tgt] or tgt
            if guid then dropTarget(rec, guid) end
        end
        if not next(rec.targets) then spells[spellID] = nil end
    end
    if not next(spells) then inbound[casterGUID] = nil end
end

local function stopHoT(casterGUID, spellID, ...)
    local spellName = GetSpellInfo(spellID) or ""
    local spells = ticking[casterGUID]
    if not spells then return end
    local rec = spells[spellName]
    if not rec then return end

    local count = select("#", ...)
    if count == 0 then
        wipeAllTargets(rec)
        spells[spellName] = nil
    else
        for i = 1, count do
            local tgt = select(i, ...)
            local guid = decompressCache[tgt] or tgt
            if guid then dropTarget(rec, guid) end
        end
        if not next(rec.targets) then spells[spellName] = nil end
    end
    if not next(spells) then ticking[casterGUID] = nil end

    -- Also remove bomb if exists
    local bombName = spellName .. "_bomb"
    local bombSpells = inbound[casterGUID]
    if bombSpells and bombSpells[bombName] then
        wipeAllTargets(bombSpells[bombName])
        bombSpells[bombName] = nil
        if not next(bombSpells) then inbound[casterGUID] = nil end
    end
end

---------------------------------------------------------------------------
-- BUCKET SYSTEM — group multi-target heal events within a small window
---------------------------------------------------------------------------
local BUCKET_WINDOW = 0.3
if not Engine.buckets then Engine.buckets = {} end
local buckets = Engine.buckets

local bucketFrame = Engine.bucketFrame or CreateFrame("Frame")
Engine.bucketFrame = bucketFrame
bucketFrame:Hide()
bucketFrame:SetScript("OnUpdate", function(self, elapsed)
    local anyLeft = false
    for casterGUID, spellBuckets in pairs(buckets) do
        for spellName, bucket in pairs(spellBuckets) do
            bucket.timer = bucket.timer - elapsed
            if bucket.timer <= 0 then
                if #bucket > 0 and bucket.spellID then
                    if bucket.kind == "tick" then
                        local rec = ticking[casterGUID] and ticking[casterGUID][spellName]
                        if rec and rec.healType then
                            local e = rec.targets[bucket[1]]
                            local eTime = e and e[3] or rec.endTime
                            Engine.callbacks:Fire("HealComm_HealUpdated", casterGUID, rec.spellID, rec.healType, eTime, unpack(bucket))
                        end
                    end
                end
                wipe(bucket)
                spellBuckets[spellName] = nil
            else
                anyLeft = true
            end
        end
        if not next(spellBuckets) then buckets[casterGUID] = nil end
    end
    if not anyLeft then self:Hide() end
end)

---------------------------------------------------------------------------
-- DECOMPRESS HELPER — convert compressed target CSV to full GUIDs for callbacks
---------------------------------------------------------------------------
local decompTmp = {}
local function decompressTargets(compressedCSV)
    wipe(decompTmp)
    local parts = { strsplit(",", compressedCSV) }
    for i = 1, #parts do
        local full = decompressCache[parts[i]] or parts[i]
        if full then decompTmp[i] = full end
    end
    return unpack(decompTmp, 1, #parts)
end

---------------------------------------------------------------------------
-- INCOMING MESSAGE PARSER (LHC40 wire protocol)
---------------------------------------------------------------------------
local Ambiguate = Ambiguate

local function onWireMessage(prefix, msg, channel, sender)
    if prefix ~= WIRE_PREFIX then return end

    local senderGUID
    -- Resolve sender name to GUID (Ambiguate strips realm suffix for connected/merged realms)
    local shortSender = Ambiguate(sender, "short")
    for guid, unit in pairs(unitMap) do
        if unit and UnitName(unit) == shortSender then
            senderGUID = guid
            break
        end
    end
    if not senderGUID then return end
    if senderGUID == Engine.myGUID then return end  -- we handle our own locally

    Engine.seenHealers[senderGUID] = true

    local msgType, rest = strmatch(msg, "^(%a+):(.+)$")
    if not msgType then return end

    -- D:duration:spellID:amount:targets
    if msgType == "D" then
        local dur, sid, amt, tgts = strmatch(rest, "([^:]+):([^:]+):([^:]+):(.+)")
        if dur and sid and amt and tgts then
            parseDirect(senderGUID, tonumber(sid), tonumber(amt), tonumber(dur), strsplit(",", tgts))
            local endT = GetTime() + tonumber(dur)
            Engine.callbacks:Fire("HealComm_HealStarted", senderGUID, tonumber(sid), DIRECT, endT, decompressTargets(tgts))
        end

    -- C::spellID:amount:ticks:targets
    elseif msgType == "C" then
        local sid, amt, tk, tgts = strmatch(rest, ":([^:]+):([^:]+):([^:]+):(.+)")
        if sid and amt and tk and tgts then
            parseChannel(senderGUID, tonumber(sid), tonumber(amt), tonumber(tk), strsplit(",", tgts))
            Engine.callbacks:Fire("HealComm_HealStarted", senderGUID, tonumber(sid), CHANNEL, GetTime() + tonumber(tk), decompressTargets(tgts))
        end

    -- H:totalTicks:spellID:amount::interval:targets
    elseif msgType == "H" then
        local tks, sid, amt, intv, tgts = strmatch(rest, "([^:]+):([^:]+):([^:]+)::([^:]+):(.+)")
        if tks and sid and amt and intv and tgts then
            parseHoT(senderGUID, false, tonumber(sid), tonumber(amt), tonumber(tks), tonumber(intv), strsplit(",", tgts))
            Engine.callbacks:Fire("HealComm_HealStarted", senderGUID, tonumber(sid), HOT, GetTime() + tonumber(tks) * tonumber(intv), decompressTargets(tgts))
        end

    -- B:totalTicks:spellID:bombAmount:bombTargets:hotAmount::interval:hotTargets
    elseif msgType == "B" then
        local tks, sid, bAmt, bTgts, hAmt, intv, hTgts = strmatch(rest, "([^:]+):([^:]+):([^:]+):([^:]+):([^:]+)::([^:]+):(.+)")
        if tks and sid and bAmt and hAmt and intv and hTgts then
            parseHoT(senderGUID, false, tonumber(sid), tonumber(hAmt), tonumber(tks), tonumber(intv), strsplit(",", hTgts))
            if bTgts then
                parseBomb(senderGUID, false, tonumber(sid), tonumber(bAmt), strsplit(",", bTgts))
            end
            Engine.callbacks:Fire("HealComm_HealStarted", senderGUID, tonumber(sid), HOT, GetTime() + tonumber(tks) * tonumber(intv), decompressTargets(hTgts))
        end

    -- S:spellID[:targets]
    elseif msgType == "S" then
        local sid, tgts = strmatch(rest, "([^:]+):?(.*)")
        if sid then
            if tgts and tgts ~= "" then
                stopDirect(senderGUID, tonumber(sid), strsplit(",", tgts))
                Engine.callbacks:Fire("HealComm_HealStopped", senderGUID, tonumber(sid), DIRECT, false, decompressTargets(tgts))
            else
                stopDirect(senderGUID, tonumber(sid))
                Engine.callbacks:Fire("HealComm_HealStopped", senderGUID, tonumber(sid), DIRECT, false)
            end
        end

    -- HS:spellID[:targets]
    elseif msgType == "HS" then
        local sid, tgts = strmatch(rest, "([^:]+):?(.*)")
        if sid then
            if tgts and tgts ~= "" then
                stopHoT(senderGUID, tonumber(sid), strsplit(",", tgts))
                Engine.callbacks:Fire("HealComm_HealStopped", senderGUID, tonumber(sid), HOT, false, decompressTargets(tgts))
            else
                stopHoT(senderGUID, tonumber(sid))
                Engine.callbacks:Fire("HealComm_HealStopped", senderGUID, tonumber(sid), HOT, false)
            end
        end

    -- F:duration:spellID:amount:targets  (delayed cast)
    elseif msgType == "F" then
        local dur, sid, amt, tgts = strmatch(rest, "([^:]+):([^:]+):([^:]+):(.+)")
        if dur and sid and amt and tgts then
            -- Update existing direct heal with new duration
            local spells = inbound[senderGUID]
            local rec = spells and spells[tonumber(sid)]
            if rec then
                rec.endTime = GetTime() + tonumber(dur)
                for guid, e in pairs(rec.targets) do
                    e[3] = rec.endTime
                end
            end
            Engine.callbacks:Fire("HealComm_HealDelayed", senderGUID, tonumber(sid), DIRECT, rec and rec.endTime or 0, decompressTargets(tgts))
        end

    -- U:spellID:perTick:numTicks:interval:targets  (HoT update, e.g. Lifebloom stack change)
    elseif msgType == "U" then
        local sid, amt, tks, intv, tgts = strmatch(rest, "([^:]+):([^:]+):([^:]+):([^:]+):(.+)")
        if sid and amt and tgts then
            local spellName = GetSpellInfo(tonumber(sid)) or ""
            local spells = ticking[senderGUID]
            local rec = spells and spells[spellName]
            if rec then
                rec.totalTicks = tonumber(tks) or rec.totalTicks
                rec.interval   = tonumber(intv) or rec.interval
                for i = 1, select("#", strsplit(",", tgts)) do
                    local tgt = select(i, strsplit(",", tgts))
                    local guid = decompressCache[tgt] or tgt
                    if guid and rec.targets[guid] then
                        rec.targets[guid][1] = tonumber(amt)
                    end
                end
                Engine.callbacks:Fire("HealComm_HealUpdated", senderGUID, tonumber(sid), rec.healType, rec.endTime, decompressTargets(tgts))
            end
        end

    -- UB:numTicks:spellID:bombAmt:bombTargets:perTick:interval:hotTargets  (HoT+bomb update)
    elseif msgType == "UB" then
        local tks, sid, bAmt, bTgts, hAmt, intv, hTgts = strmatch(rest, "([^:]+):([^:]+):([^:]+):([^:]+):([^:]+):([^:]+):(.+)")
        if tks and sid and bAmt and hAmt and intv and hTgts then
            local spellName = GetSpellInfo(tonumber(sid)) or ""
            local spells = ticking[senderGUID]
            local rec = spells and spells[spellName]
            if rec then
                rec.totalTicks = tonumber(tks) or rec.totalTicks
                rec.interval   = tonumber(intv) or rec.interval
                for i = 1, select("#", strsplit(",", hTgts)) do
                    local tgt = select(i, strsplit(",", hTgts))
                    local guid = decompressCache[tgt] or tgt
                    if guid and rec.targets[guid] then
                        rec.targets[guid][1] = tonumber(hAmt)
                    end
                end
            end
            -- Update the bomb record too
            local bombName = spellName .. "_bomb"
            local bombSpells = inbound[senderGUID]
            local bombRec = bombSpells and bombSpells[bombName]
            if bombRec then
                for i = 1, select("#", strsplit(",", bTgts)) do
                    local tgt = select(i, strsplit(",", bTgts))
                    local guid = decompressCache[tgt] or tgt
                    if guid and bombRec.targets[guid] then
                        bombRec.targets[guid][1] = tonumber(bAmt)
                    end
                end
            end
            if rec then
                Engine.callbacks:Fire("HealComm_HealUpdated", senderGUID, tonumber(sid), rec.healType, rec.endTime, decompressTargets(hTgts))
            end
        end
    end
end

---------------------------------------------------------------------------
-- Expose on Engine table for downstream files
---------------------------------------------------------------------------
Engine.sendWire       = sendWire
Engine.updateChannel  = updateChannel
Engine.parseDirect    = parseDirect
Engine.parseChannel   = parseChannel
Engine.parseHoT       = parseHoT
Engine.parseBomb      = parseBomb
Engine.stopDirect     = stopDirect
Engine.stopHoT        = stopHoT
Engine.onWireMessage  = onWireMessage
Engine.BUCKET_WINDOW  = BUCKET_WINDOW

-- instType is writable from CastTracking/Init
Engine.instType = instType
Engine.getDistChannel = function() return distChannel end
Engine.setInstType    = function(v) instType = v; Engine.instType = v end
Engine.setDistChannel = function(v) distChannel = v end
