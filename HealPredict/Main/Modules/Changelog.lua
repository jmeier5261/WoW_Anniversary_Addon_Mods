-- HealPredict - Changelog.lua
-- Version changelog popup and data
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn

local HP = HealPredict

---------------------------------------------------------------------------
-- Version Changelog Data
---------------------------------------------------------------------------
local CHANGELOGS = {
    ["1.1.1"] = {
        "|cff33ccffNew Features:|r",
        "  - Separate party frame overflow cap: party frames now have their own overflow % setting",
        "    Configurable independently from raid frames (default 25%) under Overflow Limits",
        "  - Cooldown Usage Advisor: predicts upcoming raid damage spikes from learned encounters",
        "    Compact overlay widget near screen center with countdown warnings",
        "    Three urgency tiers: red (NOW!), orange (save CDs!), blue (informational)",
        "    Cross-references historical cooldown usage (e.g. 'HERO/BPROT used here historically')",
        "    Automatic burst detection: triggers when raid takes 30%+ max HP in a 2s window",
        "    External CD tracking: records when raid CDs are used (BOP, Pain Suppression, Heroism, etc.)",
        "    Requires 3+ observations before predictions appear (weighted-average timing)",
        "    Draggable widget with saved position",
        "  - Tracking scope: Boss Only or Full Instance (includes trash pulls)",
        "  - Preview integration: |cffffff00/hp preview|r now cycles through CD advisor demo messages",
        "  - Encounter Suggestions Panel: floating UI during boss fights with real-time healing stats",
        "    Shows live HPS, cast count, overheal %, and comparison to your personal best",
        "    Learned timers: displays previously seen boss abilities with predicted timing",
        "  - Suggestion display modes: Chat, UI Panel, Both, or Disabled (cycle in options)",
        "  - Panel preview: |cffffff00/hp preview|r to demo the panel with fake data",
        "  - Instance tracking: full dungeon and raid run tracking alongside boss encounters",
        "  - Classic Era compatibility",
        "",
        "|cff33ccffImprovements:|r",
        "  - Key moments merge: events now merge within +/-3s tolerance with weighted-average timestamps",
        "  - Key moments cap raised from 20 to 30, evicts lowest-count moment when full",
        "  - Prediction lookahead extended from 5s to 15s with urgency-based coloring",
        "  - Mana cost bar now updates in real-time as your mana changes during a cast",
        "",
        "|cff44ff44Bug Fixes:|r",
        "  - Fixed BURST and CD_USED events never being recorded (RecordEncounterEvent was never called)",
        "  - Fixed key moments never merging (no count tracking, predictions never reached threshold)",
        "  - Fixed mana cost bar showing a thin blue line at the edge",
        "  - Fixed overheal stats variables leaking to global scope",
        "  - Fixed class-colored heal bars showing white instead of class colors",
        "  - Fixed class-colored heal bars inflating totals causing false overheal",
        "",
        "|cffaaaaaaUI Changes:|r",
        "  - Options: new 'Show cooldown advisor overlay' checkbox in Smart Learning section",
        "  - Options: new 'Tracking: Boss Only / Full Instance' cycle button",
        "  - Options reorganized: analytics sections moved to new 5th tab (Analytics)",
        "    Overheal Statistics, Heal Queue Timeline, Encounter Learning, Instance Tracking",
    },
    ["1.1.0"] = {
        "|cff33ccffNew Features:|r",
        "  - Charmed/Possessed indicator: magenta/purple highlight when teammates are mind-controlled",
        "  - Charmed indicator style options: Static, Glow, Spinning, Slashes, Pulse Ring, Strobe, or Wave",
        "  - Charmed indicator color swatch in Colors tab",
        "  - 3 New Indicator Effects:",
        "    Pulse Ring: Expanding circular rings emanating from center (like sonar)",
        "    Strobe: Rapid on/off flashing for urgent alerts (150ms intervals)",
        "    Wave: Horizontal sine wave traveling across the frame",
        "  - Overheal Statistics: Real-time session tracking with per-spell breakdown",
        "  - Overheal panel with position options (4 corners) and draggable UI",
        "  - Overheal stats now track all heals including HoTs (Renew, Rejuv, etc.)",
        "  - Overheal stats auto-reset: text clears after delay of no healing (configurable)",
        "  - Overheal stats remember dragged position through /reload",
        "  - Overheal stats visibility modes: Always, Raid Only, Dungeon Only, or Raid & Dungeon",
        "  - Overheal stats reset modes: After delay, Boss kill, or Instance end",
        "  - Overheal stats 'Hide out of combat' option with configurable delay",
        "  - Death Prediction: Calculates time-to-death based on incoming DPS",
        "  - Death warning overlay: Red (<1.5s) / Yellow (<3s) countdown on frames",
        "  - Class-Colored Heal Bars: Individual bars per caster with class colors",
        "    Toggle between 4 aggregated bars OR individual bars per healer",
        "    Requires Smart Ordering enabled; shows up to 4 healers per target",
        "  - Test mode: 3 layout modes - Solo (8), Dungeon (5), Raid (25 frames)",
        "    Solo/Dungeon: Vertical party-style frame layout",
        "    Raid: 5-column grid layout matching raid frames",
        "    Features distributed across all frames using modulo pattern",
        "",
        "|cff33ccffImprovements:|r",
        "  - Absorb bars now visually shrink in real-time as shields absorb damage",
        "  - Test mode: absorb bar and shield glow previews shown on more frames",
        "  - Test mode: HoT dot previews shown on more frames",
        "  - Test mode: toggling any option now instantly updates the preview",
        "  - Test mode frames can now be dragged by clicking any frame (not just header)",
        "  - Spell names in overheal stats are no longer truncated",
        "  - Overheal stats OOC hide now respects the reset delay slider",
        "  - All 7 indicator effect styles now properly animate (Static, Glow, Spinning, Slashes, Pulse Ring, Strobe, Wave)",
        "",
        "|cff33ccffUI Changes:|r",
        "  - Complete menu restructure: reorganized into 4 feature-based tabs",
        "    - Heal Bars: All healing prediction bar settings + Overheal Stats + Class Colors",
        "    - Indicators: All raid frame indicators + Death Prediction",
        "    - Mana & Alerts: Mana forecasting, sniper warnings, sound alerts",
        "    - General: Performance, profiles, auto-switch, minimap",
        "",
        "|cff44ff44Bug Fixes:|r",
        "  - Fixed heal prediction bars and text appearing faded/washed out on raid frames",
        "    Bars were rendering behind the health bar due to incorrect frame parenting",
        "  - Fixed absorb bar not shrinking when shield absorbs damage",
        "    Fully-absorbed hits were not detected in Classic Era combat log",
        "  - Fixed absorb bar invisible in test mode (layer ordering fix)",
        "  - Fixed overheal stats not tracking periodic heals (HoTs)",
        "  - Fixed Colors tab layout overlap with new Charmed color swatch",
        "  - Fixed AoE Advisor swatch anchor chain",
        "  - Fixed various menu alignment issues",
        "  - Fixed test frames being affected by range indicator alpha",
        "  - Fixed overheal stats frame appearing when adjusting unrelated sliders",
        "  - Fixed 'Hide out of combat' immediately hiding frame instead of using delay",
        "  - Fixed overheal stats frame flickering in test mode",
        "  - Fixed indicator effects not cleaning up when switching styles",
        "  - Fixed Pulse Ring animation speed (slowed from strobe-like to smooth 8s cycle)",
        "",
        "|cffaaaaaaContent:|r",
        "  - Added 'Touch of the Forgotten' (Mana-Tombs) to heal reduction detection",
    },
    ["1.0.9.1 HOTFIX"] = {
        "|cff44ff44Bug Fixes:|r",
        "  - Fixed heal predictions not showing on Water Elemental (Mage pet)",
        "  - Fixed direct heal predictions intermittently disappearing on specific targets",
        "  - HealEngine: cast target resolution now falls back to direct API scan when unitMap lookup fails",
        "  - HealEngine: refreshRoster now fully rebuilds unit mappings on every group change, preventing stale entries",
        "  - Fixed cooldown sweep showing countdown numbers instead of sweep-only animation",
        "  - Fixed HoT spell icons not appearing in test mode (Features.lua now mirrors Render.lua icon creation)",
        "",
        "|cff33ccffImprovements:|r",
        "  - HoT icon mode auto-sets size to 14px and spacing to 16px when switching from dot mode",
        "  - HoT dot size slider range expanded to 2-24px, spacing to 4-28px",
    },
    ["1.0.9"] = {
        "|cff33ccffNew Features:|r",
        "  - Minimap button now uses addon's custom icon",
        "  - Square minimap support (ElvUI, etc.)",
        "  - MinimapButtonButton (MBB) addon compatibility",
        "  - Improved export/import with count feedback",
        "  - HoT dot size slider (2-24px)",
        "  - HoT dot spacing slider (4-28px)",
        "  - HoT dot layout mode: Two rows or Single row",
        "  - HoT display mode: Colored dots or Spell icons with cooldown sweep",
        "  - Cooldown sweep toggle (show/hide sweep animation on spell icons)",
        "  - Auto-adjusts dot size and spacing when switching display mode",
        "  - Spell icons visible in test mode with animated cooldown preview",
        "",
        "|cff44ff44Bug Fixes:|r",
        "  - Fixed 'SetValue' error when switching profiles",
        "  - Fixed nil 'L' error on minimap button tooltip",
        "  - Profile loading now properly merges defaults",
        "  - All settings now properly export and import",
        "  - Minimap button now auto-registers with MBB whitelist",
    },
    ["1.0.8"] = {
        "|cff33ccffNew Features:|r",
        "  - Enhanced defensive cooldown display with spell icons",
        "  - Defensive display modes: Text only, Icon only, Icon+Text",
        "  - Defensive icon size and text size sliders",
        "  - Defensive position options (Center, Top-Left, Top-Right, Bottom-Left, Bottom-Right)",
        "  - Separate border effect option (No effect, Static, Glow, Spinning, Slashes)",
        "  - Defensive border color swatch in Colors tab",
        "  - Test mode shows defensive cooldowns for preview",
        "",
        "|cff44ff44Bug Fixes:|r",
        "  - Fixed CreateTexture sublevel error (must be -8 to 7)",
        "  - Fixed defensive border effect not hiding when 'No effect' selected",
        "  - Fixed defensive border style showing wrong effect",
        "  - Fixed defensive indicator functions not being exported",
        "  - Fixed options panel width and overlapping issues",
        "  - Fixed options scroll height for all new controls",
    },
    ["1.0.7"] = {
        "|cff33ccffNew Features:|r",
        "  - Full ElvUI compatibility (Beta)",
        "  - Custom textures and orientation support",
        "  - Reversed fill direction support",
        "  - Individual HoT tracker colors",
        "  - Separate colors for other healers' HoTs",
        "  - Enhanced defensive cooldown display with icons",
        "  - Configurable defensive icon size and text size",
        "  - Defensive display modes: Text only, Icon only, Icon+Text",
        "  - Defensive position options: Center, Top-Left, Top-Right, Bottom-Left, Bottom-Right",
        "  - Separate border effect option with No effect/Static/Glow/Spinning/Slashes",
        "  - Defensive border color swatch in Colors tab",
        "",
        "|cff44ff44Bug Fixes:|r",
        "  - Fixed own unit frame not showing heals",
        "  - Fixed taint errors",
        "  - Fixed nameplates errors",
        "  - Reduced range opacity flickering",
        "  - Fixed pet frame issues",
    },
    ["1.0.6"] = {
        "|cff33ccffNew Features:|r",
        "  - Raid cooldown tracker: external CDs on raid frames (Pain Suppression, BOP, etc.)",
        "  - Sound alerts: configurable sounds for dispel needed + healer low mana",
        "  - Customizable border thickness: 1-4px slider for all indicator styles",
        "  - Low mana warning on raid frames (healer classes only)",
        "  - Slashes indicator effect: diagonal sweeping lines (4th style option)",
        "  - Range indicator: dims raid frames for out-of-range targets",
        "  - HoT expiry warning: orange border when your HoTs are about to expire",
        "  - Dispel highlights: color-coded overlay for dispellable debuffs",
        "  - Incoming res tracker: shows RES text on targets being rezzed",
        "  - Cluster detection: highlights low-health subgroups for AoE heals",
        "  - Healing efficiency stats with color-coded output (/hp stats)",
        "  - Out-of-combat regen timer on mana bar",
        "  - Profile auto-switch by group size (solo/party/raid)",
        "  - Heal reduction indicator (Mortal Strike, etc.) with optional text toggle",
        "  - Indicator effect styles: Static, Glow, Spinning dots, or Slashes",
        "",
        "|cff44ff44Bug Fixes:|r",
        "  - Fixed TargetFrame taint (ADDON_ACTION_BLOCKED on HideBase)",
        "  - Range opacity no longer fights Blizzard's built-in range dimming",
        "  - Pet frames: robust GUID tracking with fallback scan + UNIT_PET re-sync",
        "  - Border thickness applies to all styles (edges, spinning dots, slashes)",
        "  - Slider labels no longer show duplicate text",
        "  - Efficiency report formatted for proportional chat font",
        "  - Options panel scroll height covers all controls",
    },
    ["1.0.5"] = {
        "|cff33ccffImprovements:|r",
        "  - Heal reduction percentage text can now be toggled on/off separately",
        "  - Indicator border thickness slider moved to new INDICATORS section",
        "  - Options panel reorganized: indicators grouped under dedicated section header",
        "",
        "|cff44ff44Bug Fixes:|r",
        "  - Range opacity no longer fights Blizzard's built-in range dimming",
        "  - Range opacity slider now applies changes in real time",
        "  - Border thickness slider now updates indicator edges instantly",
        "  - Spinning dots and slash lines now respect border thickness setting",
        "  - Pet frames: robust GUID fallback scan in HealComm notifications",
        "  - Pet frames: compact/raid pet GUID re-sync on UNIT_PET event",
        "  - Healer count now updates correctly when switching between pets",
        "  - Fixed slider min/max labels showing full label text instead of just numbers",
        "  - Fixed options Tab 2 scroll height cutting off sound alert controls",
        "  - Healing efficiency report reformatted for proportional chat font",
    },
    ["1.0.4"] = {
        "|cff33ccffNew Features:|r",
        "  - Raid cooldown tracker: shows external CDs (Pain Suppression, BOP, Innervate, etc.)",
        "  - Sound alerts: configurable sounds for dispel needed + healer low mana",
        "  - Sound selection: cycle through 4 sounds with preview button",
        "  - Customizable border thickness: 1-4px slider for indicator edges",
        "  - Low mana warning on raid frames (Priest/Paladin/Druid/Shaman only)",
        "  - Slashes indicator effect: diagonal lines sweeping across (4th style option)",
        "  - Range indicator: dims entire raid frame when target is out of range",
        "  - HoT expiry warning: orange border when your HoTs expire soon",
        "  - Dispel highlights: color-coded overlay for dispellable debuffs",
        "  - Incoming res tracker: shows RES on dead targets being rezzed",
        "  - Cluster detection: highlights low-health subgroups",
        "  - Healing efficiency: per-spell stats with color-coded output (/hp stats)",
        "  - Out-of-combat regen timer on mana bar",
        "  - Profile auto-switch by group size (solo/party/raid)",
        "  - Heal reduction indicator (Mortal Strike, etc.)",
        "  - Indicator effect styles: Static, Glow, Spinning dots, or Slashes",
        "",
        "|cff44ff44Bug Fixes:|r",
        "  - Pet frames: added UNIT_PET event + periodic GUID re-sync",
        "  - Range indicator dims entire frame (not just prediction bars)",
        "  - Fixed slider labels showing duplicate text in min/max values",
        "  - Fixed options panel scroll height for new controls",
        "  - Efficiency report reformatted for WoW's proportional chat font",
        "  - Bar opacity slider now applies in real time",
        "  - HoT expiry warning now polls every 0.5s (no longer missed)",
        "  - Range indicator uses correct UnitInRange two-value API",
        "  - Indicator borders use clean edge strips instead of full-frame overlay",
    },
    ["1.0.3"] = {
        "|cff33ccffNew Features:|r",
        "  - Healer count per target on raid frames",
        "  - Overheal severity gradient (green to red)",
        "  - Health trajectory marker (damage prediction)",
        "  - AoE heal target advisor (subgroup highlight)",
        "  - Mana forecast / OOM timer on player frame",
        "  - Heal snipe detection with flash alerts",
        "  - Swatch tooltips in Colors tab",
        "  - Adjustable fast update polling rate (10-60 FPS)",
        "  - Position options for heal text, healer count, OOM text",
        "",
        "|cff44ff44Bug Fixes:|r",
        "  - Pet frame heal predictions now visible",
        "  - Fixed mana forecast not appearing",
        "  - Fixed Ice Block, Divine Intervention, Evasion spell IDs",
        "  - Fixed slider overlap in Performance section",
    },
}

---------------------------------------------------------------------------
-- Changelog Frame UI
---------------------------------------------------------------------------
local changelogFrame = nil

local function CreateChangelogFrame()
    if changelogFrame then return changelogFrame end

    local W, H = 550, 520
    local PAD_TOP, PAD_BOT = 42, 46

    local f = CreateFrame("Frame", "HP_ChangelogFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
    f:SetSize(W, H)
    f:SetPoint("CENTER")
    f:SetFrameStrata("DIALOG")
    f:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 } })
    f:SetBackdropColor(0, 0, 0, 0.9)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    -- Title
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", f, "TOP", 0, -16)
    f.TitleText = title

    -- Close X button
    local closeX = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeX:SetPoint("TOPRIGHT", f, "TOPRIGHT", -4, -4)

    -- Clip region: a frame that clips content outside its bounds
    local clip = CreateFrame("Frame", nil, f)
    clip:SetPoint("TOPLEFT", f, "TOPLEFT", 16, -PAD_TOP)
    clip:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -16, PAD_BOT)
    clip:SetClipsChildren(true)

    -- Content frame that moves up/down inside the clip
    local content = CreateFrame("Frame", nil, clip)
    content:SetWidth(W - 56)
    content:SetHeight(1)
    content:SetPoint("TOPLEFT", clip, "TOPLEFT", 0, 0)

    -- Scrollbar track
    local track = CreateFrame("Frame", nil, f, BackdropTemplateMixin and "BackdropTemplate" or nil)
    track:SetWidth(8)
    track:SetPoint("TOPRIGHT", clip, "TOPRIGHT", 0, 0)
    track:SetPoint("BOTTOMRIGHT", clip, "BOTTOMRIGHT", 0, 0)
    track:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
    track:SetBackdropColor(1, 1, 1, 0.08)

    -- Scrollbar thumb
    local thumb = CreateFrame("Frame", nil, track, BackdropTemplateMixin and "BackdropTemplate" or nil)
    thumb:SetWidth(8)
    thumb:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
    thumb:SetBackdropColor(0.6, 0.6, 0.6, 0.5)
    thumb:EnableMouse(true)
    thumb:Hide()

    f._content = content
    f._clip = clip
    f._thumb = thumb
    f._track = track
    f._scrollOffset = 0

    -- Update thumb position and size
    local function UpdateThumb()
        local clipH = clip:GetHeight()
        local contentH = content:GetHeight()
        if contentH <= clipH then
            thumb:Hide()
            return
        end
        local trackH = track:GetHeight()
        local ratio = clipH / contentH
        local thumbH = math.max(20, trackH * ratio)
        thumb:SetHeight(thumbH)

        local maxScroll = contentH - clipH
        local scrollPct = f._scrollOffset / maxScroll
        local thumbY = -scrollPct * (trackH - thumbH)
        thumb:ClearAllPoints()
        thumb:SetPoint("TOPRIGHT", track, "TOPRIGHT", 0, thumbY)
        thumb:Show()
    end
    f._updateThumb = UpdateThumb

    -- Mousewheel scrolling handler
    local SCROLL_STEP = 20
    local function OnScroll(_, delta)
        local maxScroll = math.max(0, content:GetHeight() - clip:GetHeight())
        local newOff = f._scrollOffset - (delta * SCROLL_STEP)
        newOff = math.max(0, math.min(newOff, maxScroll))
        f._scrollOffset = newOff
        content:ClearAllPoints()
        content:SetPoint("TOPLEFT", clip, "TOPLEFT", 0, newOff)
        UpdateThumb()
    end
    -- Enable on all layers so wheel works regardless of what's under cursor
    for _, frame in ipairs({ f, clip, content }) do
        frame:EnableMouseWheel(true)
        frame:SetScript("OnMouseWheel", OnScroll)
    end

    -- Thumb dragging
    thumb:RegisterForDrag("LeftButton")
    thumb:SetScript("OnDragStart", function(self)
        local startY = select(2, GetCursorPosition()) / UIParent:GetEffectiveScale()
        local startOff = f._scrollOffset
        self:SetScript("OnUpdate", function()
            local curY = select(2, GetCursorPosition()) / UIParent:GetEffectiveScale()
            local trackH = track:GetHeight()
            local thumbH = self:GetHeight()
            local contentH = content:GetHeight()
            local clipH = clip:GetHeight()
            local maxScroll = math.max(0, contentH - clipH)
            local dragRange = trackH - thumbH
            if dragRange <= 0 then return end
            local delta = startY - curY
            local newOff = startOff + (delta / dragRange) * maxScroll
            newOff = math.max(0, math.min(newOff, maxScroll))
            f._scrollOffset = newOff
            content:ClearAllPoints()
            content:SetPoint("TOPLEFT", clip, "TOPLEFT", 0, newOff)
            UpdateThumb()
        end)
    end)
    thumb:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
    end)

    -- Close button at bottom
    local closeBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    closeBtn:SetSize(80, 22)
    closeBtn:SetPoint("BOTTOM", f, "BOTTOM", 0, 14)
    closeBtn:SetText("Got it!")
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    changelogFrame = f
    return f
end

function HP.ShowChangelog(version)
    local f = CreateChangelogFrame()
    f.TitleText:SetText("|cff33ccffHealPredict|r - Changelog")

    local content = f._content
    local contentW = content:GetWidth()

    local regions = { content:GetRegions() }
    for _, r in ipairs(regions) do r:Hide() end

    local yOff = -4

    local discordNote = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    discordNote:SetPoint("TOP", content, "TOP", 0, yOff)
    discordNote:SetWidth(contentW - 8)
    discordNote:SetJustifyH("CENTER")
    discordNote:SetText("|cffffaa00Discord support coming soon!|r")
    discordNote:Show()
    yOff = yOff - 30

    local versions = {}
    for v in pairs(CHANGELOGS) do
        table.insert(versions, v)
    end
    table.sort(versions, function(a, b) return a > b end)

    for _, v in ipairs(versions) do
        local log = CHANGELOGS[v]
        if log then
            local versionTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            versionTitle:SetPoint("TOPLEFT", content, "TOPLEFT", 4, yOff)
            versionTitle:SetWidth(contentW - 8)
            versionTitle:SetJustifyH("LEFT")
            versionTitle:SetText("|cff33ccffVersion " .. v .. "|r")
            versionTitle:Show()
            yOff = yOff - (versionTitle:GetStringHeight() + 8)

            for _, line in ipairs(log) do
                local fs = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
                fs:SetPoint("TOPLEFT", content, "TOPLEFT", 4, yOff)
                fs:SetWidth(contentW - 8)
                fs:SetJustifyH("LEFT")
                fs:SetText(line)
                fs:Show()
                yOff = yOff - (fs:GetStringHeight() + 4)
            end
            yOff = yOff - 16
        end
    end

    local discordNote = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    discordNote:SetPoint("TOP", content, "TOP", 0, yOff - 20)
    discordNote:SetWidth(contentW - 8)
    discordNote:SetJustifyH("CENTER")
    discordNote:SetText("|cffffaa00Discord support coming soon!|r")
    discordNote:Show()
    yOff = yOff - 40

    content:SetHeight(math.abs(yOff) + 8)

    -- Reset scroll to top and update scrollbar
    f._scrollOffset = 0
    content:ClearAllPoints()
    content:SetPoint("TOPLEFT", f._clip, "TOPLEFT", 0, 0)
    f._updateThumb()

    f:Show()
end

function HP.CheckChangelog()
    local db = HP.db
    if not db or not HP.VERSION then return end

    local currentVersion = HP.VERSION
    if db.lastSeenVersion ~= currentVersion then
        db.lastSeenVersion = currentVersion
        C_Timer.After(3, function()
            HP.ShowChangelog(currentVersion)
        end)
    end
end
