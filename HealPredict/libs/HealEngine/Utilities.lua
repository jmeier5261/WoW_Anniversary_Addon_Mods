-- Utilities.lua — Calculation Helpers, Equipment, Talents
-- Part of HealEngine-1.0 split architecture
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn

local Engine = LibStub("HealEngine-1.0")
if not Engine then return end

---------------------------------------------------------------------------
-- Local aliases from Engine
---------------------------------------------------------------------------
local unitMap    = Engine.unitMap
local talentMods = Engine.talentMods
local gearSets  = Engine.gearSets
local gearCount  = Engine.gearCount
local rankOf     = Engine.rankOf

local mathmin  = math.min
local mathceil = math.ceil
local wipe     = wipe
local pairs    = pairs
local ipairs   = ipairs
local type     = type

local UnitBuff          = UnitBuff
local IsEquippedItem    = IsEquippedItem
local GetInventoryItemLink = GetInventoryItemLink
local GetNumTalentTabs  = GetNumTalentTabs
local GetNumTalents     = GetNumTalents
local GetTalentInfo     = GetTalentInfo
local strmatch          = string.match

---------------------------------------------------------------------------
-- GUID LOOKUP HELPER
---------------------------------------------------------------------------
local function safeUnit(guid)
    return unitMap[guid]
end

---------------------------------------------------------------------------
-- AURA SCANNING — check if unit has buff/debuff by spellID or name
---------------------------------------------------------------------------
local UnitDebuff = UnitDebuff

local function unitHasBuff(unit, query)
    local i = 1
    while true do
        local name, _, stacks, _, _, _, _, _, _, spellID = UnitBuff(unit, i)
        if not name then return nil end
        if type(query) == "number" then
            if spellID == query then return name, stacks, spellID end
        else
            if name == query then return name, stacks, spellID end
        end
        i = i + 1
    end
end

local function unitHasDebuff(unit, query)
    local i = 1
    while true do
        local name, _, stacks, _, _, _, _, _, _, spellID = UnitDebuff(unit, i)
        if not name then return nil end
        if type(query) == "number" then
            if spellID == query then return name, stacks, spellID end
        else
            if name == query then return name, stacks, spellID end
        end
        i = i + 1
    end
end

---------------------------------------------------------------------------
-- DOWNRANK PENALTY (TBC formula)
---------------------------------------------------------------------------
local function downrankPenalty(spellLevel)
    if not spellLevel then return 1 end
    local base = spellLevel > 20 and 1 or (1 - ((20 - spellLevel) * 0.0375))
    -- TBC additional penalty
    local cap = mathmin(1, (spellLevel + 11) / (Engine.myLevel or 70))
    return base * cap
end

---------------------------------------------------------------------------
-- GENERAL HEAL CALCULATION
---------------------------------------------------------------------------
local function computeHeal(spellLevel, baseAmount, spellPower, spCoeff, healMod)
    local penalty = downrankPenalty(spellLevel)
    spellPower = spellPower * spCoeff
    spellPower = spellPower * penalty
    return (baseAmount + spellPower) * healMod
end

---------------------------------------------------------------------------
-- BASE HEAL LOOKUP — picks the last sub-rank entry for the rank
---------------------------------------------------------------------------
local function avg(lo, hi) return (lo + hi) / 2 end

local function baseHeal(data, rank)
    if not data or not data.heals or not rank then return 0 end
    local entry = data.heals[rank]
    if not entry then return 0 end
    -- Entry can be a single number or a table of sub-rank values
    if type(entry) == "table" then
        return entry[#entry]    -- highest sub-rank
    end
    return entry
end

---------------------------------------------------------------------------
-- EQUIPPED SET COUNTING
---------------------------------------------------------------------------
local currentRelic

local function refreshEquipment()
    wipe(gearCount)
    for setName, items in pairs(gearSets) do
        local count = 0
        for _, itemID in ipairs(items) do
            if IsEquippedItem(itemID) then count = count + 1 end
        end
        gearCount[setName] = count
    end
    -- Relic slot (18)
    local link = GetInventoryItemLink("player", 18)
    if link then
        currentRelic = tonumber(strmatch(link, "item:(%d+)"))
    else
        currentRelic = nil
    end
    Engine.currentRelic = currentRelic
end

---------------------------------------------------------------------------
-- TALENT SCANNING
---------------------------------------------------------------------------
local function refreshTalents()
    for name, data in pairs(talentMods) do
        data.value = 0
    end
    for tab = 1, GetNumTalentTabs() do
        for idx = 1, GetNumTalents(tab) do
            local tName, _, _, _, rank = GetTalentInfo(tab, idx)
            if tName and talentMods[tName] then
                talentMods[tName].value = rank * talentMods[tName].step
            end
        end
    end
end

---------------------------------------------------------------------------
-- Expose on Engine table for downstream files
---------------------------------------------------------------------------
Engine.safeUnit         = safeUnit
Engine.unitHasBuff      = unitHasBuff
Engine.unitHasDebuff    = unitHasDebuff
Engine.downrankPenalty   = downrankPenalty
Engine.computeHeal      = computeHeal
Engine.avg              = avg
Engine.baseHeal         = baseHeal
Engine.refreshEquipment = refreshEquipment
Engine.refreshTalents   = refreshTalents
Engine.currentRelic     = currentRelic
