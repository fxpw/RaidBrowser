local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local LDBIcon = E.Libs.LDBI
local LDB = E.Libs.LDB

local colorFrame = CreateFrame("Frame");
-- WeakAuras.frames["LDB Icon Recoloring"] = colorFrame;

local texElapsed = 0;
-- local texDelay = E.db.DelayForAnimatedMinimapIcon;
local RBMinimapIcon

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

			iconR = 1,
			iconG = 1,
			iconB = 1
		  });
		LDBIcon:Register(AddOnName, Broker_RB, E.db.minimap);
		registered = true
		RBMinimapIcon = LDBIcon:GetMinimapButton(AddOnName)
	end
end