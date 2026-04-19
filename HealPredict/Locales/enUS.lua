-- HealPredict - English (US) Localization
-- This is the default/base locale file
-- All other locales should translate these strings
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn

local _, HP = ...

if not HP.LocaleData then HP.LocaleData = {} end

HP.LocaleData["enUS"] = function(L)
    ---------------------------------------------------------------------------
    -- Core Addon Info
    ---------------------------------------------------------------------------
    L["ADDON_NAME"] = "HealPredict"
    L["VERSION_AUTHOR"] = "v%s  by DarkpoisOn"
    
    ---------------------------------------------------------------------------
    -- Profile Section
    ---------------------------------------------------------------------------
    L["PROFILE_LABEL"] = "Profile:"
    L["PROFILE_NEW"] = "New"
    L["PROFILE_COPY"] = "Copy"
    L["PROFILE_DELETE"] = "Del"
    L["PROFILE_EXPORT"] = "Export"
    L["PROFILE_IMPORT"] = "Import"
    L["PROFILE_DEFAULT"] = "Default"
    
    ---------------------------------------------------------------------------
    -- Dialog / Popup Texts
    ---------------------------------------------------------------------------
    L["DIALOG_NEW_PROFILE"] = "Enter new profile name:"
    L["DIALOG_CREATE"] = "Create"
    L["DIALOG_CANCEL"] = "Cancel"
    L["DIALOG_COPY_PROFILE"] = "Copy current profile to new name:"
    L["DIALOG_DELETE_CONFIRM"] = "Delete profile '%s'?\nThis character will switch to Default."
    L["DIALOG_DELETE"] = "Delete"
    L["DIALOG_EXPORT_TITLE"] = "Copy this string to share your profile:"
    L["DIALOG_DONE"] = "Done"
    L["DIALOG_IMPORT_TITLE"] = "Paste a HealPredict profile string:"
    L["DIALOG_IMPORT_BUTTON"] = "Import"
    
    ---------------------------------------------------------------------------
    -- Tab Names
    ---------------------------------------------------------------------------
    L["TAB_GENERAL"] = "General"
    L["TAB_DISPLAY"] = "Display"
    L["TAB_COLORS"] = "Colors"
    
    ---------------------------------------------------------------------------
    -- Section Headers (General Tab)
    ---------------------------------------------------------------------------
    L["SECTION_HEALING_FILTERS"] = "HEALING FILTERS"
    L["SECTION_THRESHOLDS"] = "THRESHOLDS"
    L["SECTION_OVERFLOW_LIMITS"] = "OVERFLOW LIMITS"
    L["SECTION_PERFORMANCE"] = "PERFORMANCE"
    L["SECTION_PROFILE_AUTO_SWITCH"] = "PROFILE AUTO-SWITCH"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Healing Filters)
    ---------------------------------------------------------------------------
    L["SHOW_HEALING_FROM_OTHERS"] = "Show healing from other players"
    L["DIRECT_HEALS"] = "Direct heals"
    L["HOT_HEALS"] = "HoT (heal over time)"
    L["CHANNELED_HEALS"] = "Channeled heals"
    L["BOMB_HEALS"] = "Bomb heals (Prayer of Mending, etc.)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Thresholds)
    ---------------------------------------------------------------------------
    L["LIMIT_PREDICTION_WINDOW"] = "Limit prediction window"
    L["DIM_NON_IMMINENT_HEALS"] = "Dim non-imminent heals (beyond time window)"
    L["RECOLOR_OVERHEAL"] = "Recolor bars when overhealing exceeds (%)"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (General Tab)
    ---------------------------------------------------------------------------
    L["SLIDER_DIRECT_TF"] = "Direct: %.1fs"
    L["SLIDER_CHANNEL_TF"] = "Channel: %.1fs"
    L["SLIDER_HOT_TF"] = "HoT: %.1fs"
    L["SLIDER_POLL_RATE"] = "Poll rate: %d FPS"
    L["SLIDER_PANEL_SCALE"] = "Panel scale: %d%%"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Overflow)
    ---------------------------------------------------------------------------
    L["CAP_RAID_OVERFLOW"] = "Cap raid frame overflow (%)"
    L["CAP_UNIT_OVERFLOW"] = "Cap unit frame overflow (%)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Performance)
    ---------------------------------------------------------------------------
    L["FAST_RAID_UPDATES"] = "Fast raid frame updates"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Auto-Switch)
    ---------------------------------------------------------------------------
    L["AUTO_SWITCH_PROFILES"] = "Auto-switch profiles by group size"
    L["AUTO_SWITCH_SOLO"] = "Solo:"
    L["AUTO_SWITCH_PARTY"] = "Party:"
    L["AUTO_SWITCH_RAID"] = "Raid:"
    
    ---------------------------------------------------------------------------
    -- Section Headers (Display Tab)
    ---------------------------------------------------------------------------
    L["SECTION_FRAME_VISIBILITY"] = "FRAME VISIBILITY"
    L["SECTION_BARS_OVERLAYS"] = "BARS & OVERLAYS"
    L["SECTION_SHIELDS_ABSORBS"] = "SHIELDS & ABSORBS"
    L["SECTION_DEFENSIVES"] = "DEFENSIVES"
    L["SECTION_TEXT_OVERLAYS"] = "TEXT OVERLAYS"
    L["SECTION_RAID_FRAME_INDICATORS"] = "RAID FRAME INDICATORS"
    L["SECTION_INDICATORS"] = "INDICATORS"
    L["SECTION_PLAYER_MANA"] = "PLAYER MANA"
    L["SECTION_ALERTS"] = "ALERTS"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Frame Visibility)
    ---------------------------------------------------------------------------
    L["SHOW_ON_PLAYER"] = "Show on Player frame"
    L["SHOW_ON_TARGET"] = "Show on Target frame"
    L["SHOW_ON_TOT"] = "Show on Target of Target frame"
    L["SHOW_ON_FOCUS"] = "Show on Focus frame"
    L["SHOW_ON_PARTY"] = "Show on Party frames"
    L["SHOW_ON_PET"] = "Show on Pet frames"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Bars & Overlays)
    ---------------------------------------------------------------------------
    L["OVERLAY_MODE"] = "Overlay mode (stack my + other heals)"
    L["SMART_HEAL_ORDERING"] = "Smart heal ordering (arrival time)"
    L["USE_RAID_TEXTURE"] = "Use raid-style texture on unit frame bars"
    L["SHOW_MANA_COST"] = "Show mana cost on player mana bar"
    L["OVERHEAL_BAR"] = "Overheal amount bar"
    L["OVERHEAL_GRADIENT"] = "Overheal severity gradient"
    L["SHOW_NAMEPLATES"] = "Show heal bars on friendly nameplates"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Display Tab)
    ---------------------------------------------------------------------------
    L["SLIDER_BAR_OPACITY"] = "Bar Opacity: %d%%"
    L["LBL_BAR_OPACITY"] = "Controls the opacity of heal prediction bars"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Shields & Absorbs)
    ---------------------------------------------------------------------------
    L["SHIELD_GLOW"] = "Shield glow on health bars"
    L["SHIELD_TEXT"] = "Show shield spell name"
    L["ABSORB_BAR"] = "Absorb presence bar on health bars"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Display Tab - Shield Offset)
    ---------------------------------------------------------------------------
    L["SLIDER_SHIELD_X"] = "X: %d"
    L["SLIDER_SHIELD_Y"] = "Y: %d"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Defensives)
    ---------------------------------------------------------------------------
    L["DEFENSIVE_STATUS"] = "Defensive status text on raid frames"
    L["SHOW_INVULNS"] = "Invulnerabilities (Divine Shield, Ice Block)"
    L["SHOW_STRONG_MIT"] = "Strong mitigation (BOP, Shield Wall)"
    L["SHOW_WEAK_MIT"] = "Weak mitigation (Evasion, Barkskin)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Text Overlays)
    ---------------------------------------------------------------------------
    L["PREDICTIVE_DEFICIT"] = "Predictive health deficit on raid frames"
    L["INCOMING_HEAL_TEXT"] = "Incoming heal text on unit frames"
    
    ---------------------------------------------------------------------------
    -- Position Labels
    ---------------------------------------------------------------------------
    L["POSITION"] = "Position:"
    L["POS_LEFT"] = "Left"
    L["POS_RIGHT"] = "Right"
    L["POS_ABOVE"] = "Above"
    L["POS_BELOW"] = "Below"
    L["POS_CENTER"] = "Center"
    L["POS_TOP_LEFT"] = "Top-Left"
    L["POS_TOP_RIGHT"] = "Top-Right"
    L["POS_BOTTOM_LEFT"] = "Bottom-Left"
    L["POS_BOTTOM_RIGHT"] = "Bottom-Right"
    
    L["HEALTXT_POS_PREFIX"] = "Position: %s"
    L["HEALER_POS_PREFIX"] = "Position: %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Raid Frame Indicators)
    ---------------------------------------------------------------------------
    L["HEALER_COUNT"] = "Show healer count per target"
    L["PREDICTIVE_TRAJECTORY"] = "Predictive health trajectory"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Trajectory)
    ---------------------------------------------------------------------------
    L["SLIDER_TRAJECTORY_WINDOW"] = "Window: %ds"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Range)
    ---------------------------------------------------------------------------
    L["DIM_OUT_OF_RANGE"] = "Dim out-of-range targets"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Range)
    ---------------------------------------------------------------------------
    L["SLIDER_DIMMED_OPACITY"] = "Dimmed opacity: %d%%"
    
    ---------------------------------------------------------------------------
    -- Effect Style Labels
    ---------------------------------------------------------------------------
    L["EFFECT_STYLE"] = "Style:"
    L["STYLE_STATIC"] = "Static"
    L["STYLE_GLOW"] = "Glow"
    L["STYLE_SPINNING"] = "Spinning"
    L["STYLE_SLASHES"] = "Slashes"
    
    L["STYLE_PREFIX"] = "Style: %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Indicators)
    ---------------------------------------------------------------------------
    L["DISPEL_HIGHLIGHT"] = "Dispel highlight on raid frames"
    L["HEAL_REDUCTION_GLOW"] = "Heal reduction indicator"
    L["SHOW_REDUCTION_TEXT"] = "Show reduction percentage text"
    L["CHARMED_INDICATOR"] = "Charmed/Possessed indicator"
    L["HOT_EXPIRY_WARNING"] = "HoT expiry warning border"
    L["INCOMING_RES"] = "Incoming res tracker"
    L["RAID_COOLDOWN_TRACKER"] = "Raid cooldown tracker"
    L["CLUSTER_DETECTION"] = "Cluster detection"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Indicators)
    ---------------------------------------------------------------------------
    L["SLIDER_INDICATOR_BORDER"] = "Indicator border: %dpx"
    L["SLIDER_HOT_EXPIRY_THRESHOLD"] = "Threshold: %ds"
    L["SLIDER_CLUSTER_THRESHOLD"] = "HP threshold: %d%%"
    L["SLIDER_CLUSTER_MIN"] = "Min members: %d"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - AoE & Mana)
    ---------------------------------------------------------------------------
    L["AOE_HEAL_ADVISOR"] = "AoE heal target advisor"
    L["LOW_MANA_WARNING"] = "Low mana warning on raid frames (healers)"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Low Mana)
    ---------------------------------------------------------------------------
    L["SLIDER_LOW_MANA_THRESHOLD"] = "Mana threshold: %d%%"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Player Mana)
    ---------------------------------------------------------------------------
    L["MANA_FORECAST"] = "Mana sustainability forecast"
    L["OOC_REGEN_TIMER"] = "Out-of-combat regen timer"
    
    ---------------------------------------------------------------------------
    -- Button Labels (Mana Position)
    ---------------------------------------------------------------------------
    L["FORECAST_POS_PREFIX"] = "Position: %s"
    L["OOC_POS_PREFIX"] = "Position: %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Alerts)
    ---------------------------------------------------------------------------
    L["HEAL_SNIPE_DETECTION"] = "Heal snipe detection"
    L["TRACK_HEALING_EFFICIENCY"] = "Track healing efficiency (/hp stats)"
    L["SOUND_DISPEL"] = "Sound alert: dispel needed"
    L["SOUND_LOW_MANA"] = "Sound alert: healer low mana"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Snipe)
    ---------------------------------------------------------------------------
    L["SLIDER_SNIPE_THRESHOLD"] = "Threshold: %d%%"
    
    ---------------------------------------------------------------------------
    -- Sound Selection Labels
    ---------------------------------------------------------------------------
    L["SOUND_RAID_WARNING"] = "Raid Warning"
    L["SOUND_READY_CHECK"] = "Ready Check"
    L["SOUND_ALARM_CLOCK"] = "Alarm Clock"
    L["SOUND_FLAG_CAPTURED"] = "Flag Captured"
    L["SOUND_NONE"] = "None"
    
    ---------------------------------------------------------------------------
    -- Section Headers (Colors Tab)
    ---------------------------------------------------------------------------
    L["SECTION_BAR_COLORS"] = "BAR COLORS"
    L["SECTION_FEATURE_COLORS"] = "FEATURE COLORS"
    L["SECTION_MISC"] = "MISC"
    
    ---------------------------------------------------------------------------
    -- Color Row Labels
    ---------------------------------------------------------------------------
    L["COLOR_MY_RAID_HEALS"] = "My Raid Heals:"
    L["COLOR_OTHER_RAID_HEALS"] = "Other Raid Heals:"
    L["COLOR_MY_UNIT_HEALS"] = "My Unit Heals:"
    L["COLOR_OTHER_UNIT_HEALS"] = "Other Unit Heals:"
    
    L["COLOR_ABSORB_BAR"] = "Absorb Bar:"
    L["COLOR_OVERHEAL_BAR"] = "Overheal Bar:"
    L["COLOR_MANA_COST"] = "Mana Cost:"
    L["COLOR_HOT_EXPIRY"] = "HoT Expiry:"
    L["COLOR_DISPEL_MAGIC"] = "Dispel Magic:"
    L["COLOR_DISPEL_CURSE"] = "Dispel Curse:"
    L["COLOR_DISPEL_DISEASE"] = "Dispel Disease:"
    L["COLOR_DISPEL_POISON"] = "Dispel Poison:"
    L["COLOR_CLUSTER_BORDER"] = "Cluster Border:"
    L["COLOR_HEAL_REDUCTION"] = "Heal Reduction:"
    L["COLOR_CHARMED"] = "Charmed/Possessed:"
    L["COLOR_AOE_ADVISOR"] = "AoE Advisor:"
    
    ---------------------------------------------------------------------------
    -- Color Swatch Labels
    ---------------------------------------------------------------------------
    L["SWATCH_DIRECT"] = "Direct"
    L["SWATCH_HOT"] = "HoT"
    L["SWATCH_DIRECT_OH"] = "Direct (OH)"
    L["SWATCH_HOT_OH"] = "HoT (OH)"
    
    ---------------------------------------------------------------------------
    -- Button Labels (Colors Tab)
    ---------------------------------------------------------------------------
    L["FLIP_MY_OTHER"] = "Flip My/Other"
    L["SHOW_MINIMAP"] = "Show minimap button"
    
    ---------------------------------------------------------------------------
    -- Bottom Buttons
    ---------------------------------------------------------------------------
    L["BUTTON_DEFAULTS"] = "Defaults"
    L["BUTTON_TEST_MODE"] = "Test Mode"
    
    ---------------------------------------------------------------------------
    -- Tooltips (General Tab)
    ---------------------------------------------------------------------------
    L["TOOLTIP_SHOW_OTHERS"] = "Display heal predictions from other healers in your raid or party."
    L["TOOLTIP_TIME_LIMIT"] = "Only show heals that will land within the specified timeframe. Useful for filtering out long HoTs that would clutter the display."
    L["TOOLTIP_DIM_NON_IMMINENT"] = "Reduces opacity of HoT/channel bars to distinguish them from direct heals landing soon."
    L["TOOLTIP_FAST_UPDATES"] = "Polls raid frames at a fixed rate for smoother bar updates. Uses more CPU. Without this, bars update only on health/heal events."
    L["TOOLTIP_AUTO_SWITCH"] = "Automatically switch between profiles when you join/leave a group or raid."
    L["TOOLTIP_AUTO_SWITCH_BTN"] = "Click to cycle through available profiles."
    
    ---------------------------------------------------------------------------
    -- Tooltips (Display Tab)
    ---------------------------------------------------------------------------
    L["TOOLTIP_OVERLAY_MODE"] = "When enabled, your heals and others' heals overlap instead of stacking end-to-end. Shows the larger of the two."
    L["TOOLTIP_SMART_ORDERING"] = "Reorders heal bars by arrival time: other heals landing before yours, your heal, other heals landing after, then all HoTs."
    L["TOOLTIP_HEALER_COUNT"] = "Shows the number of active healers casting on each raid frame target."
    L["TOOLTIP_HEALER_COUNT_POS"] = "Click to cycle: Top-Left, Top-Right, Bottom-Left, Bottom-Right."
    L["TOOLTIP_HEAL_TEXT_POS"] = "Click to cycle: Left, Right, Above, Below the health bar."
    L["TOOLTIP_TRAJECTORY"] = "Shows a marker predicting where health will be based on incoming damage rate."
    L["TOOLTIP_RANGE_INDICATOR"] = "Reduces opacity of heal bars on raid frames when the target is out of healing range."
    L["TOOLTIP_EFFECT_STYLE"] = "Static: solid border. Glow: pulsing alpha. Spinning: orbiting dots. Slashes: diagonal lines sweeping across."
    L["TOOLTIP_DISPEL_HIGHLIGHT"] = "Color-codes raid frames when a target has a dispellable debuff matching your class abilities."
    L["TOOLTIP_DISPEL_STYLE"] = "Click to cycle: Static, Glow, Spinning dots, Slashes."
    L["TOOLTIP_DISPEL_SOUND"] = "Click to cycle through available sounds."
    L["TOOLTIP_HEAL_REDUCTION"] = "Shows a red glow and percentage on raid frames when a target has a healing reduction debuff (Mortal Strike, etc.)."
    L["TOOLTIP_CHARMED"] = "Shows a magenta/purple indicator when a teammate is mind-controlled or charmed (hostile to you)."
    L["TOOLTIP_HOT_EXPIRY"] = "Shows an orange border when your HoTs on a target are about to expire."
    L["TOOLTIP_RES_TRACKER"] = "Shows 'RES' text on dead raid members being resurrected by a party/raid member."
    L["TOOLTIP_RAID_CD_TRACKER"] = "Shows external cooldowns received on raid frame targets (Pain Suppression, BOP, Innervate, etc.)."
    L["TOOLTIP_CLUSTER_DETECTION"] = "Highlights subgroups where multiple members are below a health threshold."
    L["TOOLTIP_AOE_ADVISOR"] = "Highlights the best target for AoE heals based on subgroup health deficits in raids."
    L["TOOLTIP_LOW_MANA"] = "Shows mana percentage text on raid frames for healer classes (Priest, Paladin, Druid, Shaman) when below threshold."
    L["TOOLTIP_MANA_FORECAST"] = "Shows estimated time to OOM on the player frame while mana is draining."
    L["TOOLTIP_MANA_FORECAST_POS"] = "Click to cycle: Above, Center, Below, Right of mana bar."
    L["TOOLTIP_OOC_REGEN"] = "Shows estimated time to full mana when out of combat with low mana."
    L["TOOLTIP_OOC_REGEN_POS"] = "Click to cycle: Above, Center, Below, Right of mana bar."
    L["TOOLTIP_SNIPE_DETECTION"] = "Flashes the raid frame when your heal is largely wasted due to overhealing."
    L["TOOLTIP_EFFICIENCY"] = "Records per-spell effective healing vs overhealing. View with /hp stats, reset with /hp stats reset."
    L["TOOLTIP_SOUND_DISPEL"] = "Plays a sound when a new dispellable debuff is detected. Debounced (max 1 per 5s)."
    L["TOOLTIP_SOUND_LOW_MANA"] = "Plays a sound when a healer's mana drops below the low mana threshold. Debounced (max 1 per 5s)."
    L["TOOLTIP_OVERHEAL_GRADIENT"] = "Colors overheal bar by severity: green (low) through orange to red (high)."
    L["TOOLTIP_LOW_MANA_SOUND"] = "Click to cycle through available sounds."
    
    ---------------------------------------------------------------------------
    -- Chat Messages (Print statements)
    ---------------------------------------------------------------------------
    L["MSG_PREFIX"] = "|cff33ccffHealPredict:|r"
    L["MSG_PREFIX_ERROR"] = "|cff33ccffHealPredict:|r |cffff4444Error:|r"
    L["MSG_PREFIX_DEBUG"] = "|cff33ccffHealPredict Debug|r"
    
    L["MSG_PROFILE_EXISTS"] = "Profile '%s' already exists."
    L["MSG_CANNOT_DELETE_DEFAULT"] = "Cannot delete the Default profile."
    L["MSG_PROFILE_DELETED"] = "Profile '%s' deleted."
    L["MSG_PROFILE_COPIED"] = "Copied to '%s'"
    L["MSG_IMPORT_SUCCESS"] = "Profile imported successfully."
    L["MSG_IMPORT_FAILED"] = "Import failed: %s"
    L["MSG_IMPORT_EMPTY"] = "Empty input"
    L["MSG_IMPORT_INVALID_FORMAT"] = "Invalid format (missing HP1: prefix)"
    L["MSG_IMPORT_UNKNOWN_VERSION"] = "Unknown version: %s"
    L["MSG_IMPORT_DECODE_FAILED"] = "Base64 decode failed"
    L["MSG_IMPORT_DESERIALIZE_FAILED"] = "Deserialization failed"
    L["MSG_IMPORT_INVALID_DATA"] = "Data does not appear to be a HealPredict profile"
    
    L["MSG_NOT_IN_GROUP"] = "Not in a group."
    L["MSG_RAID_CHECK_TITLE"] = "Raid heal data check:"
    L["MSG_HAS_HEAL_DATA"] = "|cff44ff44Sending heal data:|r"
    L["MSG_NO_HEAL_DATA"] = "|cffff8844No heal data (yet):|r"
    L["MSG_NO_HEALERS"] = "No healers found in group."
    L["MSG_NO_DATA_NOTE"] = "|cff888888Note: 'No data' means no heals detected yet.|r"
    
    L["MSG_NO_HEALING_DATA"] = "No healing data recorded. Enable 'Track healing efficiency' and heal!"
    L["MSG_EFFICIENCY_REPORT"] = "Healing Efficiency Report (%dm session)"
    L["MSG_EFFICIENCY_RESET"] = "Efficiency data reset."
    L["MSG_SPELL_STATS"] = "  |cffffffff%s|r: %dx | %d eff | %d oh | |cff%s%d%%|r"
    
    L["MSG_SNIPE_REPORT_TITLE"] = "Snipe report:"
    L["MSG_NO_SNIPES"] = "No snipes detected this session."
    L["MSG_SNIPE_TOTAL"] = "  Total snipes: |cffff4444%d|r"
    L["MSG_SNIPE_WASTED"] = "  Total wasted healing: |cffff4444%d|r"
    L["MSG_SNIPE_RECENT"] = "  Recent snipes:"
    L["MSG_SNIPE_ENTRY"] = "    %s - %d/%d overhealed (%.0f%%)"
    
    L["MSG_RENDER_ERROR"] = "Render error: %s"
    
    L["MSG_NAMEPLATE_DEBUG_TITLE"] = "|cff33ccffHealPredict Nameplate Debug|r"
    L["MSG_NAMEPLATE_SETTINGS"] = "  showNameplates=%s"
    L["MSG_NAMEPLATE_ENTRY"] = "  [%s] unit=%s friendly=%s uf=%s hb=%s tracked=%s"
    L["MSG_NAMEPLATE_NONE"] = "  No nameplates currently visible."
    L["MSG_NAMEPLATE_TOTAL"] = "  Total: %d plates, %d tracked by HP"
    
    ---------------------------------------------------------------------------
    -- Debug Messages
    ---------------------------------------------------------------------------
    L["DEBUG_TARGET_HEADER"] = "%s (%s)"
    L["DEBUG_GUID"] = "  GUID: %s"
    L["DEBUG_HEALTH"] = "  Health: %d / %d (%.0f%%)"
    L["DEBUG_ENGINE"] = "  Engine: myGUID=%s  inUnitMap=%s  myUnit=%s"
    L["DEBUG_AURA_HEADER"] = "  |cffaaaaff[Heal-related auras]|r"
    L["DEBUG_AURA_ENTRY"] = "    [%s] id=%s rank=%s tick=%s cast=%s src=%s"
    L["DEBUG_HEAL_DATA"] = "  Engine: self=%.0f  others=%.0f  mod=%.2f"
    L["DEBUG_TICK_ENTRY"] = "  |cff44ff44TICK|r [%s] from %s: amt=%.0f stacks=%d tLeft=%d end=%.1f"
    L["DEBUG_CAST_ENTRY"] = "  |cffffff44CAST|r [%s id=%d] from %s: amt=%.0f end=%.1f"
    L["DEBUG_NO_HEALS"] = "  No active heal records on this target."
    L["DEBUG_SHIELD"] = "  |cff8888ffShield absorb:|r %d"
    L["DEBUG_SETTINGS"] = "  testMode=%s  showOthers=%s  filterHoT=%s"
    L["DEBUG_BAR_HEADER"] = "  |cffffaa44[Health bar state]|r"
    L["DEBUG_BAR_ENTRY"] = "    [%s] type=%s  bar: %d/%d (%.0f%%)  w=%.0f  vis=%s"
    L["DEBUG_BAR_API"] = "    API: UnitHealth=%d  UnitHealthMax=%d"
    
    ---------------------------------------------------------------------------
    -- Shield Abbreviations (keep short!)
    ---------------------------------------------------------------------------
    L["SHIELD_PWS"] = "PW:S"
    L["SHIELD_ICEBARRIER"] = "IceBr"
    L["SHIELD_MANASHIELD"] = "ManS"
    L["SHIELD_SACRIFICE"] = "Sacr"
    L["SHIELD_FIREWARD"] = "FirW"
    L["SHIELD_FROSTWARD"] = "FroW"
    L["SHIELD_SHADOWWARD"] = "ShdW"
    
    ---------------------------------------------------------------------------
    -- Minimap Button Tooltip
    ---------------------------------------------------------------------------
    L["MINIMAP_TITLE"] = "|cff33ccffHealPredict|r"
    L["MINIMAP_LEFTCLICK"] = "Left-click: Toggle options"
    L["MINIMAP_SHIFT_CLICK"] = "Shift-left-click: Changelog"
    L["MINIMAP_RIGHTCLICK"] = "Right-click: Toggle test mode"
    L["MINIMAP_DRAG"] = "Drag: Reposition"
    
    ---------------------------------------------------------------------------
    -- Test Mode
    ---------------------------------------------------------------------------
    L["TEST_FRAME_LABEL"] = "HP Test"
    
    ---------------------------------------------------------------------------
    -- Text Overlays / Status
    ---------------------------------------------------------------------------
    L["TEXT_RES"] = "|cff44ff44RES|r"
    L["TEXT_OOM"] = "OOM: %ds"
    L["TEXT_FULL_MANA_SEC"] = "Full: %ds"
    L["TEXT_FULL_MANA_MIN"] = "Full: %dm"
    L["TEXT_DEFICIT"] = "|cffff4444-%d|r"
    L["TEXT_HEAL_REDUCTION"] = "-%d%%"
    
    ---------------------------------------------------------------------------
    -- External Cooldown Abbreviations
    ---------------------------------------------------------------------------
    L["CD_PAIN_SUPPRESSION"] = "PSUP"
    L["CD_POWER_INFUSION"] = "PINF"
    L["CD_BLESSING_PROTECTION"] = "BPROT"
    L["CD_BLESSING_SACRIFICE"] = "BSAC"
    L["CD_INNERVATE"] = "INNERV"
    L["CD_MANA_TIDE"] = "MTIDE"
    L["CD_HEROISM"] = "HERO"
    L["CD_BLOODLUST"] = "BLUST"
    
    ---------------------------------------------------------------------------
    -- Defensive Cooldown Abbreviations
    ---------------------------------------------------------------------------
    L["DEF_DIVINE_SHIELD"] = "DVSHD"
    L["DEF_ICE_BLOCK"] = "ICEBL"
    L["DEF_DIVINE_INTERVENTION"] = "DVINT"
    L["DEF_DIVINE_PROTECTION"] = "DVPRO"
    L["DEF_SHIELD_WALL"] = "SWALL"
    L["DEF_EVASION"] = "EVASN"
    L["DEF_BARKSKIN"] = "BSKIN"
    
    ---------------------------------------------------------------------------
    -- Color Tooltip Explanations
    ---------------------------------------------------------------------------
    L["COLOR_TOOLTIP_MY_RAID"] = "Your own heal predictions on raid and compact unit frames."
    L["COLOR_TOOLTIP_OTHER_RAID"] = "Other players' heal predictions on raid and compact unit frames."
    L["COLOR_TOOLTIP_MY_UNIT"] = "Your own heal predictions on player, target, party, and focus frames."
    L["COLOR_TOOLTIP_OTHER_UNIT"] = "Other players' heal predictions on player, target, party, and focus frames."
    L["COLOR_TOOLTIP_HOT_EXPIRY"] = "Border color when your HoTs are about to expire on a target."
    L["COLOR_TOOLTIP_DISPEL_MAGIC"] = "Overlay color for Magic debuffs."
    L["COLOR_TOOLTIP_DISPEL_CURSE"] = "Overlay color for Curse debuffs."
    L["COLOR_TOOLTIP_DISPEL_DISEASE"] = "Overlay color for Disease debuffs."
    L["COLOR_TOOLTIP_DISPEL_POISON"] = "Overlay color for Poison debuffs."
    L["COLOR_TOOLTIP_CLUSTER"] = "Border color for cluster-detected subgroup members."
    L["COLOR_TOOLTIP_AOE"] = "Border color for the AoE heal target advisor highlight."

    ---------------------------------------------------------------------------
    -- Instance Tracking
    ---------------------------------------------------------------------------
    L["INSTANCE_TRACKING"] = "Instance Tracking"
    L["INSTANCE_TRACKING_STARTED"] = "Instance tracking started"
    L["INSTANCE_RUN_ENDED"] = "Instance run ended"
    L["INSTANCE_PROGRESS"] = "Instance Progress"
    L["INSTANCE_HPS_ABOVE_AVG"] = "HPS above instance average"
end
