-- HealPredict - German (deDE) Localization
-- Deutsche Übersetzung
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn

local _, HP = ...

if not HP.LocaleData then HP.LocaleData = {} end

HP.LocaleData["deDE"] = function(L)
    ---------------------------------------------------------------------------
    -- Core Addon Info
    ---------------------------------------------------------------------------
    L["ADDON_NAME"] = "HealPredict"
    L["VERSION_AUTHOR"] = "v%s  von DarkpoisOn"
    
    ---------------------------------------------------------------------------
    -- Profile Section
    ---------------------------------------------------------------------------
    L["PROFILE_LABEL"] = "Profil:"
    L["PROFILE_NEW"] = "Neu"
    L["PROFILE_COPY"] = "Kopieren"
    L["PROFILE_DELETE"] = "Löschen"
    L["PROFILE_EXPORT"] = "Export"
    L["PROFILE_IMPORT"] = "Import"
    L["PROFILE_DEFAULT"] = "Standard"
    
    ---------------------------------------------------------------------------
    -- Dialog / Popup Texts
    ---------------------------------------------------------------------------
    L["DIALOG_NEW_PROFILE"] = "Neuen Profilnamen eingeben:"
    L["DIALOG_CREATE"] = "Erstellen"
    L["DIALOG_CANCEL"] = "Abbrechen"
    L["DIALOG_COPY_PROFILE"] = "Aktuelles Profil kopieren nach:"
    L["DIALOG_DELETE_CONFIRM"] = "Profil '%s' löschen?\nDieser Charakter wechselt zum Standardprofil."
    L["DIALOG_DELETE"] = "Löschen"
    L["DIALOG_EXPORT_TITLE"] = "Diesen String kopieren, um dein Profil zu teilen:"
    L["DIALOG_DONE"] = "Fertig"
    L["DIALOG_IMPORT_TITLE"] = "HealPredict Profil-String einfügen:"
    L["DIALOG_IMPORT_BUTTON"] = "Importieren"
    
    ---------------------------------------------------------------------------
    -- Tab Names
    ---------------------------------------------------------------------------
    L["TAB_GENERAL"] = "Allgemein"
    L["TAB_DISPLAY"] = "Anzeige"
    L["TAB_COLORS"] = "Farben"
    
    ---------------------------------------------------------------------------
    -- Section Headers (General Tab)
    ---------------------------------------------------------------------------
    L["SECTION_HEALING_FILTERS"] = "HEILUNGSFILTER"
    L["SECTION_THRESHOLDS"] = "SCHWELLENWERTE"
    L["SECTION_OVERFLOW_LIMITS"] = "ÜBERHEILUNGS-LIMITS"
    L["SECTION_PERFORMANCE"] = "LEISTUNG"
    L["SECTION_PROFILE_AUTO_SWITCH"] = "PROFIL-AUTOMATIK"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Healing Filters)
    ---------------------------------------------------------------------------
    L["SHOW_HEALING_FROM_OTHERS"] = "Heilung anderer Spieler anzeigen"
    L["DIRECT_HEALS"] = "Direkte Heilungen"
    L["HOT_HEALS"] = "HoT (Heilung über Zeit)"
    L["CHANNELED_HEALS"] = "Kanalisierte Heilungen"
    L["BOMB_HEALS"] = "Bomben-Heilungen (Gebet der Besserung, etc.)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Thresholds)
    ---------------------------------------------------------------------------
    L["LIMIT_PREDICTION_WINDOW"] = "Vorhersagefenster begrenzen"
    L["DIM_NON_IMMINENT_HEALS"] = "Nicht-unmittelbare Heilungen abdunkeln"
    L["RECOLOR_OVERHEAL"] = "Balken einfärben bei Überheilung über (%)"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (General Tab)
    ---------------------------------------------------------------------------
    L["SLIDER_DIRECT_TF"] = "Direkt: %.1fs"
    L["SLIDER_CHANNEL_TF"] = "Kanalisiert: %.1fs"
    L["SLIDER_HOT_TF"] = "HoT: %.1fs"
    L["SLIDER_POLL_RATE"] = "Aktualisierung: %d FPS"
    L["SLIDER_PANEL_SCALE"] = "Fenstergröße: %d%%"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Overflow)
    ---------------------------------------------------------------------------
    L["CAP_RAID_OVERFLOW"] = "Raid-Überheilung begrenzen (%)"
    L["CAP_UNIT_OVERFLOW"] = "Einheiten-Überheilung begrenzen (%)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Performance)
    ---------------------------------------------------------------------------
    L["FAST_RAID_UPDATES"] = "Schnelle Raid-Frame-Aktualisierung"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Auto-Switch)
    ---------------------------------------------------------------------------
    L["AUTO_SWITCH_PROFILES"] = "Profile automatisch nach Gruppengröße wechseln"
    L["AUTO_SWITCH_SOLO"] = "Solo:"
    L["AUTO_SWITCH_PARTY"] = "Gruppe:"
    L["AUTO_SWITCH_RAID"] = "Raid:"
    
    ---------------------------------------------------------------------------
    -- Section Headers (Display Tab)
    ---------------------------------------------------------------------------
    L["SECTION_FRAME_VISIBILITY"] = "FRAME-SICHTBARKEIT"
    L["SECTION_BARS_OVERLAYS"] = "BALKEN & OVERLAYS"
    L["SECTION_SHIELDS_ABSORBS"] = "SCHILDE & ABSORPTIONEN"
    L["SECTION_DEFENSIVES"] = "DEFENSIVFÄHIGKEITEN"
    L["SECTION_TEXT_OVERLAYS"] = "TEXT-OVERLAYS"
    L["SECTION_RAID_FRAME_INDICATORS"] = "RAID-FRAME-INDIKATOREN"
    L["SECTION_INDICATORS"] = "INDIKATOREN"
    L["SECTION_PLAYER_MANA"] = "SPIELER-MANA"
    L["SECTION_ALERTS"] = "ALARME"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Frame Visibility)
    ---------------------------------------------------------------------------
    L["SHOW_ON_PLAYER"] = "Auf Spieler-Frame anzeigen"
    L["SHOW_ON_TARGET"] = "Auf Ziel-Frame anzeigen"
    L["SHOW_ON_TOT"] = "Auf Ziel-des-Ziels-Frame anzeigen"
    L["SHOW_ON_FOCUS"] = "Auf Fokus-Frame anzeigen"
    L["SHOW_ON_PARTY"] = "Auf Gruppen-Frames anzeigen"
    L["SHOW_ON_PET"] = "Auf Begleiter-Frames anzeigen"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Bars & Overlays)
    ---------------------------------------------------------------------------
    L["OVERLAY_MODE"] = "Overlay-Modus (eigene + fremde Heilungen überlagern)"
    L["SMART_HEAL_ORDERING"] = "Intelligente Heilungs-Sortierung (Ankunftszeit)"
    L["USE_RAID_TEXTURE"] = "Raid-Textur auf Einheiten-Frames verwenden"
    L["SHOW_MANA_COST"] = "Manakosten auf Spieler-Manabalken anzeigen"
    L["OVERHEAL_BAR"] = "Überheilungs-Balken"
    L["OVERHEAL_GRADIENT"] = "Überheilungs-Farbverlauf"
    L["SHOW_NAMEPLATES"] = "Heilungsbalken auf freundlichen Namensplaketten"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Display Tab)
    ---------------------------------------------------------------------------
    L["SLIDER_BAR_OPACITY"] = "Balken-Deckkraft: %d%%"
    L["LBL_BAR_OPACITY"] = "Steuert die Deckkraft der Heilungsvorhersage-Balken"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Shields & Absorbs)
    ---------------------------------------------------------------------------
    L["SHIELD_GLOW"] = "Schild-Leuchten auf Gesundheitsbalken"
    L["SHIELD_TEXT"] = "Schild-Zaubername anzeigen"
    L["ABSORB_BAR"] = "Absorptions-Balken auf Gesundheitsbalken"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Display Tab - Shield Offset)
    ---------------------------------------------------------------------------
    L["SLIDER_SHIELD_X"] = "X: %d"
    L["SLIDER_SHIELD_Y"] = "Y: %d"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Defensives)
    ---------------------------------------------------------------------------
    L["DEFENSIVE_STATUS"] = "Defensiv-Status auf Raid-Frames"
    L["SHOW_INVULNS"] = "Unverwundbarkeiten (Gottesschild, Eisblock)"
    L["SHOW_STRONG_MIT"] = "Starke Mitigation (SE, Schildwall)"
    L["SHOW_WEAK_MIT"] = "Schwache Mitigation (Entrinnen, Baumrinde)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Text Overlays)
    ---------------------------------------------------------------------------
    L["PREDICTIVE_DEFICIT"] = "Prognostiziertes Gesundheitsdefizit auf Raid-Frames"
    L["INCOMING_HEAL_TEXT"] = "Eingehende Heilung als Text auf Einheiten-Frames"
    
    ---------------------------------------------------------------------------
    -- Position Labels
    ---------------------------------------------------------------------------
    L["POSITION"] = "Position:"
    L["POS_LEFT"] = "Links"
    L["POS_RIGHT"] = "Rechts"
    L["POS_ABOVE"] = "Oben"
    L["POS_BELOW"] = "Unten"
    L["POS_CENTER"] = "Mitte"
    L["POS_TOP_LEFT"] = "Oben-Links"
    L["POS_TOP_RIGHT"] = "Oben-Rechts"
    L["POS_BOTTOM_LEFT"] = "Unten-Links"
    L["POS_BOTTOM_RIGHT"] = "Unten-Rechts"
    
    L["HEALTXT_POS_PREFIX"] = "Position: %s"
    L["HEALER_POS_PREFIX"] = "Position: %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Raid Frame Indicators)
    ---------------------------------------------------------------------------
    L["HEALER_COUNT"] = "Heiler-Anzahl pro Ziel anzeigen"
    L["PREDICTIVE_TRAJECTORY"] = "Prognostizierte Gesundheitstrajektorie"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Trajectory)
    ---------------------------------------------------------------------------
    L["SLIDER_TRAJECTORY_WINDOW"] = "Fenster: %ds"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Range)
    ---------------------------------------------------------------------------
    L["DIM_OUT_OF_RANGE"] = "Außer-Reichweite-Ziele abdunkeln"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Range)
    ---------------------------------------------------------------------------
    L["SLIDER_DIMMED_OPACITY"] = "Abgedunkelte Deckkraft: %d%%"
    
    ---------------------------------------------------------------------------
    -- Effect Style Labels
    ---------------------------------------------------------------------------
    L["EFFECT_STYLE"] = "Stil:"
    L["STYLE_STATIC"] = "Statisch"
    L["STYLE_GLOW"] = "Leuchten"
    L["STYLE_SPINNING"] = "Drehend"
    L["STYLE_SLASHES"] = "Striche"
    
    L["STYLE_PREFIX"] = "Stil: %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Indicators)
    ---------------------------------------------------------------------------
    L["DISPEL_HIGHLIGHT"] = "Dispel-Hervorhebung auf Raid-Frames"
    L["HEAL_REDUCTION_GLOW"] = "Heilungsreduktions-Indikator"
    L["SHOW_REDUCTION_TEXT"] = "Reduktions-Prozentsatz anzeigen"
    L["CHARMED_INDICATOR"] = "Bezaubert/Besessen-Indikator"
    L["HOT_EXPIRY_WARNING"] = "HoT-Ablauf-Warnrahmen"
    L["INCOMING_RES"] = "Eingehende Wiederbelebung anzeigen"
    L["RAID_COOLDOWN_TRACKER"] = "Raid-Cooldown-Tracker"
    L["CLUSTER_DETECTION"] = "Cluster-Erkennung"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Indicators)
    ---------------------------------------------------------------------------
    L["SLIDER_INDICATOR_BORDER"] = "Indikator-Rahmen: %dpx"
    L["SLIDER_HOT_EXPIRY_THRESHOLD"] = "Schwellenwert: %ds"
    L["SLIDER_CLUSTER_THRESHOLD"] = "GS-Schwellenwert: %d%%"
    L["SLIDER_CLUSTER_MIN"] = "Min. Mitglieder: %d"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - AoE & Mana)
    ---------------------------------------------------------------------------
    L["AOE_HEAL_ADVISOR"] = "AoE-Heilungs-Berater"
    L["LOW_MANA_WARNING"] = "Niedriges-Mana-Warnung auf Raid-Frames (Heiler)"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Low Mana)
    ---------------------------------------------------------------------------
    L["SLIDER_LOW_MANA_THRESHOLD"] = "Mana-Schwellenwert: %d%%"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Player Mana)
    ---------------------------------------------------------------------------
    L["MANA_FORECAST"] = "Mana-Nachhaltigkeits-Prognose"
    L["OOC_REGEN_TIMER"] = "Außer-Kampf-Regenerations-Timer"
    
    ---------------------------------------------------------------------------
    -- Button Labels (Mana Position)
    ---------------------------------------------------------------------------
    L["FORECAST_POS_PREFIX"] = "Position: %s"
    L["OOC_POS_PREFIX"] = "Position: %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Alerts)
    ---------------------------------------------------------------------------
    L["HEAL_SNIPE_DETECTION"] = "Heilungs-Snipe-Erkennung"
    L["TRACK_HEALING_EFFICIENCY"] = "Heilungseffizienz tracken (/hp stats)"
    L["SOUND_DISPEL"] = "Sound-Alarm: Dispel benötigt"
    L["SOUND_LOW_MANA"] = "Sound-Alarm: Heiler niedriges Mana"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Snipe)
    ---------------------------------------------------------------------------
    L["SLIDER_SNIPE_THRESHOLD"] = "Schwellenwert: %d%%"
    
    ---------------------------------------------------------------------------
    -- Sound Selection Labels
    ---------------------------------------------------------------------------
    L["SOUND_RAID_WARNING"] = "Schlachtzugswarnung"
    L["SOUND_READY_CHECK"] = "Bereitschaftscheck"
    L["SOUND_ALARM_CLOCK"] = "Wecker"
    L["SOUND_FLAG_CAPTURED"] = "Flagge erobert"
    L["SOUND_NONE"] = "Keiner"
    
    ---------------------------------------------------------------------------
    -- Section Headers (Colors Tab)
    ---------------------------------------------------------------------------
    L["SECTION_BAR_COLORS"] = "BALKENFARBEN"
    L["SECTION_FEATURE_COLORS"] = "FEATURE-FARBEN"
    L["SECTION_MISC"] = "SONSTIGES"
    
    ---------------------------------------------------------------------------
    -- Color Row Labels
    ---------------------------------------------------------------------------
    L["COLOR_MY_RAID_HEALS"] = "Meine Raid-Heilungen:"
    L["COLOR_OTHER_RAID_HEALS"] = "Andere Raid-Heilungen:"
    L["COLOR_MY_UNIT_HEALS"] = "Meine Einheiten-Heilungen:"
    L["COLOR_OTHER_UNIT_HEALS"] = "Andere Einheiten-Heilungen:"
    
    L["COLOR_ABSORB_BAR"] = "Absorptions-Balken:"
    L["COLOR_OVERHEAL_BAR"] = "Überheilungs-Balken:"
    L["COLOR_MANA_COST"] = "Manakosten:"
    L["COLOR_HOT_EXPIRY"] = "HoT-Ablauf:"
    L["COLOR_DISPEL_MAGIC"] = "Magie dispellen:"
    L["COLOR_DISPEL_CURSE"] = "Fluch dispellen:"
    L["COLOR_DISPEL_DISEASE"] = "Krankheit dispellen:"
    L["COLOR_DISPEL_POISON"] = "Gift dispellen:"
    L["COLOR_CLUSTER_BORDER"] = "Cluster-Rahmen:"
    L["COLOR_HEAL_REDUCTION"] = "Heilungsreduktion:"
    L["COLOR_CHARMED"] = "Bezaubert/Besessen:"
    L["COLOR_AOE_ADVISOR"] = "AoE-Berater:"
    
    ---------------------------------------------------------------------------
    -- Color Swatch Labels
    ---------------------------------------------------------------------------
    L["SWATCH_DIRECT"] = "Direkt"
    L["SWATCH_HOT"] = "HoT"
    L["SWATCH_DIRECT_OH"] = "Direkt (ÜH)"
    L["SWATCH_HOT_OH"] = "HoT (ÜH)"
    
    ---------------------------------------------------------------------------
    -- Button Labels (Colors Tab)
    ---------------------------------------------------------------------------
    L["FLIP_MY_OTHER"] = "Eigene/Fremde tauschen"
    L["SHOW_MINIMAP"] = "Minimap-Button anzeigen"
    
    ---------------------------------------------------------------------------
    -- Bottom Buttons
    ---------------------------------------------------------------------------
    L["BUTTON_DEFAULTS"] = "Standard"
    L["BUTTON_TEST_MODE"] = "Testmodus"
    
    ---------------------------------------------------------------------------
    -- Tooltips (General Tab)
    ---------------------------------------------------------------------------
    L["TOOLTIP_SHOW_OTHERS"] = "Heilungsvorhersagen anderer Heiler im Schlachtzug oder in der Gruppe anzeigen."
    L["TOOLTIP_TIME_LIMIT"] = "Nur Heilungen anzeigen, die innerhalb des angegebenen Zeitrahmens landen. Nützlich zum Filtern langer HoTs, die die Anzeige überladen würden."
    L["TOOLTIP_DIM_NON_IMMINENT"] = "Reduziert die Deckkraft von HoT-/Kanalisierungs-Balken, um sie von bald landenden Direktheilungen zu unterscheiden."
    L["TOOLTIP_FAST_UPDATES"] = "Aktualisiert Raid-Frames mit fester Rate für flüssigere Balken-Updates. Verwendet mehr CPU. Ohne dies aktualisieren Balken nur bei Gesundheits-/Heilungs-Ereignissen."
    L["TOOLTIP_AUTO_SWITCH"] = "Automatisch zwischen Profilen wechseln, wenn du einer Gruppe/Raid beitrittst oder sie verlässt."
    L["TOOLTIP_AUTO_SWITCH_BTN"] = "Klicken, um durch verfügbare Profile zu wechseln."
    
    ---------------------------------------------------------------------------
    -- Tooltips (Display Tab)
    ---------------------------------------------------------------------------
    L["TOOLTIP_OVERLAY_MODE"] = "Wenn aktiviert, überlagern eigene und fremde Heilungen statt End-zu-End zu stapeln. Zeigt die größere der beiden."
    L["TOOLTIP_SMART_ORDERING"] = "Sortiert Heilungsbalken nach Ankunftszeit: Fremde Heilungen vor eigenen, eigene Heilung, fremde danach, dann alle HoTs."
    L["TOOLTIP_HEALER_COUNT"] = "Zeigt die Anzahl aktiver Heiler, die auf jedes Raid-Ziel zaubern."
    L["TOOLTIP_HEALER_COUNT_POS"] = "Klicken zum Wechseln: Oben-Links, Oben-Rechts, Unten-Links, Unten-Rechts."
    L["TOOLTIP_HEAL_TEXT_POS"] = "Klicken zum Wechseln: Links, Rechts, Oben, Unten vom Gesundheitsbalken."
    L["TOOLTIP_TRAJECTORY"] = "Zeigt einen Marker, der vorhersagt, wo die Gesundheit basierend auf der eingehenden Schadensrate sein wird."
    L["TOOLTIP_RANGE_INDICATOR"] = "Reduziert die Deckkraft von Heilungsbalken auf Raid-Frames, wenn das Ziel außer Heilungsreichweite ist."
    L["TOOLTIP_EFFECT_STYLE"] = "Statisch: Fester Rahmen. Leuchten: Pulsierende Alpha. Drehend: Orbitierende Punkte. Striche: Diagonale Linien, die durchsweepen."
    L["TOOLTIP_DISPEL_HIGHLIGHT"] = "Färbt Raid-Frames ein, wenn ein Ziel einen dispellbaren Debuff hat, der zu deinen Klassenfähigkeiten passt."
    L["TOOLTIP_DISPEL_STYLE"] = "Klicken zum Wechseln: Statisch, Leuchten, Drehende Punkte, Striche."
    L["TOOLTIP_DISPEL_SOUND"] = "Klicken, um durch verfügbare Sounds zu wechseln."
    L["TOOLTIP_HEAL_REDUCTION"] = "Zeigt einen roten Schein und Prozentsatz auf Raid-Frames, wenn ein Ziel einen Heilungsreduktions-Debuff hat (Tödlicher Stoß, etc.)."
    L["TOOLTIP_CHARMED"] = "Zeigt einen Magenta/Lila-Indikator, wenn ein Teammitglied gedankenkontrolliert oder bezaubert ist (feindlich zu dir)."
    L["TOOLTIP_HOT_EXPIRY"] = "Zeigt einen orangefarbenen Rahmen, wenn deine HoTs an einem Ziel bald ablaufen."
    L["TOOLTIP_RES_TRACKER"] = "Zeigt 'RES' auf toten Raid-Mitgliedern, die von Gruppen-/Raid-Mitgliedern wiederbelebt werden."
    L["TOOLTIP_RAID_CD_TRACKER"] = "Zeigt externe Cooldowns auf Raid-Frame-Zielen (Schmerzunterdrückung, SE, Anregung, etc.)."
    L["TOOLTIP_CLUSTER_DETECTION"] = "Hebt Untergruppen hervor, in denen mehrere Mitglieder unter einem Gesundheitsschwellenwert sind."
    L["TOOLTIP_AOE_ADVISOR"] = "Hebt das beste Ziel für AoE-Heilungen basierend auf Untergruppen-Gesundheitsdefiziten in Raids hervor."
    L["TOOLTIP_LOW_MANA"] = "Zeigt Mana-Prozentsatz auf Raid-Frames für Heiler-Klassen (Priester, Paladin, Druide, Schamane) wenn unter dem Schwellenwert."
    L["TOOLTIP_MANA_FORECAST"] = "Zeigt geschätzte Zeit bis OOM auf dem Spieler-Frame während des Mana-Verbrauchs."
    L["TOOLTIP_MANA_FORECAST_POS"] = "Klicken zum Wechseln: Oben, Mitte, Unten, Rechts vom Manabalken."
    L["TOOLTIP_OOC_REGEN"] = "Zeigt geschätzte Zeit bis volles Mana, wenn außer Kampf mit niedrigem Mana."
    L["TOOLTIP_OOC_REGEN_POS"] = "Klicken zum Wechseln: Oben, Mitte, Unten, Rechts vom Manabalken."
    L["TOOLTIP_SNIPE_DETECTION"] = "Blitzt den Raid-Frame auf, wenn deine Heilung durch Überheilung weitgehend verschwendet wurde."
    L["TOOLTIP_EFFICIENCY"] = "Speichert effektive Heilung vs Überheilung pro Zauber. Anzeigen mit /hp stats, zurücksetzen mit /hp stats reset."
    L["TOOLTIP_SOUND_DISPEL"] = "Spielt einen Sound, wenn ein neuer dispellbarer Debuff erkannt wird. Entprellt (max. 1 pro 5s)."
    L["TOOLTIP_SOUND_LOW_MANA"] = "Spielt einen Sound, wenn das Mana eines Heilers unter den niedrigen Mana-Schwellenwert fällt. Entprellt (max. 1 pro 5s)."
    L["TOOLTIP_OVERHEAL_GRADIENT"] = "Färbt Überheilungsbalken nach Schwere ein: Grün (niedrig) über Orange bis Rot (hoch)."
    L["TOOLTIP_LOW_MANA_SOUND"] = "Klicken, um durch verfügbare Sounds zu wechseln."
    
    ---------------------------------------------------------------------------
    -- Chat Messages (Print statements)
    ---------------------------------------------------------------------------
    L["MSG_PREFIX"] = "|cff33ccffHealPredict:|r"
    L["MSG_PREFIX_ERROR"] = "|cff33ccffHealPredict:|r |cffff4444Fehler:|r"
    L["MSG_PREFIX_DEBUG"] = "|cff33ccffHealPredict Debug|r"
    
    L["MSG_PROFILE_EXISTS"] = "Profil '%s' existiert bereits."
    L["MSG_CANNOT_DELETE_DEFAULT"] = "Das Standardprofil kann nicht gelöscht werden."
    L["MSG_PROFILE_DELETED"] = "Profil '%s' gelöscht."
    L["MSG_PROFILE_COPIED"] = "Kopiert nach '%s'"
    L["MSG_IMPORT_SUCCESS"] = "Profil erfolgreich importiert."
    L["MSG_IMPORT_FAILED"] = "Import fehlgeschlagen: %s"
    L["MSG_IMPORT_EMPTY"] = "Leere Eingabe"
    L["MSG_IMPORT_INVALID_FORMAT"] = "Ungültiges Format (HP1: Präfix fehlt)"
    L["MSG_IMPORT_UNKNOWN_VERSION"] = "Unbekannte Version: %s"
    L["MSG_IMPORT_DECODE_FAILED"] = "Base64-Dekodierung fehlgeschlagen"
    L["MSG_IMPORT_DESERIALIZE_FAILED"] = "Deserialisierung fehlgeschlagen"
    L["MSG_IMPORT_INVALID_DATA"] = "Daten scheinen kein HealPredict-Profil zu sein"
    
    L["MSG_NOT_IN_GROUP"] = "Nicht in einer Gruppe."
    L["MSG_RAID_CHECK_TITLE"] = "Raid-Heilungsdaten-Check:"
    L["MSG_HAS_HEAL_DATA"] = "|cff44ff44Senden Heilungsdaten:|r"
    L["MSG_NO_HEAL_DATA"] = "|cffff8844Keine Heilungsdaten (noch):|r"
    L["MSG_NO_HEALERS"] = "Keine Heiler in der Gruppe gefunden."
    L["MSG_NO_DATA_NOTE"] = "|cff888888Hinweis: 'Keine Daten' bedeutet, noch keine Heilungen erkannt.|r"
    
    L["MSG_NO_HEALING_DATA"] = "Keine Heilungsdaten aufgezeichnet. Aktiviere 'Heilungseffizienz tracken' und heile!"
    L["MSG_EFFICIENCY_REPORT"] = "Heilungseffizienz-Bericht (%dm Session)"
    L["MSG_EFFICIENCY_RESET"] = "Effizienz-Daten zurückgesetzt."
    L["MSG_SPELL_STATS"] = "  |cffffffff%s|r: %dx | %d eff | %d uh | |cff%s%d%%|r"
    
    L["MSG_SNIPE_REPORT_TITLE"] = "Snipe-Bericht:"
    L["MSG_NO_SNIPES"] = "Keine Snipes in dieser Session erkannt."
    L["MSG_SNIPE_TOTAL"] = "  Snipes insgesamt: |cffff4444%d|r"
    L["MSG_SNIPE_WASTED"] = "  Verschwendete Heilung insgesamt: |cffff4444%d|r"
    L["MSG_SNIPE_RECENT"] = "  Kürzliche Snipes:"
    L["MSG_SNIPE_ENTRY"] = "    %s - %d/%d überheilt (%.0f%%)"
    
    L["MSG_RENDER_ERROR"] = "Render-Fehler: %s"
    
    L["MSG_NAMEPLATE_DEBUG_TITLE"] = "|cff33ccffHealPredict Namensplaketten-Debug|r"
    L["MSG_NAMEPLATE_SETTINGS"] = "  showNameplates=%s"
    L["MSG_NAMEPLATE_ENTRY"] = "  [%s] einheit=%s freundlich=%s uf=%s hb=%s getrackt=%s"
    L["MSG_NAMEPLATE_NONE"] = "  Keine Namensplaketten aktuell sichtbar."
    L["MSG_NAMEPLATE_TOTAL"] = "  Insgesamt: %d Plaketten, %d von HP getrackt"
    
    ---------------------------------------------------------------------------
    -- Debug Messages
    ---------------------------------------------------------------------------
    L["DEBUG_TARGET_HEADER"] = "%s (%s)"
    L["DEBUG_GUID"] = "  GUID: %s"
    L["DEBUG_HEALTH"] = "  Gesundheit: %d / %d (%.0f%%)"
    L["DEBUG_ENGINE"] = "  Engine: myGUID=%s  inUnitMap=%s  myUnit=%s"
    L["DEBUG_AURA_HEADER"] = "  |cffaaaaff[Heilungsrelevante Auren]|r"
    L["DEBUG_AURA_ENTRY"] = "    [%s] id=%s rang=%s tick=%s zauber=%s quelle=%s"
    L["DEBUG_HEAL_DATA"] = "  Engine: eigen=%.0f  andere=%.0f  mod=%.2f"
    L["DEBUG_TICK_ENTRY"] = "  |cff44ff44TICK|r [%s] von %s: men=%.0f stapel=%d tRest=%d ende=%.1f"
    L["DEBUG_CAST_ENTRY"] = "  |cffffff44ZAUBER|r [%s id=%d] von %s: men=%.0f ende=%.1f"
    L["DEBUG_NO_HEALS"] = "  Keine aktiven Heilungsaufzeichnungen für dieses Ziel."
    L["DEBUG_SHIELD"] = "  |cff8888ffSchild-Absorption:|r %d"
    L["DEBUG_SETTINGS"] = "  testMode=%s  showOthers=%s  filterHoT=%s"
    L["DEBUG_BAR_HEADER"] = "  |cffffaa44[Gesundheitsbalken-Status]|r"
    L["DEBUG_BAR_ENTRY"] = "    [%s] typ=%s  balken: %d/%d (%.0f%%)  b=%.0f  sichtb=%s"
    L["DEBUG_BAR_API"] = "    API: UnitHealth=%d  UnitHealthMax=%d"
    
    ---------------------------------------------------------------------------
    -- Shield Abbreviations (keep short!)
    ---------------------------------------------------------------------------
    L["SHIELD_PWS"] = "MW:S"
    L["SHIELD_ICEBARRIER"] = "EisBr"
    L["SHIELD_MANASHIELD"] = "ManS"
    L["SHIELD_SACRIFICE"] = "Opfr"
    L["SHIELD_FIREWARD"] = "FeuW"
    L["SHIELD_FROSTWARD"] = "FroW"
    L["SHIELD_SHADOWWARD"] = "SchatW"
    
    ---------------------------------------------------------------------------
    -- Minimap Button Tooltip
    ---------------------------------------------------------------------------
    L["MINIMAP_TITLE"] = "|cff33ccffHealPredict|r"
    L["MINIMAP_LEFTCLICK"] = "Linksklick: Optionen umschalten"
    L["MINIMAP_SHIFT_CLICK"] = "Shift-Linksklick: Changelog"
    L["MINIMAP_RIGHTCLICK"] = "Rechtsklick: Testmodus umschalten"
    L["MINIMAP_DRAG"] = "Ziehen: Positionieren"
    
    ---------------------------------------------------------------------------
    -- Test Mode
    ---------------------------------------------------------------------------
    L["TEST_FRAME_LABEL"] = "HP Test"
    
    ---------------------------------------------------------------------------
    -- Text Overlays / Status
    ---------------------------------------------------------------------------
    L["TEXT_RES"] = "|cff44ff44RES|r"
    L["TEXT_OOM"] = "OOM: %ds"
    L["TEXT_FULL_MANA_SEC"] = "Voll: %ds"
    L["TEXT_FULL_MANA_MIN"] = "Voll: %dm"
    L["TEXT_DEFICIT"] = "|cffff4444-%d|r"
    L["TEXT_HEAL_REDUCTION"] = "-%d%%"
    
    ---------------------------------------------------------------------------
    -- External Cooldown Abbreviations
    ---------------------------------------------------------------------------
    L["CD_PAIN_SUPPRESSION"] = "SCHM-UNTERD"
    L["CD_POWER_INFUSION"] = "MACHT"
    L["CD_BLESSING_PROTECTION"] = "SEGEN-SCH"
    L["CD_BLESSING_SACRIFICE"] = "SEGEN-OPFR"
    L["CD_INNERVATE"] = "ANREG"
    L["CD_MANA_TIDE"] = "MANA-FLUT"
    L["CD_HEROISM"] = "HELD"
    L["CD_BLOODLUST"] = "BLUTRAUSCH"
    
    ---------------------------------------------------------------------------
    -- Defensive Cooldown Abbreviations
    ---------------------------------------------------------------------------
    L["DEF_DIVINE_SHIELD"] = "GOTTES-SCHILD"
    L["DEF_ICE_BLOCK"] = "EISBLOCK"
    L["DEF_DIVINE_INTERVENTION"] = "GÖTTL-EINGR"
    L["DEF_DIVINE_PROTECTION"] = "GÖTTL-SCHUTZ"
    L["DEF_SHIELD_WALL"] = "SCHILDWALL"
    L["DEF_EVASION"] = "ENTRINNEN"
    L["DEF_BARKSKIN"] = "BAUMRINDE"
    
    ---------------------------------------------------------------------------
    -- Color Tooltip Explanations
    ---------------------------------------------------------------------------
    L["COLOR_TOOLTIP_MY_RAID"] = "Eigene Heilungsvorhersagen auf Raid- und Compact-Frames."
    L["COLOR_TOOLTIP_OTHER_RAID"] = "Heilungsvorhersagen anderer Spieler auf Raid- und Compact-Frames."
    L["COLOR_TOOLTIP_MY_UNIT"] = "Eigene Heilungsvorhersagen auf Spieler-, Ziel-, Gruppen- und Fokus-Frames."
    L["COLOR_TOOLTIP_OTHER_UNIT"] = "Heilungsvorhersagen anderer auf Spieler-, Ziel-, Gruppen- und Fokus-Frames."
    L["COLOR_TOOLTIP_HOT_EXPIRY"] = "Rahmenfarbe, wenn deine HoTs an einem Ziel bald ablaufen."
    L["COLOR_TOOLTIP_DISPEL_MAGIC"] = "Overlay-Farbe für Magie-Debuffs."
    L["COLOR_TOOLTIP_DISPEL_CURSE"] = "Overlay-Farbe für Fluch-Debuffs."
    L["COLOR_TOOLTIP_DISPEL_DISEASE"] = "Overlay-Farbe für Krankheits-Debuffs."
    L["COLOR_TOOLTIP_DISPEL_POISON"] = "Overlay-Farbe für Gift-Debuffs."
    L["COLOR_TOOLTIP_CLUSTER"] = "Rahmenfarbe für Cluster-erkannte Untergruppenmitglieder."
    L["COLOR_TOOLTIP_AOE"] = "Rahmenfarbe für den AoE-Heilungs-Berater-Highlight."

    ---------------------------------------------------------------------------
    -- Instance Tracking
    ---------------------------------------------------------------------------
    L["INSTANCE_TRACKING"] = "Instanz-Verfolgung"
    L["INSTANCE_TRACKING_STARTED"] = "Instanzverfolgung gestartet"
    L["INSTANCE_RUN_ENDED"] = "Instanzlauf beendet"
    L["INSTANCE_PROGRESS"] = "Instanzfortschritt"
    L["INSTANCE_HPS_ABOVE_AVG"] = "HPS über Instanzdurchschnitt"
end
