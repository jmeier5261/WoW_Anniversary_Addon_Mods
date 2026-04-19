-- HealPredict - Spanish (esES) Localization
-- Traducción española
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn

local _, HP = ...

if not HP.LocaleData then HP.LocaleData = {} end

HP.LocaleData["esES"] = function(L)
    ---------------------------------------------------------------------------
    -- Core Addon Info
    ---------------------------------------------------------------------------
    L["ADDON_NAME"] = "HealPredict"
    L["VERSION_AUTHOR"] = "v%s  por DarkpoisOn"
    
    ---------------------------------------------------------------------------
    -- Profile Section
    ---------------------------------------------------------------------------
    L["PROFILE_LABEL"] = "Perfil:"
    L["PROFILE_NEW"] = "Nuevo"
    L["PROFILE_COPY"] = "Copiar"
    L["PROFILE_DELETE"] = "Elim"
    L["PROFILE_EXPORT"] = "Exportar"
    L["PROFILE_IMPORT"] = "Importar"
    L["PROFILE_DEFAULT"] = "Predeterminado"
    
    ---------------------------------------------------------------------------
    -- Dialog / Popup Texts
    ---------------------------------------------------------------------------
    L["DIALOG_NEW_PROFILE"] = "Introduce el nombre del nuevo perfil:"
    L["DIALOG_CREATE"] = "Crear"
    L["DIALOG_CANCEL"] = "Cancelar"
    L["DIALOG_COPY_PROFILE"] = "Copiar el perfil actual a:"
    L["DIALOG_DELETE_CONFIRM"] = "¿Eliminar el perfil '%s'?\nEste personaje cambiará al perfil Predeterminado."
    L["DIALOG_DELETE"] = "Eliminar"
    L["DIALOG_EXPORT_TITLE"] = "Copia esta cadena para compartir tu perfil:"
    L["DIALOG_DONE"] = "Hecho"
    L["DIALOG_IMPORT_TITLE"] = "Pega una cadena de perfil de HealPredict:"
    L["DIALOG_IMPORT_BUTTON"] = "Importar"
    
    ---------------------------------------------------------------------------
    -- Tab Names
    ---------------------------------------------------------------------------
    L["TAB_GENERAL"] = "General"
    L["TAB_DISPLAY"] = "Visualización"
    L["TAB_COLORS"] = "Colores"
    
    ---------------------------------------------------------------------------
    -- Section Headers (General Tab)
    ---------------------------------------------------------------------------
    L["SECTION_HEALING_FILTERS"] = "FILTROS DE SANACIÓN"
    L["SECTION_THRESHOLDS"] = "UMBRALES"
    L["SECTION_OVERFLOW_LIMITS"] = "LÍMITES DE EXCESO"
    L["SECTION_PERFORMANCE"] = "RENDIMIENTO"
    L["SECTION_PROFILE_AUTO_SWITCH"] = "CAMBIO AUTO DE PERFIL"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Healing Filters)
    ---------------------------------------------------------------------------
    L["SHOW_HEALING_FROM_OTHERS"] = "Mostrar sanación de otros jugadores"
    L["DIRECT_HEALS"] = "Sanaciones directas"
    L["HOT_HEALS"] = "HoT (sanación en el tiempo)"
    L["CHANNELED_HEALS"] = "Sanaciones canalizadas"
    L["BOMB_HEALS"] = "Sanaciones-bomba (Rezo de alivio, etc.)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Thresholds)
    ---------------------------------------------------------------------------
    L["LIMIT_PREDICTION_WINDOW"] = "Limitar ventana de predicción"
    L["DIM_NON_IMMINENT_HEALS"] = "Atenuar sanaciones no inminentes"
    L["RECOLOR_OVERHEAL"] = "Recolorear barras si exceso > (%)"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (General Tab)
    ---------------------------------------------------------------------------
    L["SLIDER_DIRECT_TF"] = "Directa: %.1fs"
    L["SLIDER_CHANNEL_TF"] = "Canalizada: %.1fs"
    L["SLIDER_HOT_TF"] = "HoT: %.1fs"
    L["SLIDER_POLL_RATE"] = "Tasa de actualización: %d FPS"
    L["SLIDER_PANEL_SCALE"] = "Escala del panel: %d%%"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Overflow)
    ---------------------------------------------------------------------------
    L["CAP_RAID_OVERFLOW"] = "Limitar exceso de raid (%)"
    L["CAP_UNIT_OVERFLOW"] = "Limitar exceso de unidad (%)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Performance)
    ---------------------------------------------------------------------------
    L["FAST_RAID_UPDATES"] = "Actualizaciones rápidas de marcos de raid"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (General Tab - Auto-Switch)
    ---------------------------------------------------------------------------
    L["AUTO_SWITCH_PROFILES"] = "Cambiar perfil automáticamente según tamaño de grupo"
    L["AUTO_SWITCH_SOLO"] = "Solo:"
    L["AUTO_SWITCH_PARTY"] = "Grupo:"
    L["AUTO_SWITCH_RAID"] = "Raid:"
    
    ---------------------------------------------------------------------------
    -- Section Headers (Display Tab)
    ---------------------------------------------------------------------------
    L["SECTION_FRAME_VISIBILITY"] = "VISIBILIDAD DE MARCOS"
    L["SECTION_BARS_OVERLAYS"] = "BARRAS Y CAPAS"
    L["SECTION_SHIELDS_ABSORBS"] = "ESCUDOS Y ABSORCIONES"
    L["SECTION_DEFENSIVES"] = "DEFENSIVOS"
    L["SECTION_TEXT_OVERLAYS"] = "CAPAS DE TEXTO"
    L["SECTION_RAID_FRAME_INDICATORS"] = "INDICADORES DE MARCOS DE RAID"
    L["SECTION_INDICATORS"] = "INDICADORES"
    L["SECTION_PLAYER_MANA"] = "MANÁ DEL JUGADOR"
    L["SECTION_ALERTS"] = "ALERTAS"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Frame Visibility)
    ---------------------------------------------------------------------------
    L["SHOW_ON_PLAYER"] = "Mostrar en marco de Jugador"
    L["SHOW_ON_TARGET"] = "Mostrar en marco de Objetivo"
    L["SHOW_ON_TOT"] = "Mostrar en marco de Objetivo del objetivo"
    L["SHOW_ON_FOCUS"] = "Mostrar en marco de Foco"
    L["SHOW_ON_PARTY"] = "Mostrar en marcos de Grupo"
    L["SHOW_ON_PET"] = "Mostrar en marcos de Mascota"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Bars & Overlays)
    ---------------------------------------------------------------------------
    L["OVERLAY_MODE"] = "Modo superposición (propias + ajenas)"
    L["SMART_HEAL_ORDERING"] = "Orden inteligente de sanaciones (tiempo de llegada)"
    L["USE_RAID_TEXTURE"] = "Usar textura de raid en barras de unidad"
    L["SHOW_MANA_COST"] = "Mostrar coste de maná en barra de maná"
    L["OVERHEAL_BAR"] = "Barra de exceso de sanación"
    L["OVERHEAL_GRADIENT"] = "Degradado de severidad de exceso"
    L["SHOW_NAMEPLATES"] = "Mostrar barras en placas de nombre amistosas"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Display Tab)
    ---------------------------------------------------------------------------
    L["SLIDER_BAR_OPACITY"] = "Opacidad de barras: %d%%"
    L["LBL_BAR_OPACITY"] = "Controla la opacidad de las barras de predicción de sanación"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Shields & Absorbs)
    ---------------------------------------------------------------------------
    L["SHIELD_GLOW"] = "Brillo de escudo en barras de salud"
    L["SHIELD_TEXT"] = "Mostrar nombre del hechizo de escudo"
    L["ABSORB_BAR"] = "Barra de absorción en barras de salud"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Display Tab - Shield Offset)
    ---------------------------------------------------------------------------
    L["SLIDER_SHIELD_X"] = "X: %d"
    L["SLIDER_SHIELD_Y"] = "Y: %d"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Defensives)
    ---------------------------------------------------------------------------
    L["DEFENSIVE_STATUS"] = "Texto de estado defensivo en marcos de raid"
    L["SHOW_INVULNS"] = "Invulnerabilidades (Escudo divino, Bloque de hielo)"
    L["SHOW_STRONG_MIT"] = "Mitigación fuerte (Bendición de protección, Muro)"
    L["SHOW_WEAK_MIT"] = "Mitigación débil (Evasión, Piel de corteza)"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Text Overlays)
    ---------------------------------------------------------------------------
    L["PREDICTIVE_DEFICIT"] = "Déficit de salud predictivo en marcos de raid"
    L["INCOMING_HEAL_TEXT"] = "Texto de sanación entrante en marcos de unidad"
    
    ---------------------------------------------------------------------------
    -- Position Labels
    ---------------------------------------------------------------------------
    L["POSITION"] = "Posición:"
    L["POS_LEFT"] = "Izquierda"
    L["POS_RIGHT"] = "Derecha"
    L["POS_ABOVE"] = "Arriba"
    L["POS_BELOW"] = "Abajo"
    L["POS_CENTER"] = "Centro"
    L["POS_TOP_LEFT"] = "Arriba-Izquierda"
    L["POS_TOP_RIGHT"] = "Arriba-Derecha"
    L["POS_BOTTOM_LEFT"] = "Abajo-Izquierda"
    L["POS_BOTTOM_RIGHT"] = "Abajo-Derecha"
    
    L["HEALTXT_POS_PREFIX"] = "Posición: %s"
    L["HEALER_POS_PREFIX"] = "Posición: %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Raid Frame Indicators)
    ---------------------------------------------------------------------------
    L["HEALER_COUNT"] = "Mostrar número de sanadores por objetivo"
    L["PREDICTIVE_TRAJECTORY"] = "Trayectoria de salud predictiva"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Trajectory)
    ---------------------------------------------------------------------------
    L["SLIDER_TRAJECTORY_WINDOW"] = "Ventana: %ds"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Range)
    ---------------------------------------------------------------------------
    L["DIM_OUT_OF_RANGE"] = "Atenuar objetivos fuera de alcance"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Range)
    ---------------------------------------------------------------------------
    L["SLIDER_DIMMED_OPACITY"] = "Opacidad atenuada: %d%%"
    
    ---------------------------------------------------------------------------
    -- Effect Style Labels
    ---------------------------------------------------------------------------
    L["EFFECT_STYLE"] = "Estilo:"
    L["STYLE_STATIC"] = "Estático"
    L["STYLE_GLOW"] = "Brillo"
    L["STYLE_SPINNING"] = "Giratorio"
    L["STYLE_SLASHES"] = "Barridos"
    
    L["STYLE_PREFIX"] = "Estilo: %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Indicators)
    ---------------------------------------------------------------------------
    L["DISPEL_HIGHLIGHT"] = "Resaltado de disipación en marcos de raid"
    L["HEAL_REDUCTION_GLOW"] = "Indicador de reducción de sanación"
    L["SHOW_REDUCTION_TEXT"] = "Mostrar porcentaje de reducción"
    L["CHARMED_INDICATOR"] = "Indicador de Encantado/Poseído"
    L["HOT_EXPIRY_WARNING"] = "Advertencia de expiración de HoT"
    L["INCOMING_RES"] = "Seguimiento de resurrección entrante"
    L["RAID_COOLDOWN_TRACKER"] = "Seguimiento de cooldowns de raid"
    L["CLUSTER_DETECTION"] = "Detección de grupos"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Indicators)
    ---------------------------------------------------------------------------
    L["SLIDER_INDICATOR_BORDER"] = "Borde de indicador: %dpx"
    L["SLIDER_HOT_EXPIRY_THRESHOLD"] = "Umbral: %ds"
    L["SLIDER_CLUSTER_THRESHOLD"] = "Umbral de PV: %d%%"
    L["SLIDER_CLUSTER_MIN"] = "Min. miembros: %d"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - AoE & Mana)
    ---------------------------------------------------------------------------
    L["AOE_HEAL_ADVISOR"] = "Asesor de objetivo de sanación AoE"
    L["LOW_MANA_WARNING"] = "Advertencia de maná bajo en marcos de raid (sanadores)"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Low Mana)
    ---------------------------------------------------------------------------
    L["SLIDER_LOW_MANA_THRESHOLD"] = "Umbral de maná: %d%%"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Player Mana)
    ---------------------------------------------------------------------------
    L["MANA_FORECAST"] = "Pronóstico de sostenibilidad de maná"
    L["OOC_REGEN_TIMER"] = "Temporizador de regeneración fuera de combate"
    
    ---------------------------------------------------------------------------
    -- Button Labels (Mana Position)
    ---------------------------------------------------------------------------
    L["FORECAST_POS_PREFIX"] = "Posición: %s"
    L["OOC_POS_PREFIX"] = "Posición: %s"
    
    ---------------------------------------------------------------------------
    -- Checkbox Labels (Display Tab - Alerts)
    ---------------------------------------------------------------------------
    L["HEAL_SNIPE_DETECTION"] = "Detección de 'snipe' de sanación"
    L["TRACK_HEALING_EFFICIENCY"] = "Seguir eficiencia de sanación (/hp stats)"
    L["SOUND_DISPEL"] = "Alerta sonora: disipación necesaria"
    L["SOUND_LOW_MANA"] = "Alerta sonora: sanador con maná bajo"
    
    ---------------------------------------------------------------------------
    -- Slider Labels (Snipe)
    ---------------------------------------------------------------------------
    L["SLIDER_SNIPE_THRESHOLD"] = "Umbral: %d%%"
    
    ---------------------------------------------------------------------------
    -- Sound Selection Labels
    ---------------------------------------------------------------------------
    L["SOUND_RAID_WARNING"] = "Aviso de banda"
    L["SOUND_READY_CHECK"] = "Listos"
    L["SOUND_ALARM_CLOCK"] = "Alarma"
    L["SOUND_FLAG_CAPTURED"] = "Bandera capturada"
    L["SOUND_NONE"] = "Ninguno"
    
    ---------------------------------------------------------------------------
    -- Section Headers (Colors Tab)
    ---------------------------------------------------------------------------
    L["SECTION_BAR_COLORS"] = "COLORES DE BARRAS"
    L["SECTION_FEATURE_COLORS"] = "COLORES DE FUNCIONALIDADES"
    L["SECTION_MISC"] = "VARIOS"
    
    ---------------------------------------------------------------------------
    -- Color Row Labels
    ---------------------------------------------------------------------------
    L["COLOR_MY_RAID_HEALS"] = "Mis sanaciones de raid:"
    L["COLOR_OTHER_RAID_HEALS"] = "Otras sanaciones de raid:"
    L["COLOR_MY_UNIT_HEALS"] = "Mis sanaciones de unidad:"
    L["COLOR_OTHER_UNIT_HEALS"] = "Otras sanaciones de unidad:"
    
    L["COLOR_ABSORB_BAR"] = "Barra de absorción:"
    L["COLOR_OVERHEAL_BAR"] = "Barra de exceso:"
    L["COLOR_MANA_COST"] = "Coste de maná:"
    L["COLOR_HOT_EXPIRY"] = "Expiración HoT:"
    L["COLOR_DISPEL_MAGIC"] = "Disipar Magia:"
    L["COLOR_DISPEL_CURSE"] = "Disipar Maldición:"
    L["COLOR_DISPEL_DISEASE"] = "Disipar Enfermedad:"
    L["COLOR_DISPEL_POISON"] = "Disipar Veneno:"
    L["COLOR_CLUSTER_BORDER"] = "Borde de grupo:"
    L["COLOR_HEAL_REDUCTION"] = "Reducción de sanación:"
    L["COLOR_CHARMED"] = "Encantado/Poseído:"
    L["COLOR_AOE_ADVISOR"] = "Asesor AoE:"
    
    ---------------------------------------------------------------------------
    -- Color Swatch Labels
    ---------------------------------------------------------------------------
    L["SWATCH_DIRECT"] = "Directa"
    L["SWATCH_HOT"] = "HoT"
    L["SWATCH_DIRECT_OH"] = "Directa (EX)"
    L["SWATCH_HOT_OH"] = "HoT (EX)"
    
    ---------------------------------------------------------------------------
    -- Button Labels (Colors Tab)
    ---------------------------------------------------------------------------
    L["FLIP_MY_OTHER"] = "Invertir Propio/Otros"
    L["SHOW_MINIMAP"] = "Mostrar botón en minimapa"
    
    ---------------------------------------------------------------------------
    -- Bottom Buttons
    ---------------------------------------------------------------------------
    L["BUTTON_DEFAULTS"] = "Predeterminados"
    L["BUTTON_TEST_MODE"] = "Modo Prueba"
    
    ---------------------------------------------------------------------------
    -- Tooltips (General Tab)
    ---------------------------------------------------------------------------
    L["TOOLTIP_SHOW_OTHERS"] = "Muestra las predicciones de sanación de otros sanadores en tu banda o grupo."
    L["TOOLTIP_TIME_LIMIT"] = "Muestra solo sanaciones que llegarán dentro del marco de tiempo especificado. Útil para filtrar HoTs largos que saturarían la pantalla."
    L["TOOLTIP_DIM_NON_IMMINENT"] = "Reduce la opacidad de las barras HoT/canalizadas para distinguirlas de las sanaciones directas que llegan pronto."
    L["TOOLTIP_FAST_UPDATES"] = "Consulta los marcos de raid a tasa fija para actualizaciones más suaves. Usa más CPU. Sin esto, las barras solo se actualizan en eventos de salud/sanación."
    L["TOOLTIP_AUTO_SWITCH"] = "Cambia automáticamente de perfil cuando entras/sales de un grupo o banda."
    L["TOOLTIP_AUTO_SWITCH_BTN"] = "Clic para recorrer los perfiles disponibles."
    
    ---------------------------------------------------------------------------
    -- Tooltips (Display Tab)
    ---------------------------------------------------------------------------
    L["TOOLTIP_OVERLAY_MODE"] = "Cuando está activado, tus sanaciones y las de otros se superponen en lugar de apilarse. Muestra la mayor de las dos."
    L["TOOLTIP_SMART_ORDERING"] = "Reordena las barras de sanación por tiempo de llegada: sanaciones de otros antes que las tuyas, tu sanación, otras después, luego todos los HoTs."
    L["TOOLTIP_HEALER_COUNT"] = "Muestra el número de sanadores activos lanzando sobre cada objetivo de marco de banda."
    L["TOOLTIP_HEALER_COUNT_POS"] = "Clic para recorrer: Arriba-Izquierda, Arriba-Derecha, Abajo-Izquierda, Abajo-Derecha."
    L["TOOLTIP_HEAL_TEXT_POS"] = "Clic para recorrer: Izquierda, Derecha, Arriba, Abajo de la barra de salud."
    L["TOOLTIP_TRAJECTORY"] = "Muestra un marcador que predice dónde estará la salud basado en la tasa de daño entrante."
    L["TOOLTIP_RANGE_INDICATOR"] = "Reduce la opacidad de las barras de sanación en marcos de raid cuando el objetivo está fuera de alcance de sanación."
    L["TOOLTIP_EFFECT_STYLE"] = "Estático: borde sólido. Brillo: alpha pulsante. Giratorio: puntos orbitando. Barridos: líneas diagonales barrido."
    L["TOOLTIP_DISPEL_HIGHLIGHT"] = "Colorea los marcos de raid cuando un objetivo tiene un perjuicio disipable que coincide con tus habilidades de clase."
    L["TOOLTIP_DISPEL_STYLE"] = "Clic para recorrer: Estático, Brillo, Puntos giratorios, Barridos."
    L["TOOLTIP_DISPEL_SOUND"] = "Clic para recorrer los sonidos disponibles."
    L["TOOLTIP_HEAL_REDUCTION"] = "Muestra un brillo rojo y porcentaje en marcos de raid cuando un objetivo tiene perjuicio de reducción de sanación (Golpe mortal, etc.)."
    L["TOOLTIP_CHARMED"] = "Muestra un indicador magenta/púrpura cuando un compañero está bajo control mental o encantado (hostil hacia ti)."
    L["TOOLTIP_HOT_EXPIRY"] = "Muestra un borde naranja cuando tus HoTs en un objetivo están a punto de expirar."
    L["TOOLTIP_RES_TRACKER"] = "Muestra 'RES' en miembros de banda muertos siendo resucitados."
    L["TOOLTIP_RAID_CD_TRACKER"] = "Muestra cooldowns externos recibidos en objetivos de marco de banda (Supresión de dolor, Bendición, Enervar, etc.)."
    L["TOOLTIP_CLUSTER_DETECTION"] = "Resalta subgrupos donde varios miembros están bajo un umbral de salud."
    L["TOOLTIP_AOE_ADVISOR"] = "Resalta el mejor objetivo para sanaciones AoE basado en déficits de salud de subgrupos en bandas."
    L["TOOLTIP_LOW_MANA"] = "Muestra porcentaje de maná en marcos de banda para clases sanadoras (Sacerdote, Paladín, Druida, Chamán) cuando están bajo el umbral."
    L["TOOLTIP_MANA_FORECAST"] = "Muestra tiempo estimado hasta OOM en el marco de jugador mientras consume maná."
    L["TOOLTIP_MANA_FORECAST_POS"] = "Clic para recorrer: Arriba, Centro, Abajo, Derecha de la barra de maná."
    L["TOOLTIP_OOC_REGEN"] = "Muestra tiempo estimado hasta maná lleno cuando estás fuera de combate con maná bajo."
    L["TOOLTIP_OOC_REGEN_POS"] = "Clic para recorrer: Arriba, Centro, Abajo, Derecha de la barra de maná."
    L["TOOLTIP_SNIPE_DETECTION"] = "Ilumina el marco de raid cuando tu sanación se desperdicia en gran medida por exceso."
    L["TOOLTIP_EFFICIENCY"] = "Registra sanación efectiva vs exceso por hechizo. Ver con /hp stats, reiniciar con /hp stats reset."
    L["TOOLTIP_SOUND_DISPEL"] = "Reproduce un sonido cuando se detecta un nuevo perjuicio disipable. Anti-spam (máx 1 cada 5s)."
    L["TOOLTIP_SOUND_LOW_MANA"] = "Reproduce un sonido cuando el maná de un sanador cae bajo el umbral de maná bajo. Anti-spam (máx 1 cada 5s)."
    L["TOOLTIP_OVERHEAL_GRADIENT"] = "Colorea la barra de exceso por severidad: verde (bajo) a naranja a rojo (alto)."
    L["TOOLTIP_LOW_MANA_SOUND"] = "Clic para recorrer los sonidos disponibles."
    
    ---------------------------------------------------------------------------
    -- Chat Messages (Print statements)
    ---------------------------------------------------------------------------
    L["MSG_PREFIX"] = "|cff33ccffHealPredict:|r"
    L["MSG_PREFIX_ERROR"] = "|cff33ccffHealPredict:|r |cffff4444Error:|r"
    L["MSG_PREFIX_DEBUG"] = "|cff33ccffHealPredict Debug|r"
    
    L["MSG_PROFILE_EXISTS"] = "El perfil '%s' ya existe."
    L["MSG_CANNOT_DELETE_DEFAULT"] = "No se puede eliminar el perfil Predeterminado."
    L["MSG_PROFILE_DELETED"] = "Perfil '%s' eliminado."
    L["MSG_PROFILE_COPIED"] = "Copiado a '%s'"
    L["MSG_IMPORT_SUCCESS"] = "Perfil importado exitosamente."
    L["MSG_IMPORT_FAILED"] = "Fallo de importación: %s"
    L["MSG_IMPORT_EMPTY"] = "Entrada vacía"
    L["MSG_IMPORT_INVALID_FORMAT"] = "Formato inválido (falta prefijo HP1:)"
    L["MSG_IMPORT_UNKNOWN_VERSION"] = "Versión desconocida: %s"
    L["MSG_IMPORT_DECODE_FAILED"] = "Fallo de decodificación Base64"
    L["MSG_IMPORT_DESERIALIZE_FAILED"] = "Fallo de deserialización"
    L["MSG_IMPORT_INVALID_DATA"] = "Los datos no parecen ser un perfil de HealPredict"
    
    L["MSG_NOT_IN_GROUP"] = "No estás en un grupo."
    L["MSG_RAID_CHECK_TITLE"] = "Verificación de datos de sanación de banda:"
    L["MSG_HAS_HEAL_DATA"] = "|cff44ff44Enviando datos de sanación:|r"
    L["MSG_NO_HEAL_DATA"] = "|cffff8844Sin datos de sanación (aún):|r"
    L["MSG_NO_HEALERS"] = "No se encontraron sanadores en el grupo."
    L["MSG_NO_DATA_NOTE"] = "|cff888888Nota: 'Sin datos' significa que aún no se han detectado sanaciones.|r"
    
    L["MSG_NO_HEALING_DATA"] = "No se han registrado datos de sanación. ¡Activa 'Seguir eficiencia' y sana!"
    L["MSG_EFFICIENCY_REPORT"] = "Informe de eficiencia de sanación (%dm sesión)"
    L["MSG_EFFICIENCY_RESET"] = "Datos de eficiencia reiniciados."
    L["MSG_SPELL_STATS"] = "  |cffffffff%s|r: %dx | %d efec | %d exc | |cff%s%d%%|r"
    
    L["MSG_SNIPE_REPORT_TITLE"] = "Informe de 'snipes':"
    L["MSG_NO_SNIPES"] = "No se detectaron 'snipes' esta sesión."
    L["MSG_SNIPE_TOTAL"] = "  'Snipes' totales: |cffff4444%d|r"
    L["MSG_SNIPE_WASTED"] = "  Sanación desperdiciada total: |cffff4444%d|r"
    L["MSG_SNIPE_RECENT"] = "  'Snipes' recientes:"
    L["MSG_SNIPE_ENTRY"] = "    %s - %d/%d en exceso (%.0f%%)"
    
    L["MSG_RENDER_ERROR"] = "Error de renderizado: %s"
    
    L["MSG_NAMEPLATE_DEBUG_TITLE"] = "|cff33ccffHealPredict Debug Placas|r"
    L["MSG_NAMEPLATE_SETTINGS"] = "  showNameplates=%s"
    L["MSG_NAMEPLATE_ENTRY"] = "  [%s] unidad=%s amistoso=%s uf=%s bv=%s trackeado=%s"
    L["MSG_NAMEPLATE_NONE"] = "  No hay placas visibles actualmente."
    L["MSG_NAMEPLATE_TOTAL"] = "  Total: %d placas, %d trackeadas por HP"
    
    ---------------------------------------------------------------------------
    -- Debug Messages
    ---------------------------------------------------------------------------
    L["DEBUG_TARGET_HEADER"] = "%s (%s)"
    L["DEBUG_GUID"] = "  GUID: %s"
    L["DEBUG_HEALTH"] = "  Salud: %d / %d (%.0f%%)"
    L["DEBUG_ENGINE"] = "  Engine: myGUID=%s  inUnitMap=%s  myUnit=%s"
    L["DEBUG_AURA_HEADER"] = "  |cffaaaaff[Auras relacionadas con sanación]|r"
    L["DEBUG_AURA_ENTRY"] = "    [%s] id=%s rango=%s tick=%s hechizo=%s fuente=%s"
    L["DEBUG_HEAL_DATA"] = "  Engine: propio=%.0f  otros=%.0f  mod=%.2f"
    L["DEBUG_TICK_ENTRY"] = "  |cff44ff44TICK|r [%s] de %s: cant=%.0f acum=%d tRest=%d fin=%.1f"
    L["DEBUG_CAST_ENTRY"] = "  |cffffff44HECHIZO|r [%s id=%d] de %s: cant=%.0f fin=%.1f"
    L["DEBUG_NO_HEALS"] = "  No hay registros de sanación activos en este objetivo."
    L["DEBUG_SHIELD"] = "  |cff8888ffAbsorción de escudo:|r %d"
    L["DEBUG_SETTINGS"] = "  testMode=%s  showOthers=%s  filterHoT=%s"
    L["DEBUG_BAR_HEADER"] = "  |cffffaa44[Estado de barra de salud]|r"
    L["DEBUG_BAR_ENTRY"] = "    [%s] tipo=%s  barra: %d/%d (%.0f%%)  a=%.0f  vis=%s"
    L["DEBUG_BAR_API"] = "    API: UnitHealth=%d  UnitHealthMax=%d"
    
    ---------------------------------------------------------------------------
    -- Shield Abbreviations (keep short!)
    ---------------------------------------------------------------------------
    L["SHIELD_PWS"] = "PD:M"
    L["SHIELD_ICEBARRIER"] = "BarrHiel"
    L["SHIELD_MANASHIELD"] = "EscMan"
    L["SHIELD_SACRIFICE"] = "Sacr"
    L["SHIELD_FIREWARD"] = "GuardFue"
    L["SHIELD_FROSTWARD"] = "GuardEsc"
    L["SHIELD_SHADOWWARD"] = "GuardSom"
    
    ---------------------------------------------------------------------------
    -- Minimap Button Tooltip
    ---------------------------------------------------------------------------
    L["MINIMAP_TITLE"] = "|cff33ccffHealPredict|r"
    L["MINIMAP_LEFTCLICK"] = "Clic izquierdo: Opciones"
    L["MINIMAP_SHIFT_CLICK"] = "Mayús-clic izquierdo: Changelog"
    L["MINIMAP_RIGHTCLICK"] = "Clic derecho: Modo prueba"
    L["MINIMAP_DRAG"] = "Arrastrar: Mover"
    
    ---------------------------------------------------------------------------
    -- Test Mode
    ---------------------------------------------------------------------------
    L["TEST_FRAME_LABEL"] = "HP Prueba"
    
    ---------------------------------------------------------------------------
    -- Text Overlays / Status
    ---------------------------------------------------------------------------
    L["TEXT_RES"] = "|cff44ff44RES|r"
    L["TEXT_OOM"] = "OOM: %ds"
    L["TEXT_FULL_MANA_SEC"] = "Lleno: %ds"
    L["TEXT_FULL_MANA_MIN"] = "Lleno: %dm"
    L["TEXT_DEFICIT"] = "|cffff4444-%d|r"
    L["TEXT_HEAL_REDUCTION"] = "-%d%%"
    
    ---------------------------------------------------------------------------
    -- External Cooldown Abbreviations
    ---------------------------------------------------------------------------
    L["CD_PAIN_SUPPRESSION"] = "SUPR-DOL"
    L["CD_POWER_INFUSION"] = "INF-POD"
    L["CD_BLESSING_PROTECTION"] = "BEND-PROT"
    L["CD_BLESSING_SACRIFICE"] = "BEND-SACR"
    L["CD_INNERVATE"] = "ENERV"
    L["CD_MANA_TIDE"] = "MAREA-MAN"
    L["CD_HEROISM"] = "HEROE"
    L["CD_BLOODLUST"] = "SED-SANG"
    
    ---------------------------------------------------------------------------
    -- Defensive Cooldown Abbreviations
    ---------------------------------------------------------------------------
    L["DEF_DIVINE_SHIELD"] = "ESC-DIV"
    L["DEF_ICE_BLOCK"] = "BLOQ-HIE"
    L["DEF_DIVINE_INTERVENTION"] = "INT-DIV"
    L["DEF_DIVINE_PROTECTION"] = "PROT-DIV"
    L["DEF_SHIELD_WALL"] = "MUR-ESC"
    L["DEF_EVASION"] = "EVAS"
    L["DEF_BARKSKIN"] = "PIEL-COR"
    
    ---------------------------------------------------------------------------
    -- Color Tooltip Explanations
    ---------------------------------------------------------------------------
    L["COLOR_TOOLTIP_MY_RAID"] = "Tus predicciones de sanación en marcos de banda y compactos."
    L["COLOR_TOOLTIP_OTHER_RAID"] = "Las predicciones de sanación de otros en marcos de banda y compactos."
    L["COLOR_TOOLTIP_MY_UNIT"] = "Tus predicciones de sanación en marcos de jugador, objetivo, grupo y foco."
    L["COLOR_TOOLTIP_OTHER_UNIT"] = "Las predicciones de sanación de otros en marcos de jugador, objetivo, grupo y foco."
    L["COLOR_TOOLTIP_HOT_EXPIRY"] = "Color de borde cuando tus HoTs están a punto de expirar en un objetivo."
    L["COLOR_TOOLTIP_DISPEL_MAGIC"] = "Color de capa para perjuicios de Magia."
    L["COLOR_TOOLTIP_DISPEL_CURSE"] = "Color de capa para perjuicios de Maldición."
    L["COLOR_TOOLTIP_DISPEL_DISEASE"] = "Color de capa para perjuicios de Enfermedad."
    L["COLOR_TOOLTIP_DISPEL_POISON"] = "Color de capa para perjuicios de Veneno."
    L["COLOR_TOOLTIP_CLUSTER"] = "Color de borde para miembros de grupo detectados."
    L["COLOR_TOOLTIP_AOE"] = "Color de borde para el resaltado del asesor AoE."

    ---------------------------------------------------------------------------
    -- Instance Tracking
    ---------------------------------------------------------------------------
    L["INSTANCE_TRACKING"] = "Seguimiento de Instancia"
    L["INSTANCE_TRACKING_STARTED"] = "Seguimiento de instancia iniciado"
    L["INSTANCE_RUN_ENDED"] = "Ejecución de instancia finalizada"
    L["INSTANCE_PROGRESS"] = "Progreso de Instancia"
    L["INSTANCE_HPS_ABOVE_AVG"] = "HPS sobre el promedio de instancia"
end
