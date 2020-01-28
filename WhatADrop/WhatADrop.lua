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

-- Tooltip functions
function sdm_OnEnterTippedButton(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		
	GameTooltip:AddLine("|cffff00ff" .. L["Weekly Chest Reward"]  .."|r")
	GameTooltip:AddLine("|cff00ff00" .. self.tooltipText .."|r")
	GameTooltip:Show()
end

function sdm_OnLeaveTippedButton()
	GameTooltip_Hide()
end

-- if text is provided, sets up the button to show a tooltip when moused over. Otherwise, removes the tooltip.
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
				tooltip:AddLine("|cffff00ff" .. L["Loot Item Level: "] .. ilvl .. "+" .. "|r") --551A8B   --ff00ff 
				tooltip:AddLine("|cffff00ff" .. L["Weekly Chest Item Level: "] .. wlvl .."|r") --551A8B   --ff00ff
				lineAdded = true
			end
	end
end
 
local function OnTooltipCleared(tooltip, ...)
   lineAdded = false
end

-- ITEM REF Tooltip
local function SetHyperlink_Hook(self,hyperlink,text,button)		
	local itemString = string.match(hyperlink, "keystone[%-?%d:]+")
	if itemString == nil or itemString == "" then return end
	if strsplit(":", itemString) == "keystone" then
		local mlvl = select(4, strsplit(":", hyperlink))

		local ilvl = WhatADropItemLevel(mlvl)
		local wlvl = MythicWeeklyLootItemLevel(mlvl)
			
									   
															
  			
			ItemRefTooltip:AddLine("|cffff00ff" .. L["Loot Item Level: "] .. ilvl .. "+" .. "|r", 1,1,1,true) --551A8B   --ff00ff 
			ItemRefTooltip:AddLine("|cffff00ff" .. L["Weekly Chest Item Level: "] .. wlvl .."|r", 1,1,1,true) --551A8B   --ff00ff 
			ItemRefTooltip:Show()
	end
end
 
GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
GameTooltip:HookScript("OnTooltipCleared", OnTooltipCleared)
hooksecurefunc("ChatFrame_OnHyperlinkShow",SetHyperlink_Hook)

function WhatADropItemLevel(mlvl)
 if (mlvl == "2" or mlvl == "3") then
  return "435"
 elseif (mlvl == "4") then
  return "440"
 elseif (mlvl == "5" or mlvl == "6") then
  return "445"
 elseif (mlvl == "7" or mlvl == "8" or mlvl == "9") then
  return "450"
 elseif (mlvl == "10" or mlvl == "11") then
  return "455"
 elseif (mlvl == "12" or mlvl == "13" or mlvl == "14") then
  return "460"
 elseif (mlvl >= "15") then
  return "465"
 else
  return ""
 end
end

 

function MythicWeeklyLootItemLevel(mlvl)
 if (mlvl == "2") then
  return "440"
 elseif (mlvl == "3") then
  return "445"
 elseif (mlvl == "4" or mlvl == "5") then
  return "450"
 elseif (mlvl == "6") then
  return "455"
 elseif (mlvl == "7" or mlvl == "8" or mlvl == "9") then
  return "460" 
 elseif (mlvl == "10" or mlvl == "11") then
  return "465"
 elseif (mlvl == "12" or mlvl == "13" or mlvl == "14") then
  return "470"
 elseif (mlvl >= "15") then
  return "475"
 else
  return ""
 end
end


function WhatADrop:OnInitialize()
		-- Called when the addon is loaded

		-- Print a message to the chat frame
		self:Print(L["WhatADrop: Loaded"])
end

function WhatADrop:OnEnable()
		-- Called when the addon is enabled

		-- Print a message to the chat frame		
		self:Print(L["WhatADrop: Enabled"])
end

function WhatADrop:OnDisable()
		-- Called when the addon is disabled
		self:Print(L["WhatADrop: Disabled"])
end