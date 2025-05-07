local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

E.GUI.SetModifiedBackdrop = function(frame)
	if frame.backdrop then
		local class = select(2, UnitClass("player"))
		frame.backdrop:SetBackdropBorderColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g,
			RAID_CLASS_COLORS[class].b)
	end
end
E.GUI.SetOriginalBackdrop = function(frame)
	if frame.backdrop then
		frame.backdrop:SetBackdropBorderColor(0, 0, 0, 1)
	end
end

local resolution = GetCVar("gxResolution")
local _, screenheight = tonumber(string.match(resolution, "(%d+)x+%d")), tonumber(string.match(resolution, "%d+x(%d+)"))

local pixel, ratio = 1, 768 / screenheight
local mult = (pixel / UIParent:GetScale()) - ((pixel - ratio) / UIParent:GetScale())

function E.GUI:Scale(x)
	-- local mult = E.mult
	return mult * floor(x / mult + 0.5)
end

function E.GUI:Size(frame, width, height)
	frame:SetSize(E.GUI:Scale(width), E.GUI:Scale(height or width))
end

function E.GUI:CreateBackdrop(frame, template)
	if ElvUI then
		frame:CreateBackdrop(template)
		return
	end
	-- if not template then template = "Default" end

	local parent = (frame.IsObjectType and frame:IsObjectType("Texture") and frame:GetParent()) or frame
	local backdrop = frame.backdrop or CreateFrame("Frame", nil, parent)
	if not frame.backdrop then frame.backdrop = backdrop end

	-- if frame.forcePixelMode or forcePixelMode then
	-- 	backdrop:SetOutside(frame, E.mult, E.mult)
	-- else
	backdrop:SetAllPoints()
	backdrop:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Buttons/WHITE8X8",
		edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult },
	})
	backdrop:SetBackdropColor(0, 0, 0, .5)
	backdrop:SetBackdropBorderColor(0, 0, 0, .5)
	-- end

	-- backdrop:SetTemplate(template, glossTex, ignoreUpdates, forcePixelMode, isUnitFrameElement)

	local frameLevel = parent.GetFrameLevel and parent:GetFrameLevel()
	local frameLevelMinusOne = frameLevel and (frameLevel - 1)
	if frameLevelMinusOne and (frameLevelMinusOne >= 0) then
		backdrop:SetFrameLevel(frameLevelMinusOne)
	else
		backdrop:SetFrameLevel(0)
	end
end

function E.GUI:CreateSortButton(parent, name, tableForSort, paramName, pointner, needFS, needTexture)
	parent[name] = CreateFrame("Button", nil, parent);
	local frame = parent[name];

	-- frame:Size(2 * self.recordHeight,  self.recordHeight);
	E.GUI:Size(frame, 2 * self.recordHeight, self.recordHeight)
	frame:SetPoint(unpack(pointner));
	-- frame:CreateBackdrop();
	E.GUI:CreateBackdrop(frame)
	if needFS then
		frame.fs = frame:CreateFontString(nil, OVERLAY, "GameTooltipText");
		frame.fs:SetPoint("CENTER", frame, "CENTER", 0, 0);
		frame.fs:SetText(L[name]);
	elseif needTexture then
		frame.texture = frame:CreateTexture();
		frame.texture:SetSize(2 * self.recordHeight, self.recordHeight);
		frame.texture:SetAllPoints();
		-- frame.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\tank]]);
	end
	frame:RegisterForClicks("AnyUp");
	frame.lastSort = false
	frame.tableForSort = tableForSort
	frame.paramName = paramName
	frame:SetScript("OnClick", function(self)
		table.sort(self.tableForSort, function(a, b)
			if a and b and a[self.paramName] and b[self.paramName] then
				if self.lastSort then
					return (a[self.paramName] > b[self.paramName]);
				end
				return a[self.paramName] < b[self.paramName];
			end
			return true;
		end);
		E.GUI:FindFrameRaidInfoUpdate();
		E.GUI:AssembleFrameInfoUpdate();
		self.lastSort = not self.lastSort
	end)
	frame:HookScript("OnEnter", E.GUI.SetModifiedBackdrop);
	frame:HookScript("OnLeave", E.GUI.SetOriginalBackdrop);
	return frame
end

function E.GUI:HookScrollBar(scrollbar)
	if(scrollbar and ElvUI) then
		local Elv = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
		local SElv = Elv:GetModule("Skins")
		SElv:HandleScrollBar(scrollbar)

		local border = _G[scrollbar:GetName().."Border"]
		if border then
			border:Hide()
		end
	end
end

function E.GUI:OptionsFrameInit()
	E.Libs.AceConfig:RegisterOptionsTable("RaidBrowser", E.GUI.Options);
	E.Libs.AceConfigDialog:SetDefaultSize("RaidBrowser", E.Core:GetConfigDefaultSize());
	E.Libs.AceConfigDialog["Open"](E.Libs.AceConfigDialog, AddOnName)
	-- if mode == "Open" then
	local ConfigOpen = E.Libs.AceConfigDialog and E.Libs.AceConfigDialog.OpenFrames and
		E.Libs.AceConfigDialog.OpenFrames[AddOnName]
	if ConfigOpen then
		local frame = ConfigOpen.frame
		if frame and not E.GUI.OptionsFrame then
			E.GUI.OptionsFrame = frame
			_G.RBOF = E.GUI.OptionsFrame
		end
	end
	E.GUI.OptionsFrame.obj.status.top, E.GUI.OptionsFrame.obj.status.left = 700, 600
	E.Libs.AceConfigDialog["Close"](E.Libs.AceConfigDialog, AddOnName)
end

function E.GUI:HideAllTabsFrame()
	E.GUI:HideAssembleFrame();
	E.GUI:HideFindFrame();
	E.GUI:HideHistoryFrame();
end

function E.GUI:OpenMainFrame()
	E.GUI.MainFrame:Show();
	E.GUI:OpenFrameWhitIndex(E.db.LastTabIndex)
	-- E.GUI.MainFrame.FindFrame:Show();
end

function E.GUI:UpdateFrameConstants()
	self.font = "ChatFontSmall";
	self.fontHeight = select(2, getglobal(self.font):GetFont());
	self.recordHeight = self.fontHeight + 15;
	self.recordWidth = E.db.MainFrameHeight - 30
end

function E.GUI:UpdateAllFramesSize()
	E.GUI:UpdateFrameConstants();
	E.GUI:UpdateCollapseFrame();
	E.GUI:UpdateMainFrame();
	E.GUI:UpdateAssembleFrame();
	E.GUI:UpdateFindFrame();
	-- MainFrame:SetSize(self.CollapseFrame.MainFrameHeight,self.CollapseFrame.CollapseFrameWidth);
end

function E.GUI:PrintHelp()
	E.Core:Print(L["Use /rb"])
	E.Core:Print(L["Use /rb minimap"])
	E.Core:Print(L["Use /rb help"])
end

function E.GUI:ShowOptionsFrame()
	E.Libs.AceConfigDialog["Open"](E.Libs.AceConfigDialog, AddOnName)
end

function E.GUI:HideOptionsFrame()
	E.Libs.AceConfigDialog["Close"](E.Libs.AceConfigDialog, AddOnName)
end

function E.GUI:Init()
	-- self:CreateMainFrame()
	self:UpdateFrameConstants();
	self:CollapseFrameInit();
	self:MainFrameInit();
	self:FirstTabInit();
	self:SecondTabInit();
	self:ThirdTabInit();
	self:OptionsFrameInit();
	-- SlashCmdList["RAIDBROWSER"] = E.GUI.ShowCollapseFrame
	function SlashCmdList.RAIDBROWSER(input)
		local msg = nil
		input = input or ""
		for v in string.gmatch(input, "%S+") do
			if not msg then
				msg = v
			end
		end
		if msg == "help" then
			E.GUI:PrintHelp()
		elseif msg == "minimap" then
			E.GUI:ToggleMinimapIcon()
		elseif msg ~= nil then
			E.Core:Print(L["UnknownCommand"])
		else
			E.GUI:ShowCollapseFrame()
		end
	end

	LFRParentFrame:HookScript("OnShow", function(self)
		ToggleFrame(self)
		E.GUI:ShowCollapseFrame()
	end)
end