local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local GUI = E.GUI
local Core = E.Core

E.GUI.Options.args.ThirdTab = {
    order = 4,
	type = "group",
	name = L["History Raid Tab"],
	childGroups = "tree",
	get = function(info) return E.db[info[#info]] end,
	set = function(info, value) E.db[info[#info]] = value end,
    args = {
		-- intro = {
		-- 	order = 1,
		-- 	type = "description",
		-- 	name = L["History raid opt desc"]
		-- },
    }
}

function E.GUI:ShowHistoryFrame()
    E.GUI.CollapseFrame.MainFrame.HistoryFrame:Show();
end

function E.GUI:HideHistoryFrame()
    E.GUI.CollapseFrame.MainFrame.HistoryFrame:Hide();
end

function E.GUI:CreateHistoryFrame()
    -- E.GUI.CollapseFrame.MainFrame.CollectFrame = CreateFrame()
    E.GUI.CollapseFrame.MainFrame.HistoryFrame = CreateFrame("Frame", nil, E.GUI.CollapseFrame.MainFrame);
    local HistoryFrame = E.GUI.CollapseFrame.MainFrame.HistoryFrame;
    -- HistoryFrame:CreateBackdrop("Transparent");
    E.GUI:CreateBackdrop(HistoryFrame,"Transparent")

    HistoryFrame:SetAllPoints();
    -- local w,h = E.GUI.CollapseFrame.MainFrame:GetSize();
    -- HistoryFrame:SetSize(w,h-E.GUI.CollapseFrame.FrameWidth);
    HistoryFrame:Hide();
    HistoryFrame:SetScript("OnShow",function(self)
        -- GUI:FindFrameRaidInfoUpdate()
    end)


	E.GUI.CollapseFrame.MainFrame.HistoryFrame.ScrollParent = CreateFrame("Frame", "RBScrollParent", HistoryFrame);
    local ScrollParent = E.GUI.CollapseFrame.MainFrame.HistoryFrame.ScrollParent
    ScrollParent:SetPoint("TOPLEFT", HistoryFrame ,"TOPLEFT", 0, -E.GUI.CollapseFrame.FrameWidth)
    ScrollParent:SetPoint("BOTTOMRIGHT", HistoryFrame ,"BOTTOMRIGHT", 0, 0)
    E.GUI.CollapseFrame.MainFrame.HistoryFrame.ScrollParent.Records = {};
end

function E.GUI:ThirdTabInit()
	E.GUI:CreateHistoryFrame();
end