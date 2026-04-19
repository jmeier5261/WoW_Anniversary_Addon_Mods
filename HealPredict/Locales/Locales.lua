-- HealPredict - Localization Loader
-- Loads the appropriate locale or falls back to enUS
-- Author: DarkpoisOn
-- License: All Rights Reserved (c) 2026 DarkpoisOn

local _, HP = ...

-- Create the localization table
HP.L = {}
local L = HP.L

HP.LocaleData = {}

setmetatable(L, {
    __index = function(self, key)
        return key
    end
})

local gameLocale = GetLocale()

if gameLocale == "enGB" then
    gameLocale = "enUS"
end

function HP.LoadLocale(locale)
    local localeFunc = HP.LocaleData[locale]
    if localeFunc then
        localeFunc(L)
        return true
    end
    return false
end

if HP.LocaleData["enUS"] then
    HP.LoadLocale("enUS")
end

if gameLocale ~= "enUS" and HP.LocaleData[gameLocale] then
    HP.LoadLocale(gameLocale)
end
