--[[
Description: This plugin is part of the "Titan Panel [Currencies] Multi" addon. It shows your amount of M+ rating.
Site: https://www.curseforge.com/wow/addons/titan-panel-currencies-multi
Author: Protuhj
--]]

local ADDON_NAME, L = ...;
local ACE = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata
local version = GetAddOnMetadata(ADDON_NAME, "Version")
local ID = "TITAN_MPLUSSCORE"
local startScore = 0
local curScore = 0
local curSeason = -1
local PLAYER_NAME, PLAYER_REALM
local PLAYER_KEY
local PLAYER_FACTION
local PLAYER_CLASS_COLOR
-----------------------------------------------
local function getScore()
	local info = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("player")
	return (info and info.currentSeasonScore) or 0
end

local function tryToUpdateSeason()
	if curSeason == -1 then
		if C_MythicPlus.GetCurrentSeason() > -1 then
			curSeason = C_MythicPlus.GetCurrentSeason()
		end
	end
end

---@param scoreVal number - the score to get the color for
local function getScoreColor(scoreVal)
	if scoreVal < 500 then
		return "ffffff"
	elseif scoreVal < 1600 then
		return "1eff00"
	elseif scoreVal < 2080 then
		return "0070dd"
	elseif scoreVal < 2560 then
		return "a335ee"
	 elseif scoreVal < 3000 then
		return "ff8000"
	 else
		return "e6cc80"
	end
end

local function Update(self)
	local charTable = L.Utils.GetCharTable(ID)
	if not PLAYER_KEY then
		return
	end
	curScore = getScore()
	charTable[PLAYER_KEY] = charTable[PLAYER_KEY] or {}
	charTable[PLAYER_KEY].score = curScore
	charTable[PLAYER_KEY].name = PLAYER_CLASS_COLOR .. PLAYER_NAME
	charTable[PLAYER_KEY].faction = PLAYER_FACTION
	-- Keep trying to update, this seems to take a few
	tryToUpdateSeason()
	charTable[PLAYER_KEY].season = curSeason
end
-----------------------------------------------
local function GetButtonText(self, id)
	if curSeason == -1 then
		Update(self)
	end
	local AddSeparator = TitanGetVar(id, "AddSeparator")
	local scoreText = AddSeparator and BreakUpLargeNumbers(curScore) or (curScore or "0")
	local barBalanceText = ""
	if TitanGetVar(id, "ShowBarBalance") then
		local delta = (curScore - startScore)
		local deltaText = AddSeparator and BreakUpLargeNumbers(delta) or delta
		if delta > 0 then
			barBalanceText = TitanUtils_GetGreenText(" [" .. deltaText .. "]")
		elseif delta < 0 then
			-- Shouldn't ever happen, but ya know.
			barBalanceText = TitanUtils_GetRedText(" [" .. deltaText .. "]")
		end
	end
	return L.Utils.ColorText(getScoreColor(curScore), scoreText) .. barBalanceText
end

local function CreateTooltip(self)
	if curSeason == -1 then
		Update(self)
	end
	GameTooltip:ClearLines()
	GameTooltip:AddLine(L.Utils.ColorText("FF66b1ea", L["ScoreTitle"]), 1, 1, 1)

	local AddSeparator = TitanGetVar(ID, "AddSeparator")
	GameTooltip:AddLine(" ")
	local hasScore = (curScore or 0 ) > 0
	-- TODO: seasonal resets? store what season a score was for?
	if (not hasScore) then
		GameTooltip:AddLine(TitanUtils_GetRedText("Complete M+ dungeons to increase your score"))
	else
		local dif = 0
		local localScore = curScore
		local localStartScore = startScore
		if localScore and localStartScore then
			dif = localScore - localStartScore
		end
		local currentText = AddSeparator and BreakUpLargeNumbers(localScore) or localScore
		GameTooltip:AddLine(L.Utils.ColorText(getScoreColor(localScore), currentText))
		local difText = AddSeparator and BreakUpLargeNumbers(dif) or dif
		local sessionValueText = "0"
		if dif == 0 then
			sessionValueText = TitanUtils_GetHighlightText("0")
		elseif dif > 0 then
			sessionValueText = TitanUtils_GetGreenText(difText)
		else
			sessionValueText = TitanUtils_GetRedText(difText)
		end
		GameTooltip:AddDoubleLine(L["session"], sessionValueText)
	end

	if TitanGetVar(ID, "ShowAltText") then
		local charTable = L.Utils.GetCharTable(ID)
		local showAllFactions = TitanGetVar(ID, "ShowAllFactions")

		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L["AltChars"])

		local sortBy = TitanGetVar(ID, "AltTextSortByAmount") and "score"
		local sortAsc = not sortBy
		local sortedList = L.Utils.SortTableBy(charTable, sortBy, sortAsc)
		for _, p in ipairs(sortedList) do
			local k, v = p.key, p.value
			local isCurrent = k == PLAYER_KEY
			if isCurrent or ((showAllFactions or PLAYER_FACTION == v.faction) and (v.score or 0) > 0) then
				local arrow = isCurrent and "> " or ""
				local arrowEnd = isCurrent and "|r <" or ""
				local amountText = AddSeparator and BreakUpLargeNumbers(v.score) or v.score
				amountText = L.Utils.ColorText(getScoreColor(v.score), amountText)
				if v.season ~= curSeason then
					amountText = amountText .. " " .. TitanUtils_GetRedText(L["OldScore"])
				end
				GameTooltip:AddDoubleLine(arrow .. v.name .. arrowEnd, amountText)
			end
		end
	end
end
-----------------------------------------------
local eventsTable = {
	PLAYER_ENTERING_WORLD = function(self)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self.PLAYER_ENTERING_WORLD = nil

		PLAYER_NAME, PLAYER_REALM = UnitFullName("player")
		PLAYER_KEY = PLAYER_NAME .. "-" .. PLAYER_REALM
		PLAYER_FACTION = UnitFactionGroup("player")
		PLAYER_CLASS_COLOR = "|c" .. RAID_CLASS_COLORS[select(2, UnitClass("player"))].colorStr

		-- RequestMapInfo needs to be called at least once before GetCurrentSeason() returns a valid number
		if C_MythicPlus.GetCurrentSeason() == -1 then
			C_MythicPlus.RequestMapInfo()
		end
		curSeason = C_MythicPlus.GetCurrentSeason()

		Update(self)
		startScore = curScore

		self.registry.menuText = L["mOther"].." Titan" .. L.Utils.ColorText("FF66b1ea", L["ScoreTitle"]) -- Fix for Titan bug that causes colors not to appear in the menu
		TitanPanelButton_UpdateButton(self.registry.id)

		self.PLAYER_REGEN_ENABLED = function(self)
			Update(self)
			TitanPanelButton_UpdateButton(self.registry.id)
		end
		self.ZONE_CHANGED_NEW_AREA = function(self)
			Update(self)
			TitanPanelButton_UpdateButton(self.registry.id)
		end
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	end
}
-----------------------------------------------
function PrepareMenu(eddm, self, id)
	eddm.UIDropDownMenu_AddButton(L.Utils.CreateTitle(id, TitanPlugins[id].menuText));
	eddm.UIDropDownMenu_AddButton(L.Utils.CreateTitle(id, L["buttonText"]));

	eddm.UIDropDownMenu_AddButton(L.Utils.CreateToggle(id, L["showbb"], "ShowBarBalance"));

	eddm.UIDropDownMenu_AddButton({
		text = ACE["TITAN_CLOCK_MENU_DISPLAY_ON_RIGHT_SIDE"],
		func = L.Utils.ToggleRightSideDisplay,
		arg1 = id,
		checked = TitanGetVar(id, "DisplayOnRightSide"),
		keepShownOnClick = true
	});
	eddm.UIDropDownMenu_AddButton(L.Utils.CreateTitle(id, L["tooltip"]));
	eddm.UIDropDownMenu_AddButton(L.Utils.CreateToggle(id, L["showAltText"], "ShowAltText"));
	eddm.UIDropDownMenu_AddButton(L.Utils.CreateToggle(id, L["sortByAmount"], "AltTextSortByAmount"));
	eddm.UIDropDownMenu_AddButton(L.Utils.CreateToggle(id, L["addDigitSeparator"], "AddSeparator"));
	eddm.UIDropDownMenu_AddButton(L.Utils.CreateToggle(id, L["showAllFactions"], "ShowAllFactions"));
	L.Utils.AddCommonMenuItems(eddm, id);
end
-----------------------------------------------
L.Elib({
	id = ID,
	name = L["mOther"].." Titan" .. L.Utils.ColorText("FF66b1ea", L["ScoreTitle"]),
	tooltip = L["ScoreTitle"],
	icon = "Interface\\Icons\\inv_sword_48",
	category = "CATEGORY_MISC",
	customTooltip = CreateTooltip,
	version = version,
	getButtonText = GetButtonText,
	prepareMenu = PrepareMenu,
	savedVariables = {
		ShowIcon = 1,
		DisplayOnRightSide = false,
		ShowBarBalance = false,
		ShowLabelText = false,
		ShowAltText = true,
		AltTextSortByAmount = false,
		ShowAllFactions = false,
		AddSeparator= false,
		TotalBalanceBar = false
	},
	eventsTable = eventsTable
})
