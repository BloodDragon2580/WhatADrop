WhatADrop = LibStub("AceAddon-3.0"):NewAddon("WhatADrop", "AceConsole-3.0", "AceEvent-3.0" );
local L = LibStub("AceLocale-3.0"):GetLocale("WhatADrop")

local lineAdded = false

local numScreen = ""

local frame = CreateFrame("Frame");
frame:RegisterEvent("ADDON_LOADED");

frame:SetScript("OnEvent",function(self,event,...)	
    if (event == "ADDON_LOADED") then		
        local addon = ...
    end
end)

function sdm_OnEnterTippedButton(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")		
	GameTooltip:AddLine("|CFFFF9900" .. L["Weekly Chest Reward"]  .."|r")
	GameTooltip:AddLine("|cff00ff00" .. self.tooltipText .."|r")
end

function sdm_OnLeaveTippedButton()
	GameTooltip_Hide()
end

function sdm_SetTooltip(self, text)
	if text then
		self.tooltipText = text
		self:SetScript("OnEnter", sdm_OnEnterTippedButton)
		self:SetScript("OnLeave", sdm_OnLeaveTippedButton)
	else
		self:SetScript("OnEnter", nil)
		self:SetScript("OnLeave", nil)
	end
end

local function OnTooltipSetItem(tooltip, ...)
	name, link = GameTooltip:GetItem()
	
	if (link == nil) then
		return
	end
	for itemLink in link:gmatch("|%x+|Hkeystone:.-|h.-|h|r") do
		local itemString = string.match(itemLink, "keystone[%-?%d:]+")
		local mlvl = select(4, strsplit(":", itemString))

		local ilvl = WhatADropItemLevel(mlvl)
		local wlvl = MythicWeeklyLootItemLevel(mlvl)
			if not lineAdded then
				tooltip:AddLine("|CFFFF9900" .. L["_"] .."|r")
				tooltip:AddLine("|CFFFF9900" .. L["Loot Item Level: "] .. ilvl .. "|r")
				tooltip:AddLine("|CFFFF9900" .. L["Weekly Chest Item Level: "] .. wlvl .."|r")
				tooltip:AddLine("|CFFFF9900" .. L["_"] .."|r")
				lineAdded = true
			end
	end
end
 
local function OnTooltipCleared(tooltip, ...)
   lineAdded = false
end

local function SetHyperlink_Hook(self,hyperlink,text,button)		
	local itemString = string.match(hyperlink, "keystone[%-?%d:]+")
	if itemString == nil or itemString == "" then return end
	if strsplit(":", itemString) == "keystone" then
		local mlvl = select(4, strsplit(":", hyperlink))

		local ilvl = WhatADropItemLevel(mlvl)
		local wlvl = MythicWeeklyLootItemLevel(mlvl)
			ItemRefTooltip:AddLine("|CFFFF9900" .. L["_"] .."|r", 1,1,1,true)
			ItemRefTooltip:AddLine("|CFFFF9900" .. L["Loot Item Level: "] .. ilvl .. "+" .. "|r", 1,1,1,true)
			ItemRefTooltip:AddLine("|CFFFF9900" .. L["Weekly Chest Item Level: "] .. wlvl .."|r", 1,1,1,true)
			ItemRefTooltip:AddLine("|CFFFF9900" .. L["_"] .."|r", 1,1,1,true)
			ItemRefTooltip:Show()
	end
end
 
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
GameTooltip:HookScript("OnTooltipCleared", OnTooltipCleared)

-- TWW / 11.2.7+: ChatFrame_OnHyperlinkShow ist nicht mehr global eine Funktion.
-- Ältere Clients: falls sie existiert, wie bisher hooken.
if type(ChatFrame_OnHyperlinkShow) == "function" then
    -- Für ältere Versionen / andere Clients
    hooksecurefunc("ChatFrame_OnHyperlinkShow", SetHyperlink_Hook)
else
    -- Retail 11.2.7+: stattdessen SetItemRef hooken, das bei Chat-Links aufgerufen wird
    hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
        -- Wir mappen die Argumente so, wie SetHyperlink_Hook sie erwartet:
        -- (self, hyperlink, text, button)
        SetHyperlink_Hook(chatFrame, link, text, button)
    end)
end

function WhatADropItemLevel(mlvl)
    mlvl = tonumber(mlvl)
    if not mlvl then return "" end

    if mlvl == 0 then
        return "246"
    elseif mlvl == 2 or mlvl == 3 then
        return "250"
    elseif mlvl == 4 or mlvl == 5 then
        return "256"
    elseif mlvl == 6 or mlvl == 7 then
        return "259"
    elseif mlvl == 8 or mlvl == 9 then
        return "263"
    elseif mlvl == 10 or mlvl == 11 then
        return "266"
    elseif mlvl >= 12 and mlvl <= 14 then
        return "269"
    elseif mlvl >= 15 and mlvl <= 17 then
        return "272"
    elseif mlvl >= 18 then
        return "276"
    else
        return ""
    end
end

function MythicWeeklyLootItemLevel(mlvl)
    mlvl = tonumber(mlvl)
    if not mlvl then return "" end

    if mlvl == 2 or mlvl == 3 then
        return "259"
    elseif mlvl == 4 or mlvl == 5 then
        return "263"
    elseif mlvl == 6 or mlvl == 7 then
        return "269"
    elseif mlvl == 8 or mlvl == 9 then
        return "269"
    elseif mlvl == 10 or mlvl == 11 then
        return "272"
    elseif mlvl >= 12 and mlvl <= 14 then
        return "276"
    elseif mlvl >= 15 and mlvl <= 17 then
        return "279"
    elseif mlvl >= 18 then
        return "282"
    else
        return ""
    end
end

function WhatADrop:OnInitialize()
		self:Print(L["WhatADrop: Loaded"])
end

function WhatADrop:OnEnable()		
		self:Print(L["WhatADrop: Enabled"])
end

function WhatADrop:OnDisable()
		self:Print(L["WhatADrop: Disabled"])
end