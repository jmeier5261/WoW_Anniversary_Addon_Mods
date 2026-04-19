-- SpellData.lua — Class Data Loaders + First Aid
-- Part of HealEngine-1.0 split architecture
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn
-- Modifications by PineappleTuesday

local Engine = LibStub("HealEngine-1.0")
if not Engine then return end

---------------------------------------------------------------------------
-- Local aliases from Engine
---------------------------------------------------------------------------
local castInfo   = Engine.castInfo
local tickInfo   = Engine.tickInfo
local talentMods = Engine.talentMods
local gearSets   = Engine.gearSets
local gearCount  = Engine.gearCount
local rankOf     = Engine.rankOf
local unitMap    = Engine.unitMap
local groupMap   = Engine.groupMap
local compressCache = Engine.compressGUID

local DIRECT  = Engine._DIRECT
local CHANNEL = Engine._CHANNEL
local HOT     = Engine._HOT
local BOMB    = Engine._BOMB

local computeHeal = Engine.computeHeal
local baseHeal    = Engine.baseHeal
local avg         = Engine.avg
local unitHasBuff = Engine.unitHasBuff

local mathceil = math.ceil
local pairs    = pairs
local ipairs   = ipairs
local type     = type
local select   = select
local GetSpellInfo         = GetSpellInfo
local GetSpellBonusHealing = GetSpellBonusHealing
local GetSpellCritChance   = GetSpellCritChance
local UnitBuff    = UnitBuff
local UnitGUID    = UnitGUID
local UnitName    = UnitName
local UnitClass   = UnitClass
local IsSpellInRange       = IsSpellInRange
local CheckInteractDistance = CheckInteractDistance
local UnitIsVisible = UnitIsVisible
local tconcat    = table.concat
local strsplit   = strsplit

---------------------------------------------------------------------------
-- CLASS DATA LOADER (TBC Anniversary only)
-- Each class defines: CalculateHeal, CalculateHoT, GetTargets, OnAuraChange
---------------------------------------------------------------------------
local playerClass = select(2, UnitClass("player"))

-- Helper shared by all classes
local function talentVal(name) return talentMods[name] and talentMods[name].value or 0 end

-- Forward declarations
local CalculateHeal     -- (guid, spellID, unit) → healType, amount [, ticks, interval]
local CalculateHoT      -- (guid, spellID) → healType, amount, totalTicks, interval [, bombAmt]
local GetTargets         -- (healType, guid, spellID) → "compressedGUID,..." string
local OnAuraChange       -- (unit, guid) — class-specific aura tracker
local SELF_TARGET_SPELLS

---------------------------------------------------------------------------
-- DRUID
---------------------------------------------------------------------------
if playerClass == "DRUID" then
    local function loadDruid()
        local GiftOfNature    = GetSpellInfo(17104)
        local HealingTouch    = GetSpellInfo(5185)
        local ImprovedRejuv   = GetSpellInfo(17111)
        local Regrowth        = GetSpellInfo(8936)
        local Rejuvenation    = GetSpellInfo(774)
        local Tranquility     = GetSpellInfo(740)
        local Lifebloom       = GetSpellInfo(33763) or "Lifebloom"
        local EmpoweredRejuv  = GetSpellInfo(33886) or "Empowered Rejuvenation"
        local EmpoweredTouch  = GetSpellInfo(33879) or "Empowered Touch"
        local TreeOfLife       = GetSpellInfo(33891) or "Tree of Life"

        -- Talent definitions
        talentMods[GiftOfNature]    = { step = 0.02, value = 0 }
        talentMods[ImprovedRejuv]   = { step = 0.05, value = 0 }
        if Engine.isTBC then
            talentMods[EmpoweredRejuv]  = { step = 0.04, value = 0 }
            talentMods[EmpoweredTouch]  = { step = 0.10, value = 0 }
        end

        -- Set bonuses
        gearSets["Stormrage"]   = { 16903, 16898, 16904, 16897, 16900, 16899, 16901, 16902 }
        if Engine.isTBC then
            gearSets["Nordrassil"]  = { 30216, 30217, 30219, 30220, 30221 }
            gearSets["Thunderheart"] = { 31041, 31032, 31037, 31045, 31047, 34571, 34445, 34554 }
        end

        -- Relic bonuses
        local bloomBombIdols = { [28355]=87, [33076]=105, [33841]=116, [35021]=131 }
        local rejuvIdols = { [22398]=50, [25643]=86, [38366]=33 }
        local bloomIdols = { [27886]=47 }

        -- HoT data
        tickInfo[Regrowth] = {
            coeff = 0.7, interval = 3, ticks = 7,
            levels = { 12, 18, 24, 30, 36, 42, 48, 54, 60 },
            heals = { 98, 175, 259, 343, 427, 546, 686, 861, 1064 },
        }
        tickInfo[Rejuvenation] = {
            coeff = 0.80, interval = 3, ticks = 4,  -- 12s duration / 15 = 0.80
            levels = { 4, 10, 16, 22, 28, 34, 40, 46, 52, 58, 60 },
            heals = { 32, 56, 116, 180, 244, 304, 388, 488, 608, 756, 888 },
        }
        if Engine.isTBC then
            -- Regrowth R10-R11
            tinsert(tickInfo[Regrowth].levels, 65)   tinsert(tickInfo[Regrowth].heals, 1274)
            tinsert(tickInfo[Regrowth].levels, 71)   tinsert(tickInfo[Regrowth].heals, 1792)
            -- Rejuvenation R12-R13
            tinsert(tickInfo[Rejuvenation].levels, 63)  tinsert(tickInfo[Rejuvenation].heals, 932)
            tinsert(tickInfo[Rejuvenation].levels, 69)  tinsert(tickInfo[Rejuvenation].heals, 1060)
            -- Lifebloom (TBC only)
            tickInfo[Lifebloom] = {
                coeff = 0.52, interval = 1, ticks = 7,
                levels = { 64 }, heals = { 273 },
                bombCoeff = 0.34335, bombHeals = { 600 },
            }
        end

        -- Cast data
        castInfo[HealingTouch] = {
            coeff = 1, -- rank-based: overridden in CalculateHeal
            levels = { 1, 8, 14, 20, 26, 32, 38, 44, 50, 56, 60 },
            heals = { avg(37,51), avg(88,112), avg(195,243), avg(363,445), avg(572,694),
                      avg(742,894), avg(936,1120), avg(1199,1427), avg(1516,1796),
                      avg(1890,2230), avg(2267,2677) },
        }
        castInfo[Regrowth] = {
            coeff = 0.5 * (2/3.5),
            levels = tickInfo[Regrowth].levels,
            heals = { avg(84,98), avg(164,188), avg(240,274), avg(318,360), avg(405,457),
                      avg(511,575), avg(646,724), avg(809,905), avg(1003,1119) },
        }
        castInfo[Tranquility] = {
            channeled = true, coeff = 1.145, ticks = 4, interval = 2,
            levels = { 30, 40, 50, 60 },
            heals = { 351*4, 515*4, 765*4, 1097*4 },
        }
        if Engine.isTBC then
            -- HealingTouch R12-R13
            tinsert(castInfo[HealingTouch].levels, 62)  tinsert(castInfo[HealingTouch].heals, avg(2364,2790))
            tinsert(castInfo[HealingTouch].levels, 69)  tinsert(castInfo[HealingTouch].heals, avg(2707,3197))
            -- Regrowth R10-R11 (cast levels mirror HoT levels, already extended)
            tinsert(castInfo[Regrowth].heals, avg(1215,1355))
            tinsert(castInfo[Regrowth].heals, avg(1710,1908))
            -- Tranquility R5
            tinsert(castInfo[Tranquility].levels, 70)  tinsert(castInfo[Tranquility].heals, 1518*4)
        end

        -- Aura handler
        local hotTotals, hasRegrowth = {}, {}
        OnAuraChange = function(unit, guid)
            -- Track Regrowth and other HoTs for set bonuses
            hotTotals[guid] = 0
            hasRegrowth[guid] = nil
            local idx = 1
            while true do
                local name, _, stacks, _, _, _, _, _, _, sid = UnitBuff(unit, idx)
                if not name then break end
                if name == Rejuvenation or name == Regrowth or name == Lifebloom then
                    hotTotals[guid] = hotTotals[guid] + 1
                end
                if name == Regrowth then hasRegrowth[guid] = true end
                idx = idx + 1
            end
        end

        -- Calculate direct/channel heals
        CalculateHeal = function(guid, spellID, unit)
            local spellName = GetSpellInfo(spellID)
            local rank = rankOf[spellID]
            if not rank then return end

            local data = castInfo[spellName]
            if not data then return end
            local base = baseHeal(data, rank)
            local sp = GetSpellBonusHealing()
            local mod = Engine.myHealMod * (1 + talentVal(GiftOfNature))
            local spMod = 1

            if spellName == HealingTouch then
                -- Rank-based cast time coefficient (LHC4 match)
                local castTime = rank >= 5 and 3.5 or (rank == 4 and 3 or (rank == 3 and 2.5 or (rank == 2 and 2 or 1.5)))
                sp = sp * ((castTime / 3.5) + talentVal(EmpoweredTouch))

                -- Idol of Health (+100 HT), Idol of the Emerald Queen (+136 HT)
                local currentRelic = Engine.currentRelic
                if currentRelic == 22399 then base = base + 100
                elseif currentRelic == 28568 then base = base + 136 end

                -- Thunderheart 4pc: +5% HT
                if (gearCount["Thunderheart"] or 0) >= 4 then mod = mod * 1.05 end

            elseif spellName == Regrowth then
                sp = sp * data.coeff
            elseif spellName == Tranquility then
                sp = sp * data.coeff * (1 + talentVal(EmpoweredRejuv))
                sp = sp / data.ticks
                base = base / data.ticks
                return CHANNEL, mathceil(computeHeal(data.levels[rank], base, sp, 1, mod)), data.ticks, data.interval
            end

            -- Druid crit school is Nature (4), not Holy (2)
            if GetSpellCritChance(4) >= 100 then
                local healAmt = computeHeal(data.levels[rank], base, sp, spMod, mod)
                return DIRECT, mathceil(healAmt * 1.50)
            end

            return DIRECT, mathceil(computeHeal(data.levels[rank], base, sp, spMod, mod))
        end

        -- Calculate HoT heals
        CalculateHoT = function(guid, spellID)
            local spellName = GetSpellInfo(spellID)
            local rank = rankOf[spellID]
            if not rank then return end

            local data = tickInfo[spellName]
            if not data then return end
            local base = baseHeal(data, rank)
            local sp = GetSpellBonusHealing()
            local mod = Engine.myHealMod * (1 + talentVal(GiftOfNature))
            local totalTicks = data.ticks
            local currentRelic = Engine.currentRelic

            if spellName == Rejuvenation then
                mod = mod * (1 + talentVal(ImprovedRejuv))

                -- Idol of the Raven Goddess: +44 SP in Tree of Life form
                if currentRelic == 32387 and unitHasBuff("player", TreeOfLife) then
                    sp = sp + 44
                end

                local rejuvIdolBonus = currentRelic and rejuvIdols[currentRelic] or 0
                -- 12s duration, coeff = duration/15 = 0.80 (stored in data.coeff)
                sp = sp * (data.coeff * (1 + talentVal(EmpoweredRejuv)))

                -- Stormrage 8pc: +1 tick (add tick amount to total first)
                if (gearCount["Stormrage"] or 0) >= 8 then
                    base = base + (base / totalTicks) -- add one tick's worth to total
                    totalTicks = totalTicks + 1
                end

                sp = sp / totalTicks
                base = (base + rejuvIdolBonus) / totalTicks
            elseif spellName == Lifebloom then
                -- Idol of the Raven Goddess: +44 SP in Tree of Life form
                local rawSp = GetSpellBonusHealing()
                if currentRelic == 32387 and unitHasBuff("player", TreeOfLife) then
                    rawSp = rawSp + 44
                end

                local bloomIdolBonus = currentRelic and bloomIdols[currentRelic] or 0
                -- Empowered Rejuv applies to Lifebloom HoT (LHC4 match)
                sp = rawSp * (data.coeff * (1 + talentVal(EmpoweredRejuv)))
                sp = sp / totalTicks
                base = (base + bloomIdolBonus) / totalTicks

                if currentRelic and bloomIdols[currentRelic] then
                    sp = sp + bloomIdols[currentRelic]
                end

                -- Bomb component — Empowered Rejuv applies to bloom too
                local bombBase = data.bombHeals and data.bombHeals[rank] or 0
                local bombIdolBonus = currentRelic and bloomBombIdols[currentRelic] or 0
                local bombSp = rawSp
                if bombIdolBonus > 0 then bombSp = bombSp + bombIdolBonus end
                bombSp = bombSp * ((data.bombCoeff or 0) * (1 + talentVal(EmpoweredRejuv)))
                local bombAmt = mathceil(computeHeal(data.levels[rank], bombBase, bombSp, 1, mod))
                return HOT, mathceil(computeHeal(data.levels[rank], base, sp, 1, mod)), totalTicks, data.interval, bombAmt
            elseif spellName == Regrowth then
                -- Empowered Rejuvenation applies to Regrowth HoT too (LHC4 match)
                sp = sp * data.coeff * (1 + talentVal(EmpoweredRejuv))
                sp = sp / data.ticks
                base = base / data.ticks

                totalTicks = data.ticks -- 7 base
                -- Nordrassil 2pc: +2 Regrowth ticks
                if (gearCount["Nordrassil"] or 0) >= 2 then totalTicks = totalTicks + 2 end
            end

            return HOT, mathceil(computeHeal(data.levels and data.levels[rank], base, sp, 1, mod)), totalTicks, data.interval
        end

        -- Target resolution
        GetTargets = function(healType, guid, spellID, amount)
            local spellName = GetSpellInfo(spellID)
            local myGUID = Engine.myGUID
            if spellName == Tranquility then
                -- Heals all party members in range
                local myGroup = groupMap[myGUID]
                local t = { compressCache[myGUID] }
                for g, grp in pairs(groupMap) do
                    if grp == myGroup and g ~= myGUID and unitMap[g] and UnitIsVisible(unitMap[g]) then
                        t[#t + 1] = compressCache[g]
                    end
                end
                return tconcat(t, ",")
            end
            return compressCache[guid]
        end

        SELF_TARGET_SPELLS = { [Tranquility] = true }
    end

    loadDruid()
end

---------------------------------------------------------------------------
-- PALADIN
---------------------------------------------------------------------------
if playerClass == "PALADIN" then
    local function loadPaladin()
        local HolyLight    = GetSpellInfo(635)
        local FlashOfLight = GetSpellInfo(19750)
        local HealingLight = GetSpellInfo(20237)
        local DivineFavor  = GetSpellInfo(20216)

        talentMods[HealingLight] = { step = 0.04, value = 0 }

        local flashLibrams = { [23006]=83, [23201]=53, [25644]=79 }
        local holyLibrams  = { [28296]=47 }

        -- Blessing of Light values by aura spellID
        local blessingBonus = {
            [19977] = { [HolyLight]=210,  [FlashOfLight]=60 },
            [19978] = { [HolyLight]=300,  [FlashOfLight]=85 },
            [19979] = { [HolyLight]=400,  [FlashOfLight]=115 },
            [25890] = { [HolyLight]=400,  [FlashOfLight]=115 },
        }
        if Engine.isTBC then
            blessingBonus[27144] = { [HolyLight]=580, [FlashOfLight]=185 }
            blessingBonus[27145] = { [HolyLight]=580, [FlashOfLight]=185 }
            gearSets["Lightbringer"] = { 30992, 30983, 30988, 30994, 30996, 34432, 34487, 34559 }
        end

        castInfo[HolyLight] = {
            coeff = 2.5 / 3.5,
            levels = { 1, 6, 14, 22, 30, 38, 46, 54, 60 },
            heals = { avg(39,47), avg(76,90), avg(159,187), avg(310,356), avg(491,553),
                      avg(698,780), avg(945,1053), avg(1246,1388), avg(1590,1770) },
        }
        castInfo[FlashOfLight] = {
            coeff = 1.5 / 3.5,
            levels = { 20, 26, 34, 42, 50, 58 },
            heals = { avg(62,72), avg(96,110), avg(145,163), avg(197,221),
                      avg(267,299), avg(343,383) },
        }
        if Engine.isTBC then
            -- HolyLight R10-R11
            tinsert(castInfo[HolyLight].levels, 62)   tinsert(castInfo[HolyLight].heals, avg(1741,1939))
            tinsert(castInfo[HolyLight].levels, 70)   tinsert(castInfo[HolyLight].heals, avg(2196,2446))
            -- FlashOfLight R7
            tinsert(castInfo[FlashOfLight].levels, 66)  tinsert(castInfo[FlashOfLight].heals, avg(448,502))
        end

        local hasDivineFavor = false
        OnAuraChange = function(unit, guid)
            if unit == "player" then
                hasDivineFavor = unitHasBuff("player", DivineFavor) ~= nil
            end
        end

        CalculateHeal = function(guid, spellID, unit)
            local spellName = GetSpellInfo(spellID)
            local rank = rankOf[spellID]
            if not rank then return end

            local data = castInfo[spellName]
            if not data then return end
            local base = baseHeal(data, rank)
            local sp = GetSpellBonusHealing()
            local mod = Engine.myHealMod * (1 + talentVal(HealingLight))
            local currentRelic = Engine.currentRelic

            -- Libram bonuses
            if currentRelic then
                if spellName == FlashOfLight and flashLibrams[currentRelic] then
                    sp = sp + flashLibrams[currentRelic]
                elseif spellName == HolyLight and holyLibrams[currentRelic] then
                    sp = sp + holyLibrams[currentRelic]
                end
            end

            -- Lightbringer 4pc: +5% Flash of Light
            if (gearCount["Lightbringer"] or 0) >= 4 and spellName == FlashOfLight then
                mod = mod + 0.05
            end

            sp = sp * data.coeff
            local healAmt = computeHeal(data.levels[rank], base, sp, 1, mod)

            -- Blessing of Light bonus
            for auraID, vals in pairs(blessingBonus) do
                if unitHasBuff(unit, auraID) then
                    healAmt = healAmt + (vals[spellName] or 0) * mod
                    break
                end
            end

            -- Divine Favor or 100% crit
            if hasDivineFavor or GetSpellCritChance(2) >= 100 then
                healAmt = healAmt * 1.50
            end

            return DIRECT, mathceil(healAmt)
        end

        CalculateHoT = function() return nil end

        GetTargets = function(healType, guid, spellID, amount)
            return compressCache[guid]
        end
    end

    loadPaladin()
end

---------------------------------------------------------------------------
-- PRIEST
---------------------------------------------------------------------------
if playerClass == "PRIEST" then
    local function loadPriest()
        local Renew           = GetSpellInfo(139)
        local GreaterHeal     = GetSpellInfo(2060)
        local PrayerOfHealing = GetSpellInfo(596)
        local FlashHeal       = GetSpellInfo(2061)
        local Heal            = GetSpellInfo(2054)
        local LesserHeal      = GetSpellInfo(2050)
        local BindingHeal     = GetSpellInfo(32546) or "Binding Heal"
        local GreaterHealHoT  = GetSpellInfo(22009)
        local DispelMagic     = GetSpellInfo(527)
        local SpiritualHealing = GetSpellInfo(14898)
        local ImprovedRenew   = GetSpellInfo(14908)
        local EmpoweredHealing = GetSpellInfo(33158) or "Empowered Healing"
        local BlessedResilience = GetSpellInfo(33142) or "Blessed Resilience"
        local FocusedPower     = GetSpellInfo(33190) or "Focused Power"
        local DivineProvidence = GetSpellInfo(47567) or "Divine Providence"

        talentMods[SpiritualHealing] = { step = 0.02, value = 0 }
        talentMods[ImprovedRenew]    = { step = 0.05, value = 0 }
        if Engine.isTBC then
            talentMods[EmpoweredHealing] = { step = 0.02, value = 0 }
            talentMods[BlessedResilience] = { step = 0.01, value = 0 }
            talentMods[FocusedPower]     = { step = 0.02, value = 0 }
            talentMods[DivineProvidence] = { step = 0.02, value = 0 }
        end

        gearSets["Oracle"]     = { 21351, 21349, 21350, 21348, 21352 }
        if Engine.isTBC then
            gearSets["Absolution"] = { 31068, 31063, 31060, 31069, 31066, 34562, 34527, 34435 }
            gearSets["Avatar"]     = { 30153, 30152, 30151, 30154, 30150 }
        end

        -- Renew data
        tickInfo[Renew] = {
            coeff = 1, interval = 3, ticks = 5,
            levels = { 8, 14, 20, 26, 32, 38, 44, 50, 56, 60 },
            heals = { 45, 100, 175, 245, 315, 400, 510, 650, 810, 970 },
        }
        if Engine.isTBC then
            tinsert(tickInfo[Renew].levels, 65)  tinsert(tickInfo[Renew].heals, 1010)
            tinsert(tickInfo[Renew].levels, 70)  tinsert(tickInfo[Renew].heals, 1110)
        end
        -- Greater Heal HoT (Rank 5+) shares Renew data
        if GreaterHealHoT then tickInfo[GreaterHealHoT] = tickInfo[Renew] end

        -- Cast data
        castInfo[FlashHeal] = {
            coeff = 1.5 / 3.5,
            levels = { 20, 26, 32, 38, 44, 50, 56 },
            heals = { avg(193,237), avg(258,314), avg(327,393), avg(400,478), avg(518,616),
                      avg(644,764), avg(812,958) },
        }
        castInfo[GreaterHeal] = {
            coeff = 3 / 3.5,
            levels = { 40, 46, 52, 58, 60 },
            heals = { avg(899,1013), avg(1149,1289), avg(1437,1609), avg(1798,2006),
                      avg(1966,2194) },
        }
        castInfo[Heal] = {
            coeff = 3 / 3.5,
            levels = { 16, 22, 28, 34 },
            heals = { avg(295,341), avg(429,491), avg(566,642), avg(712,804) },
        }
        castInfo[LesserHeal] = {
            levels = { 1, 4, 10 },
            heals = { avg(46,56), avg(71,85), avg(135,157) },
        }
        castInfo[PrayerOfHealing] = {
            coeff = 0.431596,
            levels = { 30, 40, 50, 60 },
            heals = { avg(301,321), avg(444,472), avg(657,695), avg(939,991) },
        }
        if Engine.isTBC then
            -- FlashHeal R8-R9
            tinsert(castInfo[FlashHeal].levels, 61)  tinsert(castInfo[FlashHeal].heals, avg(913,1059))
            tinsert(castInfo[FlashHeal].levels, 67)  tinsert(castInfo[FlashHeal].heals, avg(1101,1279))
            -- GreaterHeal R6-R7
            tinsert(castInfo[GreaterHeal].levels, 63)  tinsert(castInfo[GreaterHeal].heals, avg(2074,2410))
            tinsert(castInfo[GreaterHeal].levels, 68)  tinsert(castInfo[GreaterHeal].heals, avg(2396,2784))
            -- PrayerOfHealing R5-R6
            tinsert(castInfo[PrayerOfHealing].levels, 60)  tinsert(castInfo[PrayerOfHealing].heals, avg(997,1053))
            tinsert(castInfo[PrayerOfHealing].levels, 68)  tinsert(castInfo[PrayerOfHealing].heals, avg(1246,1316))
            -- BindingHeal (TBC only)
            castInfo[BindingHeal] = {
                coeff = 1.5 / 3.5,
                levels = { 64 },
                heals = { avg(1042,1338) },
            }
        end

        OnAuraChange = function(unit, guid)
            -- Nothing special for TBC priest
        end

        CalculateHeal = function(guid, spellID, unit)
            local spellName = GetSpellInfo(spellID)
            local rank = rankOf[spellID]
            if not rank then return end

            local data = castInfo[spellName]
            if not data then return end
            local base = baseHeal(data, rank)
            local sp = GetSpellBonusHealing()
            local mod = Engine.myHealMod * (1 + talentVal(SpiritualHealing))

            if spellName == GreaterHeal then
                if (gearCount["Absolution"] or 0) >= 4 then mod = mod * 1.05 end
                sp = sp * (data.coeff * (1 + talentVal(EmpoweredHealing) * 2))
            elseif spellName == FlashHeal then
                sp = sp * (data.coeff * (1 + talentVal(EmpoweredHealing)))
            elseif spellName == BindingHeal then
                -- Divine Providence applies to Binding Heal (LHC4 match)
                mod = mod + talentVal(DivineProvidence)
                sp = sp * (data.coeff * (1 + talentVal(EmpoweredHealing)))
            elseif spellName == PrayerOfHealing then
                -- Divine Providence applies to Prayer of Healing (LHC4 match)
                mod = mod + talentVal(DivineProvidence)
                sp = sp * data.coeff
            elseif spellName == Heal then
                sp = sp * data.coeff
            elseif spellName == LesserHeal then
                local ct = rank >= 3 and 2.5 or rank == 2 and 2 or 1.5
                sp = sp * (ct / 3.5)
            else
                sp = sp * (data.coeff or 0)
            end

            mod = mod * (1 + talentVal(FocusedPower))
            mod = mod * (1 + talentVal(BlessedResilience))

            local healAmt = computeHeal(data.levels[rank], base, sp, 1, mod)

            if GetSpellCritChance(2) >= 100 then
                healAmt = healAmt * 1.50
            end

            return DIRECT, mathceil(healAmt)
        end

        CalculateHoT = function(guid, spellID)
            local spellName = GetSpellInfo(spellID)
            local rank = rankOf[spellID]
            if not rank then return end

            local data = tickInfo[spellName]
            if not data then return end
            local base = baseHeal(data, rank)
            local sp = GetSpellBonusHealing()
            local mod = Engine.myHealMod * (1 + talentVal(SpiritualHealing))
            local totalTicks = data.ticks

            if spellName == Renew or spellName == GreaterHealHoT then
                mod = mod * (1 + talentVal(ImprovedRenew))
                -- Oracle 5pc or Avatar 4pc: +1 tick
                if (gearCount["Oracle"] or 0) >= 5 or (gearCount["Avatar"] or 0) >= 4 then
                    base = base + (base / totalTicks)
                    totalTicks = totalTicks + 1
                end
                sp = sp * data.coeff / totalTicks
                base = base / totalTicks
            end

            mod = mod * (1 + talentVal(FocusedPower))
            mod = mod * (1 + talentVal(BlessedResilience))

            return HOT, mathceil(computeHeal(data.levels[rank], base, sp, 1, mod)), totalTicks, data.interval
        end

        GetTargets = function(healType, guid, spellID, amount)
            local spellName = GetSpellInfo(spellID)
            local myGUID = Engine.myGUID

            if spellName == BindingHeal then
                if guid == myGUID then
                    return compressCache[myGUID]
                else
                    return compressCache[guid] .. "," .. compressCache[myGUID]
                end

            elseif spellName == PrayerOfHealing then
                -- PoH heals the caster's party group
                local casterGUID = UnitGUID("player")
                local myGroup = groupMap[casterGUID]
                local t = { compressCache[casterGUID] }

                for memberGUID, grp in pairs(groupMap) do
                    if grp == myGroup and memberGUID ~= casterGUID then
                        local memberUnit = unitMap[memberGUID]
                        if memberUnit then
                            local inRange = IsSpellInRange(DispelMagic, memberUnit) == 1
                            if inRange and UnitIsVisible(memberUnit) then
                                t[#t + 1] = compressCache[memberGUID]
                            end
                        end
                    end
                end

                return tconcat(t, ",")
            end

            return compressCache[guid]
        end

        SELF_TARGET_SPELLS = { [PrayerOfHealing] = true }
        if Engine.isTBC then SELF_TARGET_SPELLS[BindingHeal] = true end
    end

    loadPriest()
end

---------------------------------------------------------------------------
-- SHAMAN
---------------------------------------------------------------------------
if playerClass == "SHAMAN" then
    local function loadShaman()
        local ChainHeal       = GetSpellInfo(1064)
        local HealingWave     = GetSpellInfo(331)
        local LesserHealWave  = GetSpellInfo(8004)
        local Purification    = GetSpellInfo(16178) or "Purification"
        local ImpChainHeal    = GetSpellInfo(30872) or "Improved Chain Heal"
        local EarthShield     = GetSpellInfo(974) or "Earth Shield"
        local HealingWay      = GetSpellInfo(29206) or "Healing Way"

        talentMods[Purification]  = { step = 0.02, value = 0 }
        if Engine.isTBC then
            talentMods[ImpChainHeal]  = { step = 0.10, value = 0 }
            gearSets["Skyshatter"] = { 31016, 31007, 31012, 31019, 31022, 34543, 34438, 34565 }
        end

        -- Totem/relic bonuses
        local lhwTotems = { [25645]=79, [22396]=80, [23200]=53 }
        local chTotems  = { [38368]=102, [28523]=87 }

        castInfo[HealingWave] = {
            coeff = 3 / 3.5,
            levels = { 1, 6, 12, 18, 24, 32, 40, 48, 56, 60 },
            heals = { avg(34,44), avg(64,78), avg(129,155), avg(268,316), avg(376,440),
                      avg(536,622), avg(740,854), avg(1017,1167), avg(1367,1561),
                      avg(1620,1850) },
        }
        castInfo[LesserHealWave] = {
            coeff = 1.5 / 3.5,
            levels = { 20, 28, 36, 44, 52, 60 },
            heals = { avg(162,186), avg(247,281), avg(337,381), avg(458,514),
                      avg(631,705), avg(832,928) },
        }
        castInfo[ChainHeal] = {
            coeff = 2.5 / 3.5,
            levels = { 40, 46, 54 },
            heals = { avg(320,368), avg(405,465), avg(551,629) },
        }
        if Engine.isTBC then
            -- HealingWave R11-R12
            tinsert(castInfo[HealingWave].levels, 63)  tinsert(castInfo[HealingWave].heals, avg(1725,1969))
            tinsert(castInfo[HealingWave].levels, 69)  tinsert(castInfo[HealingWave].heals, avg(2134,2436))
            -- LesserHealWave R7
            tinsert(castInfo[LesserHealWave].levels, 69)  tinsert(castInfo[LesserHealWave].heals, avg(1039,1185))
            -- ChainHeal R4-R5
            tinsert(castInfo[ChainHeal].levels, 61)  tinsert(castInfo[ChainHeal].heals, avg(605,693))
            tinsert(castInfo[ChainHeal].levels, 68)  tinsert(castInfo[ChainHeal].heals, avg(826,944))
            -- EarthShield (TBC only)
            tickInfo[EarthShield] = {
                coeff = 0, interval = 0, ticks = 6,
                levels = { 64 }, heals = { 150 },
            }
        end

        OnAuraChange = function(unit, guid) end

        CalculateHeal = function(guid, spellID, unit)
            local spellName = GetSpellInfo(spellID)
            local rank = rankOf[spellID]
            if not rank then return end

            local data = castInfo[spellName]
            if not data then return end
            local base = baseHeal(data, rank)
            local sp = GetSpellBonusHealing()
            local mod = Engine.myHealMod * (1 + talentVal(Purification))
            local currentRelic = Engine.currentRelic

            -- Chain Heal
            if spellName == ChainHeal then
                sp = sp * data.coeff

                -- Skyshatter 4pc: +5% Chain Heal
                if (gearCount["Skyshatter"] or 0) >= 4 then
                    mod = mod * 1.05
                end

                -- Improved Chain Heal talent
                mod = mod * (1 + talentVal(ImpChainHeal))

                -- Chain Heal totems
                if currentRelic and chTotems[currentRelic] then
                    base = base + chTotems[currentRelic]
                end

            -- Healing Wave
            elseif spellName == HealingWave then
                -- Healing Way stacks on target
                local _, stacks = unitHasBuff(unit, 29203)
                if stacks and stacks > 0 then
                    base = base * (1 + stacks * 0.06)
                end

                -- HW totem: Totem of Spontaneous Regrowth
                if currentRelic == 27544 then sp = sp + 88 end

                -- Rank-based cast time coefficient (LHC4 match)
                local castTime = rank > 3 and 3 or (rank == 3 and 2.5 or (rank == 2 and 2 or 1.5))
                sp = sp * (castTime / 3.5)

            -- Lesser Healing Wave
            elseif spellName == LesserHealWave then
                -- LHW totems
                sp = sp + (currentRelic and lhwTotems[currentRelic] or 0)
                sp = sp * data.coeff
            else
                sp = sp * (data.coeff or 0)
            end

            local healAmt = computeHeal(data.levels[rank], base, sp, 1, mod)

            -- Shaman crit school is Nature (4), not Holy (2)
            if GetSpellCritChance(4) >= 100 then
                healAmt = healAmt * 1.50
            end

            return DIRECT, mathceil(healAmt)
        end

        CalculateHoT = function(guid, spellID) return nil end

        GetTargets = function(healType, guid, spellID, amount)
            local spellName = GetSpellInfo(spellID)
            -- Chain Heal bounces, but we only predict primary target
            return compressCache[guid]
        end
    end

    loadShaman()
end

---------------------------------------------------------------------------
-- NON-HEALER CLASS — still handles First Aid and incoming heals
---------------------------------------------------------------------------
if not CalculateHeal then
    CalculateHeal = function() return nil end
end
if not CalculateHoT then
    CalculateHoT = function() return nil end
end
if not GetTargets then
    GetTargets = function(_, guid) return compressCache[guid] end
end
if not OnAuraChange then
    OnAuraChange = function() end
end
if not SELF_TARGET_SPELLS then
    SELF_TARGET_SPELLS = {}
end

---------------------------------------------------------------------------
-- FIRST AID (all classes)
---------------------------------------------------------------------------
do
    local FirstAid = GetSpellInfo(746)
    if FirstAid then
        castInfo[FirstAid] = {
            channeled = true, coeff = 0, interval = 1,
            ticks = { 6, 6, 7, 7, 8, 8, 8, 8, 8, 8 },
            levels = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
            heals = { 66, 114, 161, 301, 400, 640, 800, 1104, 1360, 2000 },
        }
        if Engine.isTBC then
            local fa = castInfo[FirstAid]
            tinsert(fa.ticks, 8)  tinsert(fa.levels, 1)  tinsert(fa.heals, 2800)
            tinsert(fa.ticks, 8)  tinsert(fa.levels, 1)  tinsert(fa.heals, 3400)
            tinsert(fa.ticks, 8)  tinsert(fa.levels, 1)  tinsert(fa.heals, 4800)
            tinsert(fa.ticks, 8)  tinsert(fa.levels, 1)  tinsert(fa.heals, 5800)
        end

        -- Wrap existing functions to handle First Aid
        local origCalc = CalculateHeal
        local origTargets = GetTargets

        CalculateHeal = function(guid, spellID, unit)
            local spellName = GetSpellInfo(spellID)
            if spellName == FirstAid then
                local rank = rankOf[spellID]
                if not rank then return end
                local data = castInfo[FirstAid]
                local totalHeal = data.heals[rank]
                if not totalHeal then return end
                local numTicks = type(data.ticks) == "table" and data.ticks[rank] or data.ticks
                return CHANNEL, mathceil(totalHeal / numTicks), numTicks, data.interval
            end
            return origCalc(guid, spellID, unit)
        end

        GetTargets = function(healType, guid, spellID, amount)
            local spellName = GetSpellInfo(spellID)
            if spellName == FirstAid then
                return compressCache[guid]
            end
            return origTargets(healType, guid, spellID, amount)
        end
    end
end

---------------------------------------------------------------------------
-- FOREIGN HOT ESTIMATOR (cross-class, always loaded)
-- Used when another player casts a tracked HoT on a unit we're watching
-- and that caster isn't running HealPredict (no wire data). We can't read
-- their spell power / talents / relics, so we approximate with our own
-- +healing as a proxy. Empirical tick updates in CastTracking correct the
-- amount after the first tick lands.
---------------------------------------------------------------------------
do
    local Rejuvenation = GetSpellInfo(774)
    local Regrowth     = GetSpellInfo(8936)
    local Renew        = GetSpellInfo(139)
    local Lifebloom    = Engine.isTBC and (GetSpellInfo(33763) or "Lifebloom") or nil

    local FOREIGN = {}

    if Rejuvenation then
        local d = { ticks = 4, interval = 3, coeff = 0.80,
            heals = { 32, 56, 116, 180, 244, 304, 388, 488, 608, 756, 888 } }
        if Engine.isTBC then
            tinsert(d.heals, 932)   -- R12
            tinsert(d.heals, 1060)  -- R13
        end
        FOREIGN[Rejuvenation] = d
    end

    if Regrowth then
        local d = { ticks = 7, interval = 3, coeff = 0.70,
            heals = { 98, 175, 259, 343, 427, 546, 686, 861, 1064 } }
        if Engine.isTBC then
            tinsert(d.heals, 1274)  -- R10
            tinsert(d.heals, 1792)  -- R11
        end
        FOREIGN[Regrowth] = d
    end

    if Renew then
        local d = { ticks = 5, interval = 3, coeff = 1.0,
            heals = { 45, 100, 175, 245, 315, 400, 510, 650, 810, 970 } }
        if Engine.isTBC then
            tinsert(d.heals, 1010)  -- R11
            tinsert(d.heals, 1110)  -- R12
        end
        FOREIGN[Renew] = d
    end

    if Lifebloom then
        FOREIGN[Lifebloom] = {
            ticks = 7, interval = 1, coeff = 0.52,
            heals = { 273 },
            bombHeals = { 600 }, bombCoeff = 0.34335,
        }
    end

    Engine.foreignHoTs = FOREIGN

    -- Returns perTick, totalTicks, interval, bombAmt (or nil if not tracked)
    Engine.EstimateForeignHoT = function(spellID, spellName)
        if not spellName then
            spellName = GetSpellInfo(spellID)
        end
        local data = spellName and FOREIGN[spellName]
        if not data then return end
        local rank = rankOf[spellID]
        if not rank then return end
        local base = data.heals[rank]
        if not base then return end
        local sp = GetSpellBonusHealing() or 0
        local perTick = mathceil((base + sp * data.coeff) / data.ticks)
        local bombAmt
        if data.bombHeals and data.bombHeals[rank] then
            bombAmt = mathceil(data.bombHeals[rank] + sp * (data.bombCoeff or 0))
        end
        return perTick, data.ticks, data.interval, bombAmt
    end
end

---------------------------------------------------------------------------
-- PRAYER OF MENDING (TBC only, cross-class — tracked regardless of caller)
-- PoM is a buff that heals on damage and jumps up to 5 charges. We track
-- its current holder via AURA_APPLIED/REMOVED in CastTracking and attach
-- a BOMB record for the incoming heal on the current holder.
---------------------------------------------------------------------------
if Engine.isTBC then
    local PrayerOfMending = GetSpellInfo(33076) or "Prayer of Mending"
    Engine.pomData = {
        spellName = PrayerOfMending,
        coeff     = 0.4286,      -- TBC 1.5s instant coefficient
        heals     = { 672 },     -- rank 1 is the only TBC rank
        duration  = 30,
    }

    -- Estimate a single PoM proc heal. Works for both self and foreign
    -- priests — we use the player's own +healing as a caster-SP proxy
    -- when we don't own the cast.
    Engine.EstimatePoM = function(casterGUID, spellID)
        local data = Engine.pomData
        if not data then return nil end
        local rank = rankOf[spellID] or 1
        local base = data.heals[rank] or data.heals[1]
        if not base then return nil end
        local sp = GetSpellBonusHealing() or 0
        return mathceil(base + sp * data.coeff)
    end
end

---------------------------------------------------------------------------
-- Expose on Engine table for CastTracking and Init
---------------------------------------------------------------------------
Engine.CalculateHeal     = CalculateHeal
Engine.CalculateHoT      = CalculateHoT
Engine.GetTargets        = GetTargets
Engine.OnAuraChange      = OnAuraChange
Engine.SELF_TARGET_SPELLS = SELF_TARGET_SPELLS
