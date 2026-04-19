-- Init.lua — Startup, Event Frame, Secure Hooks
-- Part of HealEngine-1.0 split architecture
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn

local Engine = LibStub("HealEngine-1.0")
if not Engine then return end

---------------------------------------------------------------------------
-- Local aliases from Engine
---------------------------------------------------------------------------
local unitMap   = Engine.unitMap
local groupMap  = Engine.groupMap
local hotCount  = Engine.hotCount

local refreshEquipment = Engine.refreshEquipment
local refreshTalents   = Engine.refreshTalents
local refreshRoster    = Engine.refreshRoster
local onZoneChanged    = Engine.onZoneChanged
local onCombatLog      = Engine.onCombatLog
local onWireMessage    = Engine.onWireMessage
local onCastSent       = Engine.onCastSent
local onCastStart      = Engine.onCastStart
local onCastStop       = Engine.onCastStop
local onCastSucceeded  = Engine.onCastSucceeded
local onCastDelayed    = Engine.onCastDelayed
local onChannelStop    = Engine.onChannelStop
local scanTargetMods   = Engine.scanTargetMods
local setCastTarget    = Engine.setCastTarget

local UnitGUID   = UnitGUID
local UnitName   = UnitName
local UnitLevel  = UnitLevel
local UnitExists = UnitExists
local GetNumTalentTabs = GetNumTalentTabs
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local IsLoggedIn = IsLoggedIn
local next = next

---------------------------------------------------------------------------
-- INITIALIZATION
---------------------------------------------------------------------------
function Engine:OnStartup()
    Engine.myGUID  = UnitGUID("player")
    Engine.myName  = UnitName("player")
    Engine.myLevel = UnitLevel("player")

    unitMap[Engine.myGUID] = "player"

    refreshEquipment()
    refreshTalents()
    refreshRoster()
    onZoneChanged()

    -- Show hot monitor if there are active HoTs
    if next(hotCount) then Engine.hotMonitor:Show() end
end

---------------------------------------------------------------------------
-- EVENT FRAME
---------------------------------------------------------------------------
local evFrame = Engine.evFrame or CreateFrame("Frame")
Engine.evFrame = evFrame
evFrame:UnregisterAllEvents()
evFrame:RegisterEvent("UNIT_PET")

evFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        onCombatLog(CombatLogGetCurrentEventInfo())
    elseif event == "CHAT_MSG_ADDON" then
        onWireMessage(...)
    elseif event == "UNIT_SPELLCAST_SENT" then
        onCastSent(...)
    elseif event == "UNIT_SPELLCAST_START" then
        onCastStart(...)
    elseif event == "UNIT_SPELLCAST_STOP" then
        onCastStop(...)
    elseif event == "UNIT_SPELLCAST_CHANNEL_START" then
        onCastStart(...)
    elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
        onChannelStop(...)
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        onCastSucceeded(...)
    elseif event == "UNIT_SPELLCAST_DELAYED" then
        onCastDelayed(...)
    elseif event == "UNIT_SPELLCAST_CHANNEL_UPDATE" then
        onCastDelayed(...)
    elseif event == "UNIT_AURA" then
        local unit = ...
        local guid = UnitGUID(unit)
        if guid and unitMap[guid] then
            scanTargetMods(unit, guid)
            local OnAuraChange = Engine.OnAuraChange
            if OnAuraChange then OnAuraChange(unit, guid) end
        end
    elseif event == "GROUP_ROSTER_UPDATE" then
        refreshRoster()
    elseif event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" then
        onZoneChanged()
        if event == "PLAYER_ENTERING_WORLD" then
            evFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
        end
    elseif event == "PLAYER_EQUIPMENT_CHANGED" then
        refreshEquipment()
    elseif event == "CHARACTER_POINTS_CHANGED" then
        refreshTalents()
    elseif event == "PLAYER_LEVEL_UP" then
        Engine.myLevel = UnitLevel("player")
    elseif event == "PLAYER_TARGET_CHANGED" then
        -- If we had a targeting cursor active, it now resolves to the new target
        if Engine._hadTargetingCursor and UnitExists("target") then
            setCastTarget(0, UnitGUID("target"), 6)
            Engine._hadTargetingCursor = false
        end
    elseif event == "UPDATE_MOUSEOVER_UNIT" then
        -- Mouseover is used as fallback cast target in resolveCastTarget
    elseif event == "PLAYER_LOGIN" then
        Engine:PLAYER_LOGIN()
    elseif event == "PLAYER_ALIVE" then
        refreshTalents()
        evFrame:UnregisterEvent("PLAYER_ALIVE")
    elseif event == "UNIT_PET" then
        -- Pet GUID tracking — update unitMap, groupMap, activePets, and
        -- invalidate compression caches so heals on respawned/new pets
        -- (Water Elemental, Ravager, etc.) are tracked immediately.
        local unit = ...
        local guid = UnitGUID(unit)
        if guid and unitMap[guid] then
            local ownerUnit = unitMap[guid]
            local pet = Engine.petLookup[ownerUnit]
            local petGUID = pet and UnitGUID(pet)
            local oldPetGUID = Engine.activePets[ownerUnit]

            -- Update activePets so compressGUID/decompressGUID resolve correctly
            Engine.activePets[ownerUnit] = petGUID

            -- Invalidate stale GUID compression/decompression caches
            if oldPetGUID and oldPetGUID ~= petGUID then
                -- Remove old pet GUID from compress cache
                rawset(Engine.compressGUID, oldPetGUID, nil)
                -- Remove old decompressed entry for this owner's pet key
                local ownerSuffix = string.match(guid, "^%w*-([-%w]*)$")
                if ownerSuffix then
                    rawset(Engine.decompressGUID, "p-" .. ownerSuffix, nil)
                end
                -- Remove old pet from unitMap/groupMap
                unitMap[oldPetGUID] = nil
                groupMap[oldPetGUID] = nil
            end

            if petGUID then
                unitMap[petGUID] = pet
                groupMap[petGUID] = groupMap[guid]
            end
        end
    end
end)

---------------------------------------------------------------------------
-- PLAYER_LOGIN — deferred startup
---------------------------------------------------------------------------
function Engine:PLAYER_LOGIN()
    Engine:OnStartup()

    evFrame:UnregisterEvent("PLAYER_LOGIN")
    evFrame:RegisterEvent("CHAT_MSG_ADDON")
    evFrame:RegisterEvent("UNIT_SPELLCAST_SENT")
    evFrame:RegisterEvent("UNIT_SPELLCAST_START")
    evFrame:RegisterEvent("UNIT_SPELLCAST_STOP")
    evFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    evFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
    evFrame:RegisterEvent("UNIT_SPELLCAST_DELAYED")
    evFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
    evFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    evFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    evFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
    evFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    evFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
    evFrame:RegisterEvent("PLAYER_LEVEL_UP")
    evFrame:RegisterEvent("CHARACTER_POINTS_CHANGED")
    evFrame:RegisterEvent("UNIT_AURA")
    evFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    evFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    evFrame:RegisterEvent("GROUP_ROSTER_UPDATE")

    -- Hooks for cast target resolution
    if not Engine._hooked then
        Engine._hooked = true

        local SpellIsTargeting    = SpellIsTargeting
        local UnitCanAssist       = UnitCanAssist
        local UnitExists          = UnitExists
        local hadTargetingCursor  = false
        Engine._hadTargetingCursor = false

        -- Resolves cast target from context: mouseover > target > self
        local function resolveCastTarget(unit)
            if unit and UnitCanAssist("player", unit) then
                setCastTarget(0, UnitGUID(unit), 4)
            elseif not SpellIsTargeting() then
                -- Spell fired immediately (no targeting cursor)
                if UnitExists("mouseover") and UnitCanAssist("player", "mouseover") then
                    setCastTarget(0, UnitGUID("mouseover"), 3)
                elseif UnitCanAssist("player", "target") then
                    setCastTarget(0, UnitGUID("target"), 2)
                else
                    setCastTarget(0, Engine.myGUID, 1)
                end
                Engine._hadTargetingCursor = false
            else
                -- Spell is waiting for click-target; actual target resolved on SpellTargetUnit
                Engine._hadTargetingCursor = true
            end
        end

        hooksecurefunc("TargetUnit",       function(name) setCastTarget(0, UnitGUID(name or "target"), 5) end)
        hooksecurefunc("SpellTargetUnit",   function(name)
            setCastTarget(0, UnitGUID(name or "target"), 8)
            Engine._hadTargetingCursor = false
        end)
        hooksecurefunc("AssistUnit",        function(name) setCastTarget(0, UnitGUID(name or "target"), 5) end)
        hooksecurefunc("TargetLastFriend",  function() setCastTarget(0, UnitGUID("target"), 4) end)
        hooksecurefunc("TargetLastTarget",  function() setCastTarget(0, UnitGUID("target"), 4) end)

        hooksecurefunc("UseAction",         function(actionSlot, cursorType, selfCast)
            -- UseAction(slot, cursorType, selfCast) — no unit param, use nil for fallback logic
            resolveCastTarget(nil)
        end)
        hooksecurefunc("CastSpellByName",   function(name, unit)
            resolveCastTarget(unit)
        end)
        hooksecurefunc("CastSpellByID",     function(spellID, unit)
            resolveCastTarget(unit)
        end)
    end
end

-- Talent data might not be ready until PLAYER_ALIVE
if GetNumTalentTabs() == 0 then
    evFrame:RegisterEvent("PLAYER_ALIVE")
end

if not IsLoggedIn() then
    evFrame:RegisterEvent("PLAYER_LOGIN")
    evFrame:SetScript("OnEvent", evFrame:GetScript("OnEvent"))
else
    Engine:PLAYER_LOGIN()
end
