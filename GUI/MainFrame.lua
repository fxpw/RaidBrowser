local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB



function E.GUI:CreateMainFrame()
	E.GUI.CollapseFrame.MainFrame = CreateFrame("Frame", nil, E.GUI.CollapseFrame);
	-- E.GUI.FindFrame = CreateFrame("Frame", nil, E.GUI.OptionsFrame);
	local MainFrame = E.GUI.CollapseFrame.MainFrame;
	-- MainFrame:CreateBackdrop("Transparent");
	E.GUI:CreateBackdrop(MainFrame, "Transparent");
	MainFrame:SetPoint("TOP", E.GUI.CollapseFrame, "BOTTOM", 0, 0);
	-- local w,h = self.OptionsFrame:GetSize();
	MainFrame:SetSize(E.db.CollapseFrameWidth, E.db.MainFrameHeight);
	-- MainFrame:Hide();
	MainFrame:SetFrameStrata("FULLSCREEN_DIALOG");
	-- E.GUI:HideShowMainFrame()
end

function E.GUI:UpdateMainFrame()
	E.GUI:Size(self.CollapseFrame.MainFrame, E.db.CollapseFrameWidth, E.db.MainFrameHeight);
end

function E.GUI:HideShowMainFrame()
	if E.db.IsMainFrameShown then
		E.GUI:HideMainFrame();
		E.db.IsMainFrameShown = false;
	else
		E.GUI:ShowMainFrame();
		E.db.IsMainFrameShown = true;
	end
end

function E.GUI:HideMainFrame()
	E.GUI.CollapseFrame.MainFrame:Hide();
	E.GUI:HideAllTabsFrame();
end

function E.GUI:ShowMainFrame()
	E.GUI.CollapseFrame.MainFrame:Show();
	E.GUI:OpenTabFrameWhitIndex(E.db.LastTabIndex);
	E.GUI:MainFrameSetNewPoint(E.db.CollapseFrameY > 0);
end

function E.GUI:MainFrameSetNewPoint(boolParam)
	E.GUI.CollapseFrame.MainFrame:ClearAllPoints();
	if boolParam then
		E.GUI.CollapseFrame.MainFrame:SetPoint("TOP", E.GUI.CollapseFrame, "BOTTOM", 0, 0);
	else
		E.GUI.CollapseFrame.MainFrame:SetPoint("BOTTOM", E.GUI.CollapseFrame, "TOP", 0, 0);
	end
end

function E.GUI:MainFrameInit()
	E.GUI:CreateMainFrame();
end