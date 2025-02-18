--[[
Description: This plugin is part of the "Titan Panel [Currencies] Multi" addon. It shows your amount of Polished Pet Charm.
Site: https://www.curseforge.com/wow/addons/titan-panel-currencies-multi
Author: Canettieri
Special Thanks to Eliote.
--]]

local _, L = ...;
local ID = "TITAN_PLPCM"
local ITEM_ID = 163036

L:CreateSimpleItemPlugin({
	itemId = ITEM_ID,
	titanId = ID,
	noCurrencyText = L["BfAOnly"],
	expName = L["mBfA"],
	category = "CATEGORY_BFA",
	allowAccountTotal = true
})