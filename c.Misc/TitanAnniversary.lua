--[[
Description: This plugin is part of the "Titan Panel [Currencies] Multi" addon. It shows currencies/items related to Anniversary events.
Site: https://www.curseforge.com/wow/addons/titan-panel-currencies-multi
Author: Canettieri
Special Thanks to Protuhj.
--]]

local _, L = ...;

-- Bronze Celebration Tokens
L:CreateSimpleCurrencyPlugin({
	currencyId = 3100,
	titanId = "TITAN_BRONZECELTOKEN",
	noCurrencyText = L["No20thCurrency"],
	expName = L["mEvent"],
	category = "CATEGORY_MISC"
})

-- Timewarped Relic Coffer Key - Raid Finder
L:CreateSimpleItemPlugin({
	itemId = 231510,
	titanId = "TITAN_RELCOFFERKEY_RF",
	noCurrencyText = L["No20thCurrency"],
	expName = L["mEvent"],
	category = "CATEGORY_MISC"
})

-- Timewarped Relic Coffer Key - Normal
L:CreateSimpleItemPlugin({
	itemId = 232365,
	titanId = "TITAN_RELCOFFERKEY_NORM",
	noCurrencyText = L["No20thCurrency"],
	expName = L["mEvent"],
	category = "CATEGORY_MISC"
})

-- Timewarped Relic Coffer Key - Heroic
L:CreateSimpleItemPlugin({
	itemId = 232366,
	titanId = "TITAN_RELCOFFERKEY_HERO",
	noCurrencyText = L["No20thCurrency"],
	expName = L["mEvent"],
	category = "CATEGORY_MISC"
})
