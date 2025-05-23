--[[
	Description: This plugin is part of the "Titan Panel [Currencies] Multi" addon.
	Site: https://www.curseforge.com/wow/addons/titan-panel-currencies-multi
	Author: Canettieri
	Special Thanks to Eliote.
--]]

local _, L = ...;
local ACE = LibStub("AceLocale-3.0"):GetLocale(TITAN_ID, true)
L.Elib = LibStub("Elib-4.0").Register

function L.PrepareCurrenciesMenuBase(eddm, self, id, hasMax, isWarband)

	eddm.UIDropDownMenu_AddButton(L.Utils.CreateTitle(id, TitanPlugins[id].menuText));
	eddm.UIDropDownMenu_AddButton(L.Utils.CreateTitle(id, L["buttonText"]));

	eddm.UIDropDownMenu_AddButton(L.Utils.CreateToggle(id, L["showbb"], "ShowBarBalance"));

	if (hasMax) then
		eddm.UIDropDownMenu_AddButton(L.Utils.CreateToggle(id, L["maxBar"], "MaxBar"));
	end

	if (isWarband) then
		eddm.UIDropDownMenu_AddButton(L.Utils.CreateToggle(id, L["showWarbandTotal"], "TotalBalanceBar"));
	end

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
	eddm.UIDropDownMenu_AddButton(L.Utils.CreateToggle(id, L["useHyperlink"], "UseHyperlink"));
	eddm.UIDropDownMenu_AddButton(L.Utils.CreateToggle(id, L["hideInfoWhenHyperlink"], "HideInfoWhenHyperlink"));

	L.Utils.AddCommonMenuItems(eddm, id);
end

function L.PrepareCurrenciesMenu(eddm, self, id)
	return L.PrepareCurrenciesMenuBase(eddm, self, id, false, false)
end

-- Warbound currency without a max
function L.PrepareCurrenciesMenuWarband(eddm, self, id)
	return L.PrepareCurrenciesMenuBase(eddm, self, id, false, true)
end

-- Warbound currency with a max
function L.PrepareCurrenciesMenuWarbandMax(eddm, self, id)
	return L.PrepareCurrenciesMenuBase(eddm, self, id, true, true)
end

function L.DefaultCurrencyClickHandler(self, button)
	if (button == "LeftButton") then
		ToggleCharacter("TokenFrame");
	end
end
