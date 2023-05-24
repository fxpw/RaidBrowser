local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB


function E.GUI:ChangeTabsGlow(index)
    E.GUI.SetOriginalBackdrop(E.GUI.CollapseFrame.ShowFirstFrameTab)
    E.GUI.SetOriginalBackdrop(E.GUI.CollapseFrame.ShowSecondFrameTab)
    E.GUI.SetOriginalBackdrop(E.GUI.CollapseFrame.ShowThirdFrameTab)

    if index == 1 then
        E.GUI.SetModifiedBackdrop(E.GUI.CollapseFrame.ShowFirstFrameTab)
    elseif index == 2 then
        E.GUI.SetModifiedBackdrop(E.GUI.CollapseFrame.ShowSecondFrameTab)
    elseif index == 3 then
        E.GUI.SetModifiedBackdrop(E.GUI.CollapseFrame.ShowThirdFrameTab)
    end
end

function E.GUI:OpenTabFrameWhitIndex(index)
    E.GUI:HideAllTabsFrame()
    if index == 1 then
        E.GUI:ShowAssembleFrame();
    elseif index == 2 then
        E.GUI:ShowFindFrame();
    elseif index == 3 then
        E.GUI:ShowHistoryFrame();
    end
    E.db.LastTabIndex = index
    E.GUI:ChangeTabsGlow(index)
end

E.GUI.InfoTextOnClickFunc = function(self,click)
    if click == "RightButton" then
        -- print("не надо пока сюда кликать пкмом друже, это еще не сделанно")
        E.Core:SendLFGMsg()
    end
end

function E.GUI:CreateCollapseFrame()
    self.CollapseFrame = CreateFrame("Frame", "RB_CollapseFrame", UIParent)
    -- self.CollapseFrame.MainFrameHeight = E.db.MainFrameHeight
    -- self.CollapseFrame.FrameWidth = E.db.FrameWidth
    -- self.CollapseFrame.CollapseFrameWidth = E.db.CollapseFrameWidth

    local CollapseFrame = self.CollapseFrame
    -- CollapseFrame:CreateBackdrop("Transparent")
    E.GUI:CreateBackdrop(CollapseFrame,"Transparent")
    CollapseFrame:SetSize(E.db.CollapseFrameWidth, E.db.CollapseFrameHeight)
    CollapseFrame:SetPoint("CENTER", UIParent, "CENTER", E.db.CollapseFrameX, E.db.CollapseFrameY)
    CollapseFrame:Hide()
    CollapseFrame:SetFrameStrata("FULLSCREEN_DIALOG");
    CollapseFrame.Header = CollapseFrame:CreateFontString(nil, OVERLAY, "GameTooltipText");
    CollapseFrame.Header:SetPoint("TOP",CollapseFrame,"TOP",0,-5);
    CollapseFrame.Header:SetText(AddOnName);
    -- /dump testit:SetJustifyH(10)
    CollapseFrame.InfoText = CollapseFrame:CreateFontString(nil, OVERLAY, "GameTooltipText");
    CollapseFrame.InfoText:SetPoint("TOP",CollapseFrame,"TOP",0,-10 - self.fontHeight);
    -- CollapseFrame.InfoText:SetText(AddOnName..2);
    -- E.db.LastTabIndex = 2
    -- handler for esc
    tinsert(UISpecialFrames, CollapseFrame:GetName())

    CollapseFrame:EnableMouse(true)
    CollapseFrame:SetMovable(true)
    CollapseFrame:RegisterForDrag("LeftButton")
    CollapseFrame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    CollapseFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local frame_x,frame_y = self:GetCenter()
        E.db.CollapseFrameX = frame_x - GetScreenWidth() / 2
        E.db.CollapseFrameY = frame_y - GetScreenHeight() / 2
        self:ClearAllPoints()
        self:SetPoint("CENTER", UIParent, "CENTER", E.db.CollapseFrameX, E.db.CollapseFrameY)

        -- local boolParamForRepoint = E.db.CollapseFrameY > 0
        E.GUI:MainFrameSetNewPoint(E.db.CollapseFrameY > 0)
    end)
    CollapseFrame:SetScript("OnMouseDown", E.GUI.InfoTextOnClickFunc)
    CollapseFrame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT");
        -- GameTooltip:AddDoubleLine(L["Time"], date("%Y-%m-%d %H:%M", self.raidInfo.lastSpamTime), 1, 1, 1, 1, 1, 0)
        GameTooltip:AddLine("Для того чтобы |cff00ff00собрать рейд|r откройте настройки и нажмите |cff00ff00Начать|r в 1 вкладке", 1, 1, 1);
        GameTooltip:AddLine("Для того чтобы |cff00ff00отправить сообщение|r нажмите  |cff00ff00ПКМ|r по окну RaidBroser", 1, 1, 1);
        GameTooltip:AddLine("Если хотите |cff00ff00отправить сообщение рлу наведите мышкрой и нажмите ПКМ|r", 1, 1, 1);
        GameTooltip:Show();
    end)
    CollapseFrame:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    CollapseFrame.ShowFirstFrameTab = CreateFrame("Button",nil,E.GUI.CollapseFrame);
    local ShowFirstFrameTab = CollapseFrame.ShowFirstFrameTab
    -- ShowFirstFrameTab:CreateBackdrop("Transparent");
    E.GUI:CreateBackdrop(ShowFirstFrameTab,"Transparent")
    -- ShowFirstFrameTab:Size(self.CollapseFrame.FrameWidth,self.CollapseFrame.FrameWidth);
    E.GUI:Size(ShowFirstFrameTab, E.db.CollapseFrameHeight, E.db.CollapseFrameHeight)
    ShowFirstFrameTab:SetPoint("TOPLEFT", CollapseFrame, "TOPLEFT",0,0);
    ShowFirstFrameTab:SetScript("OnClick",function(self)
        E.GUI:OpenTabFrameWhitIndex(1)
        -- E.GUI:HideShowMainFrame()
    end);
    ShowFirstFrameTab.texture = ShowFirstFrameTab:CreateTexture()
    ShowFirstFrameTab.texture:SetAllPoints()
    ShowFirstFrameTab.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\first]])
    ShowFirstFrameTab:Show();

    ShowFirstFrameTab:HookScript("OnEnter", E.GUI.SetModifiedBackdrop);
	ShowFirstFrameTab:HookScript("OnLeave", function(self)
        E.GUI.SetOriginalBackdrop(self)
        E.GUI:ChangeTabsGlow(E.db.LastTabIndex)
    end);

    CollapseFrame.ShowSecondFrameTab = CreateFrame("Button",nil,E.GUI.CollapseFrame);
    local ShowSecondFrameTab = CollapseFrame.ShowSecondFrameTab
    -- ShowSecondFrameTab:CreateBackdrop("Transparent");
    E.GUI:CreateBackdrop(ShowSecondFrameTab,"Transparent")
    -- ShowSecondFrameTab:Size(E.db.CollapseFrameWidth,E.db.CollapseFrameWidth);
    E.GUI:Size(ShowSecondFrameTab, E.db.CollapseFrameHeight,E.db.CollapseFrameHeight)
    ShowSecondFrameTab:SetPoint("LEFT", ShowFirstFrameTab, "RIGHT",0,0);
    ShowSecondFrameTab:SetScript("OnClick",function(self)
        E.GUI:OpenTabFrameWhitIndex(2)
        -- E.GUI:HideShowMainFrame()
    end);
    ShowSecondFrameTab.texture = ShowSecondFrameTab:CreateTexture()
    ShowSecondFrameTab.texture:SetAllPoints()
    ShowSecondFrameTab.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\second]])
    ShowSecondFrameTab:Show();
    ShowSecondFrameTab:HookScript("OnEnter", E.GUI.SetModifiedBackdrop);
	ShowSecondFrameTab:HookScript("OnLeave", function(self)
        E.GUI.SetOriginalBackdrop(self)
        E.GUI:ChangeTabsGlow(E.db.LastTabIndex)
    end);

    CollapseFrame.ShowThirdFrameTab = CreateFrame("Button",nil,E.GUI.CollapseFrame);
    local ShowThirdFrameTab = CollapseFrame.ShowThirdFrameTab
    -- ShowThirdFrameTab:CreateBackdrop("Transparent");
    E.GUI:CreateBackdrop(ShowThirdFrameTab,"Transparent")
    -- ShowThirdFrameTab:Size(E.db.CollapseFrameHeight,E.db.CollapseFrameHeight);
    E.GUI:Size(ShowThirdFrameTab, E.db.CollapseFrameHeight,E.db.CollapseFrameHeight)
    ShowThirdFrameTab:SetPoint("LEFT", ShowSecondFrameTab, "RIGHT",0,0);
    ShowThirdFrameTab:SetScript("OnClick",function(self)
        E.GUI:OpenTabFrameWhitIndex(3)
        -- E.GUI:HideShowMainFrame()
    end);
    ShowThirdFrameTab.texture = ShowThirdFrameTab:CreateTexture()
    ShowThirdFrameTab.texture:SetAllPoints()
    ShowThirdFrameTab.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\segment]])
    ShowThirdFrameTab:Show();
    ShowThirdFrameTab:HookScript("OnEnter", E.GUI.SetModifiedBackdrop);
	ShowThirdFrameTab:HookScript("OnLeave", function(self)
        E.GUI.SetOriginalBackdrop(self)
        E.GUI:ChangeTabsGlow(E.db.LastTabIndex)
    end);

    CollapseFrame.CloseButton = CreateFrame("Button",nil,E.GUI.CollapseFrame);
    local CloseButton = CollapseFrame.CloseButton
    -- CloseButton:CreateBackdrop("Transparent");
    E.GUI:CreateBackdrop(CloseButton,"Transparent")
    -- CloseButton:Size(E.db.CollapseFrameHeight,E.db.CollapseFrameHeight);
    E.GUI:Size(CloseButton, E.db.CollapseFrameHeight,E.db.CollapseFrameHeight)
    CloseButton:SetPoint("TOPRIGHT", CollapseFrame, "TOPRIGHT",0,0);
    CloseButton:SetScript("OnClick",function(self) E.GUI.CollapseFrame:Hide() end);
    CloseButton.texture = CloseButton:CreateTexture()
    CloseButton.texture:SetPoint("CENTER",CloseButton,"CENTER",0,0)
    CloseButton.texture:SetSize(30,30)
    -- CloseButton.texture:SetAllPoints()
    CloseButton.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\reset]])
    CloseButton:Show();
    CloseButton:HookScript("OnEnter", E.GUI.SetModifiedBackdrop);
	CloseButton:HookScript("OnLeave", E.GUI.SetOriginalBackdrop);

    CollapseFrame.OptionsButton = CreateFrame("Button",nil, E.GUI.CollapseFrame);
    local OptionsButton = CollapseFrame.OptionsButton
    -- OptionsButton:CreateBackdrop("Transparent");
    E.GUI:CreateBackdrop(OptionsButton,"Transparent")
    -- OptionsButton:Size(E.db.CollapseFrameHeight,E.db.CollapseFrameHeight);
    E.GUI:Size(OptionsButton, E.db.CollapseFrameHeight,E.db.CollapseFrameHeight)
    OptionsButton:SetPoint("RIGHT", CloseButton, "LEFT",0,0);
    OptionsButton:SetScript("OnClick",function(self)
        if E.GUI.OptionsFrame:IsShown() then
            E.GUI:HideOptionsFrame()
        else
            E.GUI:ShowOptionsFrame()
        end
    end)
    OptionsButton:Show();
    OptionsButton.texture = OptionsButton:CreateTexture()
    OptionsButton.texture:SetAllPoints()
    OptionsButton.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\config]])
    OptionsButton:HookScript("OnEnter", E.GUI.SetModifiedBackdrop);
	OptionsButton:HookScript("OnLeave", E.GUI.SetOriginalBackdrop);

    CollapseFrame.CollapseButton = CreateFrame("Button",nil, E.GUI.CollapseFrame);
    local  CollapseButton = CollapseFrame.CollapseButton
    -- CollapseButton:CreateBackdrop("Transparent");
    E.GUI:CreateBackdrop(CollapseFrame,"Transparent")
    -- CollapseButton:Size(E.db.CollapseFrameHeight,E.db.CollapseFrameHeight);
    E.GUI:Size(CollapseButton, E.db.CollapseFrameHeight,E.db.CollapseFrameHeight)
    CollapseButton:SetPoint("RIGHT", OptionsButton, "LEFT",0,0);
    CollapseButton:SetScript("OnClick",function(self)
        E.GUI:HideShowMainFrame()
    end)
    CollapseButton:Show();
    CollapseButton.texture = CollapseButton:CreateTexture()
    CollapseButton.texture:SetAllPoints()
    CollapseButton.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\minus]])
    E.GUI:CreateBackdrop(CollapseButton,"Transparent")
    CollapseButton:HookScript("OnEnter", E.GUI.SetModifiedBackdrop);
	CollapseButton:HookScript("OnLeave", E.GUI.SetOriginalBackdrop);
end

function E.GUI:UpdateCollapseFrame()
	E.GUI:Size(self.CollapseFrame, E.db.CollapseFrameWidth, E.db.CollapseFrameHeight);
	E.GUI:Size(self.CollapseFrame.ShowFirstFrameTab, E.db.CollapseFrameHeight, E.db.CollapseFrameHeight);
	E.GUI:Size(self.CollapseFrame.ShowSecondFrameTab, E.db.CollapseFrameHeight, E.db.CollapseFrameHeight);
	E.GUI:Size(self.CollapseFrame.ShowThirdFrameTab, E.db.CollapseFrameHeight, E.db.CollapseFrameHeight);
	E.GUI:Size(self.CollapseFrame.CloseButton, E.db.CollapseFrameHeight, E.db.CollapseFrameHeight);

	E.GUI:Size(self.CollapseFrame.OptionsButton, E.db.CollapseFrameHeight, E.db.CollapseFrameHeight);
	E.GUI:Size(self.CollapseFrame.CollapseButton, E.db.CollapseFrameHeight, E.db.CollapseFrameHeight);
end

function E.GUI:UpdateInfoText(text)
    if #text > 47 then
        text = string.sub(text, 1, 44)
        text = text .. "..."
    end
    if string.find(text,"Отправить сообщение") then
        text = "|cff13ff00"..text.."|r"
    elseif string.find(text,"Отправка сообщения") then
        text = "|cffff3600"..text.."|r"
    end
    E.GUI.CollapseFrame.InfoText:SetText(text);
end

function E.GUI:HideCollapseFrame()
    E.GUI.CollapseFrame:Hide()
end

function E.GUI:ShowCollapseFrame()
    E.GUI.CollapseFrame:Show()
    E.GUI:OpenTabFrameWhitIndex(E.db.LastTabIndex)
end


function E.GUI:CollapseFrameInit()
    E.GUI:CreateCollapseFrame()
end


-- function TestUT(text)
--     E.GUI:UpdateInfoText(text)
-- end


