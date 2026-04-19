-- HealPredict - French (frFR) Localization
-- Traduction française
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn

local _, HP = ...

if not HP.LocaleData then HP.LocaleData = {} end

HP.LocaleData["frFR"] = function(L)
    ---------------------------------------------------------------------------
    -- Core Addon Info
    ---------------------------------------------------------------------------
    L["ADDON_NAME"] = "HealPredict"
    L["VERSION_AUTHOR"] = "v%s  par DarkpoisOn"
    
    ---------------------------------------------------------------------------
    -- Profile Section
    ---------------------------------------------------------------------------
    L["PROFILE_LABEL"] = "Profil :"
    L["PROFILE_NEW"] = "Nouveau"
    L["PROFILE_COPY"] = "Copier"
    L["PROFILE_DELETE"] = "Suppr"
    L["PROFILE_EXPORT"] = "Exporter"
    L["PROFILE_IMPORT"] = "Importer"
    L["PROFILE_DEFAULT"] = "Défaut"
    
    ---------------------------------------------------------------------------
    -- Dialog / Popup Texts
    ---------------------------------------------------------------------------
    L["DIALOG_NEW_PROFILE"] = "Entrez le nom du nouveau profil :"
    L["DIALOG_CREATE"] = "Créer"
    L["DIALOG_CANCEL"] = "Annuler"
    L["DIALOG_COPY_PROFILE"] = "Copier le profil actuel vers :"
    L["DIALOG_DELETE_CONFIRM"] = "Supprimer le profil '%s' ?\nCe personnage passera au profil Défaut."
    L["DIALOG_DELETE"] = "Supprimer"
    L["DIALOG_EXPORT_TITLE"] = "Copiez cette chaîne pour partager votre profil :"
    L["DIALOG_DONE"] = "Terminé"
    L["DIALOG_IMPORT_TITLE"] = "Collez une chaîne de profil HealPredict :"
    L["DIALOG_IMPORT_BUTTON"] = "Importer"
    
    ---------------------------------------------------------------------------
    -- Tab Names
    ---------------------------------------------------------------------------
    L["TAB_GENERAL"] = "Général"
    L["TAB_DISPLAY"] = "Affichage"
    L["TAB_COLORS"] = "Couleurs"
    
    ---------------------------------------------------------------------------
    -- Section Headers (General Tab)
    ---------------------------------------------------------------------------
    L["SECTION_HEALING_FILTERS"] = "FILTRES DE SOINS"
    L["SECTION_THRESHOLDS"] = "SEUILS"
    L["SECTION_OVERFLOW_LIMITS"] = "LIMITES DE DÉPASSEMENT"
    L["SECTION_PERFORMANCE"] = "PERFORMANCE"
    L["SECTION_PROFILE_AUTO_SWITCH"] = "CHANGEMENT AUTO DE PROFIL"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Healing Filters)
    ---------------------------------------------------------------------------
    L["SHOW_HEALING_FROM_OTHERS"] = "Afficher les soins des autres joueurs"
    L["DIRECT_HEALS"] = "Soins directs"
    L["HOT_HEALS"] = "HoT (soin sur la durée)"
    L["CHANNELED_HEALS"] = "Soins canalisés"
    L["BOMB_HEALS"] = "Soins-bombes (Prière de soins, etc.)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Thresholds)
    ---------------------------------------------------------------------------
    L["LIMIT_PREDICTION_WINDOW"] = "Limiter la fenêtre de prédiction"
    L["DIM_NON_IMMINENT_HEALS"] = "Atténuer les soins non imminents"
    L["RECOLOR_OVERHEAL"] = "Recolorer les barres si dépassement > (%)"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (General Tab)
    ---------------------------------------------------------------------------
    L["SLIDER_DIRECT_TF"] = "Direct : %.1fs"
    L["SLIDER_CHANNEL_TF"] = "Canalisé : %.1fs"
    L["SLIDER_HOT_TF"] = "HoT : %.1fs"
    L["SLIDER_POLL_RATE"] = "Taux de rafraîchissement : %d FPS"
    L["SLIDER_PANEL_SCALE"] = "Échelle du panneau : %d%%"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Overflow)
    ---------------------------------------------------------------------------
    L["CAP_RAID_OVERFLOW"] = "Limiter le dépassement raid (%)"
    L["CAP_UNIT_OVERFLOW"] = "Limiter le dépassement unité (%)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Performance)
    ---------------------------------------------------------------------------
    L["FAST_RAID_UPDATES"] = "Mises à jour rapides des cadres de raid"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Auto-Switch)
    ---------------------------------------------------------------------------
    L["AUTO_SWITCH_PROFILES"] = "Changer de profil selon la taille du groupe"
    L["AUTO_SWITCH_SOLO"] = "Solo :"
    L["AUTO_SWITCH_PARTY"] = "Groupe :"
    L["AUTO_SWITCH_RAID"] = "Raid :"
    
    ---------------------------------------------------------------------------
    -- Section Headers (Display Tab)
    ---------------------------------------------------------------------------
    L["SECTION_FRAME_VISIBILITY"] = "VISIBILITÉ DES CADRES"
    L["SECTION_BARS_OVERLAYS"] = "BARRES & SURCOUCHES"
    L["SECTION_SHIELDS_ABSORBS"] = "BOUCLIERS & ABSORPTIONS"
    L["SECTION_DEFENSIVES"] = "DÉFENSIFS"
    L["SECTION_TEXT_OVERLAYS"] = "SURCOUCHES DE TEXTE"
    L["SECTION_RAID_FRAME_INDICATORS"] = "INDICATEURS DE CADRE RAID"
    L["SECTION_INDICATORS"] = "INDICATEURS"
    L["SECTION_PLAYER_MANA"] = "MANA DU JOUEUR"
    L["SECTION_ALERTS"] = "ALERTES"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Frame Visibility)
    ---------------------------------------------------------------------------
    L["SHOW_ON_PLAYER"] = "Afficher sur le cadre Joueur"
    L["SHOW_ON_TARGET"] = "Afficher sur le cadre Cible"
    L["SHOW_ON_TOT"] = "Afficher sur le cadre Cible de la cible"
    L["SHOW_ON_FOCUS"] = "Afficher sur le cadre Focus"
    L["SHOW_ON_PARTY"] = "Afficher sur les cadres de Groupe"
    L["SHOW_ON_PET"] = "Afficher sur les cadres de Familier"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Bars & Overlays)
    ---------------------------------------------------------------------------
    L["OVERLAY_MODE"] = "Mode superposition (soins perso + autres)"
    L["SMART_HEAL_ORDERING"] = "Tri intelligent des soins (temps d'arrivée)"
    L["USE_RAID_TEXTURE"] = "Utiliser la texture raid sur les barres d'unité"
    L["SHOW_MANA_COST"] = "Afficher le coût en mana sur la barre de mana"
    L["OVERHEAL_BAR"] = "Barre de dépassement de soins"
    L["OVERHEAL_GRADIENT"] = "Dégradé de sévérité du dépassement"
    L["SHOW_NAMEPLATES"] = "Afficher les barres de soin sur les plaques de nom"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Display Tab)
    ---------------------------------------------------------------------------
    L["SLIDER_BAR_OPACITY"] = "Opacité des barres : %d%%"
    L["LBL_BAR_OPACITY"] = "Contrôle l'opacité des barres de prédiction de soins"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Shields & Absorbs)
    ---------------------------------------------------------------------------
    L["SHIELD_GLOW"] = "Lueur de bouclier sur les barres de vie"
    L["SHIELD_TEXT"] = "Afficher le nom du sort de bouclier"
    L["ABSORB_BAR"] = "Barre d'absorption sur les barres de vie"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Display Tab - Shield Offset)
    ---------------------------------------------------------------------------
    L["SLIDER_SHIELD_X"] = "X : %d"
    L["SLIDER_SHIELD_Y"] = "Y : %d"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Defensives)
    ---------------------------------------------------------------------------
    L["DEFENSIVE_STATUS"] = "Texte de statut défensif sur les cadres raid"
    L["SHOW_INVULNS"] = "Invulnérabilités (Bouclier divin, Bloc de glace)"
    L["SHOW_STRONG_MIT"] = "Mitigation forte (Bénédiction de protection, Mur)"
    L["SHOW_WEAK_MIT"] = "Mitigation faible (Evasion, Ecorce)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Text Overlays)
    ---------------------------------------------------------------------------
    L["PREDICTIVE_DEFICIT"] = "Déficit de vie prédictif sur les cadres raid"
    L["INCOMING_HEAL_TEXT"] = "Texte de soin entrant sur les cadres d'unité"
    
    ---------------------------------------------------------------------------
    -- Position Labels
    ---------------------------------------------------------------------------
    L["POSITION"] = "Position :"
    L["POS_LEFT"] = "Gauche"
    L["POS_RIGHT"] = "Droite"
    L["POS_ABOVE"] = "Dessus"
    L["POS_BELOW"] = "Dessous"
    L["POS_CENTER"] = "Centre"
    L["POS_TOP_LEFT"] = "Haut-Gauche"
    L["POS_TOP_RIGHT"] = "Haut-Droite"
    L["POS_BOTTOM_LEFT"] = "Bas-Gauche"
    L["POS_BOTTOM_RIGHT"] = "Bas-Droite"
    
    L["HEALTXT_POS_PREFIX"] = "Position : %s"
    L["HEALER_POS_PREFIX"] = "Position : %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Raid Frame Indicators)
    ---------------------------------------------------------------------------
    L["HEALER_COUNT"] = "Afficher le nombre de soigneurs par cible"
    L["PREDICTIVE_TRAJECTORY"] = "Trajectoire de vie prédictive"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Trajectory)
    ---------------------------------------------------------------------------
    L["SLIDER_TRAJECTORY_WINDOW"] = "Fenêtre : %ds"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Range)
    ---------------------------------------------------------------------------
    L["DIM_OUT_OF_RANGE"] = "Atténuer les cibles hors de portée"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Range)
    ---------------------------------------------------------------------------
    L["SLIDER_DIMMED_OPACITY"] = "Opacité atténuée : %d%%"
    
    ---------------------------------------------------------------------------
    -- Effect Style Labels
    ---------------------------------------------------------------------------
    L["EFFECT_STYLE"] = "Style :"
    L["STYLE_STATIC"] = "Statique"
    L["STYLE_GLOW"] = "Lueur"
    L["STYLE_SPINNING"] = "Rotation"
    L["STYLE_SLASHES"] = "Tranches"
    
    L["STYLE_PREFIX"] = "Style : %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Indicators)
    ---------------------------------------------------------------------------
    L["DISPEL_HIGHLIGHT"] = "Surbrillance de dissipation sur les cadres raid"
    L["HEAL_REDUCTION_GLOW"] = "Indicateur de réduction de soins"
    L["SHOW_REDUCTION_TEXT"] = "Afficher le pourcentage de réduction"
    L["CHARMED_INDICATOR"] = "Indicateur Charmé/Possédé"
    L["HOT_EXPIRY_WARNING"] = "Avertissement d'expiration de HoT"
    L["INCOMING_RES"] = "Suivi de résurrection entrante"
    L["RAID_COOLDOWN_TRACKER"] = "Suivi des cooldowns raid"
    L["CLUSTER_DETECTION"] = "Détection de clusters"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Indicators)
    ---------------------------------------------------------------------------
    L["SLIDER_INDICATOR_BORDER"] = "Bordure d'indicateur : %dpx"
    L["SLIDER_HOT_EXPIRY_THRESHOLD"] = "Seuil : %ds"
    L["SLIDER_CLUSTER_THRESHOLD"] = "Seuil PV : %d%%"
    L["SLIDER_CLUSTER_MIN"] = "Min. membres : %d"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - AoE & Mana)
    ---------------------------------------------------------------------------
    L["AOE_HEAL_ADVISOR"] = "Conseiller de cible de soins de zone"
    L["LOW_MANA_WARNING"] = "Avertissement mana faible sur les cadres raid (soigneurs)"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Low Mana)
    ---------------------------------------------------------------------------
    L["SLIDER_LOW_MANA_THRESHOLD"] = "Seuil de mana : %d%%"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Player Mana)
    ---------------------------------------------------------------------------
    L["MANA_FORECAST"] = "Prévision de durabilité du mana"
    L["OOC_REGEN_TIMER"] = "Minuteur de régénération hors combat"
    
    ---------------------------------------------------------------------------
    -- Button Labels (Mana Position)
    ---------------------------------------------------------------------------
    L["FORECAST_POS_PREFIX"] = "Position : %s"
    L["OOC_POS_PREFIX"] = "Position : %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Alerts)
    ---------------------------------------------------------------------------
    L["HEAL_SNIPE_DETECTION"] = "Détection de snipe de soins"
    L["TRACK_HEALING_EFFICIENCY"] = "Suivre l'efficacité de soins (/hp stats)"
    L["SOUND_DISPEL"] = "Alerte sonore : dissipation requise"
    L["SOUND_LOW_MANA"] = "Alerte sonore : soigneur à mana faible"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Snipe)
    ---------------------------------------------------------------------------
    L["SLIDER_SNIPE_THRESHOLD"] = "Seuil : %d%%"
    
    ---------------------------------------------------------------------------
    -- Sound Selection Labels
    ---------------------------------------------------------------------------
    L["SOUND_RAID_WARNING"] = "Avertissement de raid"
    L["SOUND_READY_CHECK"] = "Appel"
    L["SOUND_ALARM_CLOCK"] = "Réveil"
    L["SOUND_FLAG_CAPTURED"] = "Drapeau capturé"
    L["SOUND_NONE"] = "Aucun"
    
    ---------------------------------------------------------------------------
    -- Section Headers (Colors Tab)
    ---------------------------------------------------------------------------
    L["SECTION_BAR_COLORS"] = "COULEURS DES BARRES"
    L["SECTION_FEATURE_COLORS"] = "COULEURS DES FONCTIONNALITÉS"
    L["SECTION_MISC"] = "DIVERS"
    
    ---------------------------------------------------------------------------
    -- Color Row Labels
    ---------------------------------------------------------------------------
    L["COLOR_MY_RAID_HEALS"] = "Mes soins de raid :"
    L["COLOR_OTHER_RAID_HEALS"] = "Autres soins de raid :"
    L["COLOR_MY_UNIT_HEALS"] = "Mes soins d'unité :"
    L["COLOR_OTHER_UNIT_HEALS"] = "Autres soins d'unité :"
    
    L["COLOR_ABSORB_BAR"] = "Barre d'absorption :"
    L["COLOR_OVERHEAL_BAR"] = "Barre de dépassement :"
    L["COLOR_MANA_COST"] = "Coût en mana :"
    L["COLOR_HOT_EXPIRY"] = "Expiration HoT :"
    L["COLOR_DISPEL_MAGIC"] = "Dissipation Magie :"
    L["COLOR_DISPEL_CURSE"] = "Dissipation Malédiction :"
    L["COLOR_DISPEL_DISEASE"] = "Dissipation Maladie :"
    L["COLOR_DISPEL_POISON"] = "Dissipation Poison :"
    L["COLOR_CLUSTER_BORDER"] = "Bordure de cluster :"
    L["COLOR_HEAL_REDUCTION"] = "Réduction de soins :"
    L["COLOR_CHARMED"] = "Charmé/Possédé :"
    L["COLOR_AOE_ADVISOR"] = "Conseiller AoE :"
    
    ---------------------------------------------------------------------------
    -- Color Swatch Labels
    ---------------------------------------------------------------------------
    L["SWATCH_DIRECT"] = "Direct"
    L["SWATCH_HOT"] = "HoT"
    L["SWATCH_DIRECT_OH"] = "Direct (DP)"
    L["SWATCH_HOT_OH"] = "HoT (DP)"
    
    ---------------------------------------------------------------------------
    -- Button Labels (Colors Tab)
    ---------------------------------------------------------------------------
    L["FLIP_MY_OTHER"] = "Inverser Perso/Autres"
    L["SHOW_MINIMAP"] = "Afficher le bouton de la minicarte"
    
    ---------------------------------------------------------------------------
    -- Bottom Buttons
    ---------------------------------------------------------------------------
    L["BUTTON_DEFAULTS"] = "Défauts"
    L["BUTTON_TEST_MODE"] = "Mode Test"
    
    ---------------------------------------------------------------------------
    -- Tooltips (General Tab)
    ---------------------------------------------------------------------------
    L["TOOLTIP_SHOW_OTHERS"] = "Affiche les prédictions de soins des autres soigneurs dans votre raid ou groupe."
    L["TOOLTIP_TIME_LIMIT"] = "Affiche uniquement les soins qui arriveront dans le délai spécifié. Utile pour filtrer les HoTs longs qui encombreraient l'affichage."
    L["TOOLTIP_DIM_NON_IMMINENT"] = "Réduit l'opacité des barres HoT/canalisation pour les distinguer des soins directs arrivant bientôt."
    L["TOOLTIP_FAST_UPDATES"] = "Interroge les cadres de raid à intervalle fixe pour des mises à jour plus fluides. Utilise plus de CPU. Sans cela, les barres se mettent à jour uniquement sur les événements de vie/soins."
    L["TOOLTIP_AUTO_SWITCH"] = "Change automatiquement de profil quand vous rejoignez/quittez un groupe ou raid."
    L["TOOLTIP_AUTO_SWITCH_BTN"] = "Cliquez pour parcourir les profils disponibles."
    
    ---------------------------------------------------------------------------
    -- Tooltips (Display Tab)
    ---------------------------------------------------------------------------
    L["TOOLTIP_OVERLAY_MODE"] = "Quand activé, vos soins et ceux des autres se superposent au lieu de s'empiler bout à bout. Affiche le plus grand des deux."
    L["TOOLTIP_SMART_ORDERING"] = "Réordonne les barres de soins par temps d'arrivée : soins des autres avant les vôtres, votre soin, soins des autres après, puis tous les HoTs."
    L["TOOLTIP_HEALER_COUNT"] = "Affiche le nombre de soigneurs actifs castant sur chaque cible de cadre raid."
    L["TOOLTIP_HEALER_COUNT_POS"] = "Cliquez pour parcourir : Haut-Gauche, Haut-Droite, Bas-Gauche, Bas-Droite."
    L["TOOLTIP_HEAL_TEXT_POS"] = "Cliquez pour parcourir : Gauche, Droite, Dessus, Dessous de la barre de vie."
    L["TOOLTIP_TRAJECTORY"] = "Affiche un marqueur prédisant où sera la vie basé sur le taux de dégâts entrants."
    L["TOOLTIP_RANGE_INDICATOR"] = "Réduit l'opacité des barres de soins sur les cadres raid quand la cible est hors de portée de soins."
    L["TOOLTIP_EFFECT_STYLE"] = "Statique : bordure solide. Lueur : alpha pulsant. Rotation : points orbitant. Tranches : lignes diagonales balayant."
    L["TOOLTIP_DISPEL_HIGHLIGHT"] = "Colore les cadres de raid quand une cible a un affaiblissement dissoluble correspondant à vos capacités de classe."
    L["TOOLTIP_DISPEL_STYLE"] = "Cliquez pour parcourir : Statique, Lueur, Points tournants, Tranches."
    L["TOOLTIP_DISPEL_SOUND"] = "Cliquez pour parcourir les sons disponibles."
    L["TOOLTIP_HEAL_REDUCTION"] = "Affiche une lueur rouge et un pourcentage sur les cadres raid quand une cible a un affaiblissement de réduction de soins (Frappe mortelle, etc.)."
    L["TOOLTIP_CHARMED"] = "Affiche un indicateur magenta/violet lorsqu'un coéquipier est sous contrôle mental ou charmé (hostile envers vous)."
    L["TOOLTIP_HOT_EXPIRY"] = "Affiche une bordure orange quand vos HoTs sur une cible expirent bientôt."
    L["TOOLTIP_RES_TRACKER"] = "Affiche 'RES' sur les membres de raid morts en cours de résurrection."
    L["TOOLTIP_RAID_CD_TRACKER"] = "Affiche les cooldowns externes reçus sur les cibles de cadre raid (Suppression de la douleur, Bénédiction, Innervation, etc.)."
    L["TOOLTIP_CLUSTER_DETECTION"] = "Surligne les sous-groupes où plusieurs membres sont sous un seuil de vie."
    L["TOOLTIP_AOE_ADVISOR"] = "Surligne la meilleure cible pour les soins de zone basé sur les déficits de vie des sous-groupes en raid."
    L["TOOLTIP_LOW_MANA"] = "Affiche le pourcentage de mana sur les cadres raid pour les classes soigneuses (Prêtre, Paladin, Druide, Chaman) quand sous le seuil."
    L["TOOLTIP_MANA_FORECAST"] = "Affiche le temps estimé avant OOM sur le cadre joueur pendant la consommation de mana."
    L["TOOLTIP_MANA_FORECAST_POS"] = "Cliquez pour parcourir : Dessus, Centre, Dessous, Droite de la barre de mana."
    L["TOOLTIP_OOC_REGEN"] = "Affiche le temps estimé avant mana plein quand hors combat avec mana faible."
    L["TOOLTIP_OOC_REGEN_POS"] = "Cliquez pour parcourir : Dessus, Centre, Dessous, Droite de la barre de mana."
    L["TOOLTIP_SNIPE_DETECTION"] = "Fait clignoter le cadre de raid quand votre soin est largement gaspillé par dépassement."
    L["TOOLTIP_EFFICIENCY"] = "Enregistre les soins efficaces vs dépassement par sort. Voir avec /hp stats, réinitialiser avec /hp stats reset."
    L["TOOLTIP_SOUND_DISPEL"] = "Joue un son quand un nouvel affaiblissement dissoluble est détecté. Anti-spam (max 1 par 5s)."
    L["TOOLTIP_SOUND_LOW_MANA"] = "Joue un son quand le mana d'un soigneur tombe sous le seuil de mana faible. Anti-spam (max 1 par 5s)."
    L["TOOLTIP_OVERHEAL_GRADIENT"] = "Colore la barre de dépassement par sévérité : vert (faible) à orange à rouge (élevé)."
    L["TOOLTIP_LOW_MANA_SOUND"] = "Cliquez pour parcourir les sons disponibles."
    
    ---------------------------------------------------------------------------
    -- Chat Messages (Print statements)
    ---------------------------------------------------------------------------
    L["MSG_PREFIX"] = "|cff33ccffHealPredict :|r"
    L["MSG_PREFIX_ERROR"] = "|cff33ccffHealPredict :|r |cffff4444Erreur :|r"
    L["MSG_PREFIX_DEBUG"] = "|cff33ccffHealPredict Debug|r"
    
    L["MSG_PROFILE_EXISTS"] = "Le profil '%s' existe déjà."
    L["MSG_CANNOT_DELETE_DEFAULT"] = "Impossible de supprimer le profil Défaut."
    L["MSG_PROFILE_DELETED"] = "Profil '%s' supprimé."
    L["MSG_PROFILE_COPIED"] = "Copié vers '%s'"
    L["MSG_IMPORT_SUCCESS"] = "Profil importé avec succès."
    L["MSG_IMPORT_FAILED"] = "Échec de l'import : %s"
    L["MSG_IMPORT_EMPTY"] = "Entrée vide"
    L["MSG_IMPORT_INVALID_FORMAT"] = "Format invalide (préfixe HP1: manquant)"
    L["MSG_IMPORT_UNKNOWN_VERSION"] = "Version inconnue : %s"
    L["MSG_IMPORT_DECODE_FAILED"] = "Échec du décodage Base64"
    L["MSG_IMPORT_DESERIALIZE_FAILED"] = "Échec de la désérialisation"
    L["MSG_IMPORT_INVALID_DATA"] = "Les données ne semblent pas être un profil HealPredict"
    
    L["MSG_NOT_IN_GROUP"] = "Pas dans un groupe."
    L["MSG_RAID_CHECK_TITLE"] = "Vérification des données de soins du raid :"
    L["MSG_HAS_HEAL_DATA"] = "|cff44ff44Envoi de données de soins :|r"
    L["MSG_NO_HEAL_DATA"] = "|cffff8844Pas encore de données de soins :|r"
    L["MSG_NO_HEALERS"] = "Aucun soigneur trouvé dans le groupe."
    L["MSG_NO_DATA_NOTE"] = "|cff888888Note : 'Pas de données' signifie qu'aucun soin n'a encore été détecté.|r"
    
    L["MSG_NO_HEALING_DATA"] = "Aucune donnée de soins enregistrée. Activez 'Suivre l'efficacité' et soignez !"
    L["MSG_EFFICIENCY_REPORT"] = "Rapport d'efficacité de soins (%dm session)"
    L["MSG_EFFICIENCY_RESET"] = "Données d'efficacité réinitialisées."
    L["MSG_SPELL_STATS"] = "  |cffffffff%s|r : %dx | %d eff | %d dp | |cff%s%d%%|r"
    
    L["MSG_SNIPE_REPORT_TITLE"] = "Rapport de snipe :"
    L["MSG_NO_SNIPES"] = "Aucun snipe détecté cette session."
    L["MSG_SNIPE_TOTAL"] = "  Snipes totaux : |cffff4444%d|r"
    L["MSG_SNIPE_WASTED"] = "  Soins gaspillés totaux : |cffff4444%d|r"
    L["MSG_SNIPE_RECENT"] = "  Snipes récents :"
    L["MSG_SNIPE_ENTRY"] = "    %s - %d/%d en dépassement (%.0f%%)"
    
    L["MSG_RENDER_ERROR"] = "Erreur de rendu : %s"
    
    L["MSG_NAMEPLATE_DEBUG_TITLE"] = "|cff33ccffHealPredict Debug Plaques|r"
    L["MSG_NAMEPLATE_SETTINGS"] = "  showNameplates=%s"
    L["MSG_NAMEPLATE_ENTRY"] = "  [%s] unité=%s amical=%s uf=%s bv=%s tracké=%s"
    L["MSG_NAMEPLATE_NONE"] = "  Aucune plaque visible actuellement."
    L["MSG_NAMEPLATE_TOTAL"] = "  Total : %d plaques, %d trackées par HP"
    
    ---------------------------------------------------------------------------
    -- Debug Messages
    ---------------------------------------------------------------------------
    L["DEBUG_TARGET_HEADER"] = "%s (%s)"
    L["DEBUG_GUID"] = "  GUID : %s"
    L["DEBUG_HEALTH"] = "  Vie : %d / %d (%.0f%%)"
    L["DEBUG_ENGINE"] = "  Engine : myGUID=%s  inUnitMap=%s  myUnit=%s"
    L["DEBUG_AURA_HEADER"] = "  |cffaaaaff[Auras liées aux soins]|r"
    L["DEBUG_AURA_ENTRY"] = "    [%s] id=%s rang=%s tick=%s sort=%s src=%s"
    L["DEBUG_HEAL_DATA"] = "  Engine : perso=%.0f  autres=%.0f  mod=%.2f"
    L["DEBUG_TICK_ENTRY"] = "  |cff44ff44TICK|r [%s] de %s : qte=%.0f piles=%d tRest=%d fin=%.1f"
    L["DEBUG_CAST_ENTRY"] = "  |cffffff44SORT|r [%s id=%d] de %s : qte=%.0f fin=%.1f"
    L["DEBUG_NO_HEALS"] = "  Aucun enregistrement de soins actif sur cette cible."
    L["DEBUG_SHIELD"] = "  |cff8888ffAbsorption bouclier :|r %d"
    L["DEBUG_SETTINGS"] = "  testMode=%s  showOthers=%s  filterHoT=%s"
    L["DEBUG_BAR_HEADER"] = "  |cffffaa44[État barre de vie]|r"
    L["DEBUG_BAR_ENTRY"] = "    [%s] type=%s  barre : %d/%d (%.0f%%)  l=%.0f  vis=%s"
    L["DEBUG_BAR_API"] = "    API : UnitHealth=%d  UnitHealthMax=%d"
    
    ---------------------------------------------------------------------------
    -- Shield Abbreviations (keep short!)
    ---------------------------------------------------------------------------
    L["SHIELD_PWS"] = "MD:M"
    L["SHIELD_ICEBARRIER"] = "BarGla"
    L["SHIELD_MANASHIELD"] = "BouM"
    L["SHIELD_SACRIFICE"] = "Sacr"
    L["SHIELD_FIREWARD"] = "GarFeu"
    L["SHIELD_FROSTWARD"] = "GarGla"
    L["SHIELD_SHADOWWARD"] = "GarOmb"
    
    ---------------------------------------------------------------------------
    -- Minimap Button Tooltip
    ---------------------------------------------------------------------------
    L["MINIMAP_TITLE"] = "|cff33ccffHealPredict|r"
    L["MINIMAP_LEFTCLICK"] = "Clic gauche : Options"
    L["MINIMAP_SHIFT_CLICK"] = "Maj-clic gauche : Changelog"
    L["MINIMAP_RIGHTCLICK"] = "Clic droit : Mode test"
    L["MINIMAP_DRAG"] = "Glisser : Déplacer"
    
    ---------------------------------------------------------------------------
    -- Test Mode
    ---------------------------------------------------------------------------
    L["TEST_FRAME_LABEL"] = "HP Test"
    
    ---------------------------------------------------------------------------
    -- Text Overlays / Status
    ---------------------------------------------------------------------------
    L["TEXT_RES"] = "|cff44ff44RES|r"
    L["TEXT_OOM"] = "OOM : %ds"
    L["TEXT_FULL_MANA_SEC"] = "Plein : %ds"
    L["TEXT_FULL_MANA_MIN"] = "Plein : %dm"
    L["TEXT_DEFICIT"] = "|cffff4444-%d|r"
    L["TEXT_HEAL_REDUCTION"] = "-%d%%"
    
    ---------------------------------------------------------------------------
    -- External Cooldown Abbreviations
    ---------------------------------------------------------------------------
    L["CD_PAIN_SUPPRESSION"] = "SUPP-DOUL"
    L["CD_POWER_INFUSION"] = "INF-PUI"
    L["CD_BLESSING_PROTECTION"] = "BEN-PROT"
    L["CD_BLESSING_SACRIFICE"] = "BEN-SACR"
    L["CD_INNERVATE"] = "INNERV"
    L["CD_MANA_TIDE"] = "FLUT-MANA"
    L["CD_HEROISM"] = "HERO"
    L["CD_BLOODLUST"] = "FUR-SANG"
    
    ---------------------------------------------------------------------------
    -- Defensive Cooldown Abbreviations
    ---------------------------------------------------------------------------
    L["DEF_DIVINE_SHIELD"] = "BOU-DIV"
    L["DEF_ICE_BLOCK"] = "BLOC-GLA"
    L["DEF_DIVINE_INTERVENTION"] = "INT-DIV"
    L["DEF_DIVINE_PROTECTION"] = "PROT-DIV"
    L["DEF_SHIELD_WALL"] = "MUR-BOU"
    L["DEF_EVASION"] = "EVAS"
    L["DEF_BARKSKIN"] = "PEAU-ECOR"
    
    ---------------------------------------------------------------------------
    -- Color Tooltip Explanations
    ---------------------------------------------------------------------------
    L["COLOR_TOOLTIP_MY_RAID"] = "Vos prédictions de soins sur les cadres raid et compacts."
    L["COLOR_TOOLTIP_OTHER_RAID"] = "Les prédictions de soins des autres sur les cadres raid et compacts."
    L["COLOR_TOOLTIP_MY_UNIT"] = "Vos prédictions de soins sur les cadres joueur, cible, groupe et focus."
    L["COLOR_TOOLTIP_OTHER_UNIT"] = "Les prédictions de soins des autres sur les cadres joueur, cible, groupe et focus."
    L["COLOR_TOOLTIP_HOT_EXPIRY"] = "Couleur de bordure quand vos HoTs expirent bientôt sur une cible."
    L["COLOR_TOOLTIP_DISPEL_MAGIC"] = "Couleur de surcouche pour les affaiblissements de Magie."
    L["COLOR_TOOLTIP_DISPEL_CURSE"] = "Couleur de surcouche pour les affaiblissements de Malédiction."
    L["COLOR_TOOLTIP_DISPEL_DISEASE"] = "Couleur de surcouche pour les affaiblissements de Maladie."
    L["COLOR_TOOLTIP_DISPEL_POISON"] = "Couleur de surcouche pour les affaiblissements de Poison."
    L["COLOR_TOOLTIP_CLUSTER"] = "Couleur de bordure pour les membres de cluster détectés."
    L["COLOR_TOOLTIP_AOE"] = "Couleur de bordure pour la surbrillance du conseiller AoE."

    ---------------------------------------------------------------------------
    -- Instance Tracking
    ---------------------------------------------------------------------------
    L["INSTANCE_TRACKING"] = "Suivi d'Instance"
    L["INSTANCE_TRACKING_STARTED"] = "Suivi d'instance démarré"
    L["INSTANCE_RUN_ENDED"] = "Instance terminée"
    L["INSTANCE_PROGRESS"] = "Progression d'Instance"
    L["INSTANCE_HPS_ABOVE_AVG"] = "HPS au-dessus de la moyenne d'instance"
end
