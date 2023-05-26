local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local LDBIcon = E.Libs.LDBI
local LDB = E.Libs.LDB

local colorFrame = CreateFrame("Frame");
-- WeakAuras.frames["LDB Icon Recoloring"] = colorFrame;

local texElapsed = 0;
-- local texDelay = E.db.DelayForAnimatedMinimapIcon;
local RBMinimapIcon
local tooltip_update_frame = CreateFrame("FRAME");
-- function copied from LibDBIcon-1.0.lua
local registered = false

local Broker_RB;

local indexRow = 0
local indexCell = 0
local scale = 0.0625
colorFrame:SetScript("OnUpdate", function(self, elaps)
	texElapsed = texElapsed + elaps;
	if(texElapsed > E.db.DelayForAnimatedMinimapIcon) then
		texElapsed = texElapsed - E.db.DelayForAnimatedMinimapIcon;
		indexCell = indexCell + 1
		if indexCell > 15 then
			indexCell = 0
			indexRow = indexRow + 1
			if indexRow > 3 then
				indexRow = 0
			end
		end
		Broker_RB.iconCoords = {
			indexCell*scale,
			(indexCell+1)*scale,
			indexRow*2*scale,
			((indexRow+1)*2)*scale
		}
		if RBMinimapIcon and RBMinimapIcon.icon then
			RBMinimapIcon.icon:UpdateCoord()
		end
	end
	---left right top bottom

end);

local function getAnchors(frame)
	local x, y = frame:GetCenter()
	if not x or not y then return "CENTER" end
	local hHalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
	local vHalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vHalf..hHalf, frame, (vHalf == "TOP" and "BOTTOM" or "TOP")..hHalf
end


local function tooltip_draw()
	local tooltip = GameTooltip;
	tooltip:ClearLines();
	tooltip:AddDoubleLine(AddOnName, GetAddOnMetadata(AddOnName, "Version"));

	tooltip:AddLine(" ");
	tooltip:AddLine(L["|cffeda55fLeft-Click|rShowCollapseFrame"], 0.2, 1, 0.2);

	tooltip:Show();
  end



function E.GUI:InitMinimapIcon()
	-- E.db.minimap = E.db.minimap or { hide = false };
	if not registered then
		Broker_RB = LDB:NewDataObject(AddOnName, {
			type = "launcher",
			text = AddOnName,
			icon = "Interface\\AddOns\\RaidBrowser\\Media\\test1.tga",
			OnClick = function(self, button)
				if button == 'LeftButton' then
					E.GUI:ShowCollapseFrame()
				end

			end,
			OnEnter = function(self)

				local elapsed = 0;
				local delay = 1;
				tooltip_update_frame:SetScript("OnUpdate", function(self, elap)
				  elapsed = elapsed + elap;
				  if(elapsed > delay) then
					elapsed = 0;
					tooltip_draw();
				  end
				end);
				GameTooltip:SetOwner(self, "ANCHOR_NONE");
				GameTooltip:SetPoint(getAnchors(self))
				tooltip_draw();
			  end,
			OnLeave = function(self)
				tooltip_update_frame:SetScript("OnUpdate", nil);
				GameTooltip:Hide();
			end,

			iconR = 1,
			iconG = 1,
			iconB = 1
		  });
		LDBIcon:Register(AddOnName, Broker_RB, E.db.minimap);
		registered = true
		RBMinimapIcon = LDBIcon:GetMinimapButton(AddOnName)
	end
end


function E.GUI:ToggleMinimapIcon()
	E.db.minimap.hide = not E.db.minimap.hide
	if E.db.minimap.hide then
		LDBIcon:Hide(AddOnName);
		E.Core:Print(L["Use /rb minimap"])
	else
		LDBIcon:Show(AddOnName);
	end
end