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
hooksecurefunc("ChatFrame_OnHyperlinkShow",SetHyperlink_Hook)

function WhatADropItemLevel(mlvl)
    if (mlvl == "2") then
        return "402"
    elseif (mlvl == "3") then
        return "405"
    elseif (mlvl == "4") then
        return "405"
    elseif (mlvl == "5") then
        return "408"
    elseif (mlvl == "6") then
        return "408"
    elseif (mlvl == "7") then
        return "411"
    elseif (mlvl == "8") then
        return "411"
    elseif (mlvl == "9") then
        return "415"
    elseif (mlvl == "10") then
        return "415"
    elseif (mlvl == "11") then
        return "418"
    elseif (mlvl == "12") then
        return "418"
    elseif (mlvl == "13") then
        return "421"
    elseif (mlvl == "14") then
        return "421"
    elseif (mlvl >= "15") then
        return "424"
    elseif (mlvl >= "16") then
        return "424"
    elseif (mlvl >= "17") then
        return "428"
    elseif (mlvl >= "18") then
        return "428"
    elseif (mlvl >= "19") then
        return "431"
    elseif (mlvl >= "20") then
        return "431"
    else
        return ""
    end
end

function MythicWeeklyLootItemLevel(mlvl)
    if (mlvl == "2") then
        return "415"
    elseif (mlvl == "3") then
        return "418"
    elseif (mlvl == "4") then
        return "421"
    elseif (mlvl == "5") then
        return "421"
    elseif (mlvl == "6") then
        return "424"
    elseif (mlvl == "7") then
        return "424"
    elseif (mlvl == "8") then
        return "428"
    elseif (mlvl == "9") then
        return "428"
    elseif (mlvl == "10") then
        return "431"
    elseif (mlvl == "11") then
        return "431"
    elseif (mlvl == "12") then
        return "434"
    elseif (mlvl == "13") then
        return "434"
    elseif (mlvl == "14") then
        return "437"
    elseif (mlvl >= "15") then
        return "437"
    elseif (mlvl == "16") then
        return "441"
    elseif (mlvl == "17") then
        return "441"
    elseif (mlvl == "18") then
        return "444"
    elseif (mlvl == "19") then
        return "444"
    elseif (mlvl >= "20") then
        return "447"
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