--[[
Description: This plugin is part of the "Titan Panel [Currencies] Multi" addon. It shows your Dragon Shard of Knowledge counts.
Site: https://www.curseforge.com/wow/addons/titan-panel-currencies-multi
Author: Canettieri
Special Thanks to Protuhj.
--]]

local _, L = ...;
local ID = "TITAN_DRAGONSHARD"
local ITEM_ID = 191784

L:CreateSimpleItemPlugin({
	itemId = ITEM_ID,
	titanId = ID,
	noCurrencyText = L["DragonFOnly"],
	expName = L["mDragonflight"],
	category = "CATEGORY_DRAGON"
})