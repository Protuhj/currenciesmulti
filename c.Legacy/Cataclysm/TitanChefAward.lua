--[[
Description: This plugin is part of the "Titan Panel [Currencies] Multi" addon. It shows your amount of Chef's Award.
Site: https://www.curseforge.com/wow/addons/titan-panel-currencies-multi
Author: Canettieri
Special Thanks to Eliote.
--]]

local _, L = ...;
local ID = "TITAN_CHFAWM"
local CURRENCY_ID = 402

L:CreateSimpleCurrencyPlugin({
	currencyId = CURRENCY_ID,
	titanId = ID,
	noCurrencyText = L["NoCataCurrency01"],
	expName = L["mCata"],
	category = "CATEGORY_CATA"
})