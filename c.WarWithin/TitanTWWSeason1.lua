--[[
Description: This plugin is part of the "Titan Panel [Currencies] Multi" addon.
It shows the seasonal currencies from The War Within Season 1.
Site: https://www.curseforge.com/wow/addons/titan-panel-currencies-multi
Author: Canettieri
Special Thanks to Protuhj.
--]]

local _, L = ...;

-- Weathered Harbinger Crests
L:CreateSimpleCurrencyPlugin({
	currencyId = 2914,
	titanId = "TITAN_WEATHHARBCREST",
	noCurrencyText = L["TWWSeason1"],
	expName = L["mWarWithin"],
	category = "CATEGORY_TWW",
	forceMax = true,
	weeklyIncrease = 90
})

-- Carved Harbinger Crests
L:CreateSimpleCurrencyPlugin({
	currencyId = 2915,
	titanId = "TITAN_CARVEDHARBCREST",
	noCurrencyText = L["TWWSeason1"],
	expName = L["mWarWithin"],
	category = "CATEGORY_TWW",
	forceMax = true,
	weeklyIncrease = 90
})

-- Runed Harbinger Crests
L:CreateSimpleCurrencyPlugin({
	currencyId = 2916,
	titanId = "TITAN_RUNEDHARBCREST",
	noCurrencyText = L["TWWSeason1"],
	expName = L["mWarWithin"],
	category = "CATEGORY_TWW",
	forceMax = true,
	weeklyIncrease = 90
})

-- Gilded Harbinger Crests
L:CreateSimpleCurrencyPlugin({
	currencyId = 2917,
	titanId = "TITAN_GILDHARBCREST",
	noCurrencyText = L["TWWSeason1"],
	expName = L["mWarWithin"],
	category = "CATEGORY_TWW",
	forceMax = true,
	weeklyIncrease = 90
})