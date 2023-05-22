---@diagnostic disable: undefined-field
local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

E.GUI.Options.args.SecondTab = {
    order = 3,
	type = "group",
	name = L["Find Raid Tab"],
	childGroups = "tree",
	get = function(info) return E.db[info[#info]] end,
	set = function(info, value) E.db[info[#info]] = value end,
    args = {
		-- intro = {
		-- 	order = 1,
		-- 	type = "description",
		-- 	name = L["find raid opt desc"]
		-- },
        -- intro1 = {
		-- 	order = 3,
		-- 	type = "header",
        --     width = "full",
		-- 	name = L["find raid opt desc"]
		-- },
        TimeToClearRaids = {
            order = 4,
            type = "range",
            min = 35, max = 180, step = 1,
            name = L["TimeToClearRaids"],
            desc = L["TimeToClearRaidsdesc"],
		},
    }
}

local menuList = {
    {
		text = L["SendMSGToRL(current)"],
		notCheckable = 1,
		func = function(self, arg1, arg2)
            -- SendChatMessage("RB!: Хочу в рейд, я ".. arg2.ilvl.. " " .. arg2.playerClassName  .." " .. arg2.currentSpecName, "WHISPER", nil, arg1.rlName);
            E.Core:SendRequestAddToRaid(arg1.rlName)
		end
	},
}

local factionToTexture ={
    ["Alliance"]= [[Interface\AddOns\RaidBrowser\Media\Textures\all]],
    ["Horde"]= [[Interface\AddOns\RaidBrowser\Media\Textures\hor]],
    ["Renegade"]= [[Interface\AddOns\RaidBrowser\Media\Textures\ren]],
}

function E.GUI:FindFrameRaidInfoUpdate()
    if not E.GUI.CollapseFrame.MainFrame.FindFrame:IsVisible() then
        return
    end
    local offset = FauxScrollFrame_GetOffset(E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent.ScrollBar)
    local numRecords = #E.Core.raidsTable
    local numDisplayedRecords = math.min(E.GUI.numLogRecordFrames, numRecords - offset)
    local record
    for i=1, E.GUI.numLogRecordFrames do
        record = E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent.Records[i]
        local logIndex = i + offset - 1
        local logTableRecord = E.Core.raidsTable[#E.Core.raidsTable-logIndex]
        if logIndex < numRecords then
            record:UpdateRaidInfo(logTableRecord);
            record:Show();
        else
            record:Hide();
        end
    end
    FauxScrollFrame_Update(E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent.ScrollBar, numRecords, numDisplayedRecords,  E.GUI.recordHeight)
end




function  E.GUI:CreateFindFrameRecord(i)
    E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent.Records[i] = CreateFrame("Button", nil, E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent);
    local record = E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent.Records[i]
    record.raidInfo = {
       tank =  true,
       ilvl =  math.random(1,300),
       raidName =  "Охота",
       rlLang =  "всеобщий",
       message =  "safgagas",
       difficulty =  4,
       heal =  true,
       lastSpamTime =  time(),
       dd =  true,
       instanceName =  {{"Логово Магтеридона", 2}, {"Испытание крестоносца", 2}},
       rlName =  "Шутка",
       patterns = {},
       size =  25,
    };
    record:SetHeight(self.recordHeight);
    record:SetWidth(self.recordWidth);
    record.raidName = record:CreateFontString(nil, OVERLAY, "GameTooltipText");
    record.raidName:SetPoint("LEFT",record,"LEFT",0,0);
    record.raidName:SetText(record.raidInfo.raidName);

    record.rlName = record:CreateFontString(nil, OVERLAY, "GameTooltipText");
    record.rlName:SetPoint("LEFT",record,"LEFT",120,0);
    record.rlName:SetText(record.raidInfo.rlName);

    record.ilvl = record:CreateFontString(nil, OVERLAY, "GameTooltipText");
    record.ilvl:SetPoint("RIGHT",record,"RIGHT",0,0);
    record.ilvl:SetText(record.raidInfo.ilvl);

    record.factionTexture = record:CreateTexture();
    record.factionTexture:SetSize(self.recordHeight,self.recordHeight);
    record.factionTexture:SetPoint("TOPLEFT", record ,"TOPLEFT", 10*self.recordHeight, 0);
    record.factionTexture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\all]]);


    record.ddTexture = record:CreateTexture();
    record.ddTexture:SetSize(self.recordHeight,self.recordHeight);
    record.ddTexture:SetPoint("TOPLEFT", record ,"TOPLEFT", 12*self.recordHeight, 0);
    record.ddTexture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\dps]]);

    record.hTexture = record:CreateTexture();
    record.hTexture:SetSize(self.recordHeight,self.recordHeight);
    record.hTexture:SetPoint("TOPLEFT", record ,"TOPLEFT", 13*self.recordHeight, 0);
    record.hTexture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\healer]]);

    record.tTexture = record:CreateTexture();
    record.tTexture:SetSize(self.recordHeight,self.recordHeight);
    record.tTexture:SetPoint("TOPLEFT", record ,"TOPLEFT", 14*self.recordHeight, 0);
    record.tTexture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\tank]]);

    if i == 1 then
        record:SetPoint("TOPLEFT", E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent, "TOPLEFT", 5, -3);
    else
        record:SetPoint("TOPLEFT", E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent.Records[i-1], "BOTTOMLEFT");
    end
    record:Show();

    record:RegisterForClicks("AnyUp");
    record:SetScript("OnClick", function(self, click)
        local position = self:GetPoint()
        -- E.GUI.CollapseFrame.MainFrame.FindFrame.MenuFrame.rlName = self.raidInfo.rlName
        menuList[1].arg1 = self.raidInfo;
        menuList[1].arg2 = E.Core:GetPlayerInfo();
        for q = 1,menuList[1].arg2.maxSpecs do
            menuList[q+1]={
                text = L["SendMSGToRL(spec"..q..")"],
                notCheckable = 1,
                func = function()
                    SendChatMessage("RB!: Хочу в рейд, я " ..menuList[1].arg2.playerClassName  .. " " .. E.Core:GetSpecNameFromTalents(q), "WHISPER", nil, menuList[1].arg1.rlName);
                    E.Core:SendRequestAddToRaid( menuList[1].arg1.rlName)
                end
            }
        end
        if position:match("LEFT") then
            EasyMenu(menuList, E.GUI.CollapseFrame.MainFrame.FindFrame.MenuFrame, "cursor", 0, 0, "MENU", 2)
        else
            EasyMenu(menuList, E.GUI.CollapseFrame.MainFrame.FindFrame.MenuFrame, "cursor", -160, 0, "MENU", 2)
        end
    end)
    record:SetScript("OnEnter",function(self)
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
        -- GameTooltip:SetPoint("LEFT",self,"RIGHT")
        for _,v in pairs(self.raidInfo.instanceName) do
            if E.Core:IsRaidInCD(v[1], self.raidInfo.size, v[2]) then
                GameTooltip:AddDoubleLine(v[1], "есть кд", 1, 0, 0, 1, 0, 0)
            else
                GameTooltip:AddDoubleLine(v[1], "нет кд", 0, 1, 0, 0, 1, 0)
            end
        end
        GameTooltip:AddLine(" ", 1, 1, 1)
        GameTooltip:AddDoubleLine(L["Sender"], self.raidInfo.rlName, 1, 1, 1, 1, 1, 0)
        GameTooltip:AddDoubleLine(L["Raid"], self.raidInfo.raidName, 1, 1, 1, 1, 1, 0)
        GameTooltip:AddDoubleLine(L["Time"], date("%Y-%m-%d %H:%M", self.raidInfo.lastSpamTime), 1, 1, 1, 1, 1, 0)
        GameTooltip:AddLine(" ", 1, 1, 1)
        GameTooltip:AddLine(" ", 1, 1, 1)
        GameTooltip:AddDoubleLine(L["Message"], E.Core:SplitString(self.raidInfo.message, 50, "", ""), 1, 1, 1, 1, 0, 0)
        GameTooltip:AddLine(" ", 1, 1, 1)
        -- GameTooltip:AddDoubleLine("", "", 1, 1, 1, 1, 0, 0
        -- GameTooltip:AddLine("", "", 1, 1, 1)
        GameTooltip:Show()
    end)
    record:SetScript("OnLeave",function()
        GameTooltip:Hide();
    end)
    function record:UpdateRaidInfo(newTable)
        -- table.wipe(self.raidInfo)
        for k,v in pairs(newTable) do
            self.raidInfo[k] = v
        end
        self:UpdateAll();
    end
    function record:UpdateAll()
        self.rlName:SetText(self.raidInfo.rlName);

        local _,cdColor = E.Core:GetCDInfo(self.raidInfo)
        local raidName = cdColor .. self.raidInfo.raidName

        self.raidName:SetText(raidName);
        self.ilvl:SetText(self.raidInfo.ilvl);
        self.factionTexture:SetTexture(factionToTexture[self.raidInfo.rlFaction])
        self.hTexture:SetShown(self.raidInfo.heal == 1);
        self.ddTexture:SetShown(self.raidInfo.dd == 1);
        self.tTexture:SetShown(self.raidInfo.tank == 1);
    end

    -- record:CreateBackdrop();
    E.GUI:CreateBackdrop(record)

    record:HookScript("OnEnter", function(frame)
        if frame.backdrop then
            local class = select(2,UnitClass("player"))
            frame.backdrop:SetBackdropBorderColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
        end
    end)
	record:HookScript("OnLeave", function(frame)
        if frame.backdrop then
            frame.backdrop:SetBackdropBorderColor(0,0,0,1)
        end
    end)
end




function E.GUI:CreateFindFrame()
    E.GUI.CollapseFrame.MainFrame.FindFrame = CreateFrame("Frame", nil, E.GUI.CollapseFrame.MainFrame);
    local FindFrame = E.GUI.CollapseFrame.MainFrame.FindFrame;
    -- FindFrame:CreateBackdrop("Transparent");
    E.GUI:CreateBackdrop(FindFrame,"Transparent")

    FindFrame:SetAllPoints();
    -- local w,h = E.GUI.CollapseFrame.MainFrame:GetSize();
    -- FindFrame:SetSize(w,h-E.GUI.CollapseFrame.FrameWidth);
    FindFrame:Hide();
    FindFrame:SetScript("OnShow",function(self)
        E.GUI:FindFrameRaidInfoUpdate()
    end)

    E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent = CreateFrame("Frame", "RBFindFrameScrollParent", FindFrame);
    local ScrollParent = E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent
    ScrollParent:SetPoint("TOPLEFT", FindFrame ,"TOPLEFT", 0, -E.GUI.CollapseFrame.FrameWidth)
    ScrollParent:SetPoint("BOTTOMRIGHT", FindFrame ,"BOTTOMRIGHT", 0, 0)
    E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent.Records = {};

    -- self.font = "ChatFontSmall";
    -- self.fontHeight = select(2, getglobal(self.font):GetFont());
    -- self.recordHeight = self.fontHeight + 15;
    -- self.recordWidth = E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent:GetWidth() - 35

    local SortRaidName =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.FindFrame, "SortRaidName", E.Core.raidsTable, "raidName",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 2, 0},true,nil)
    SortRaidName.fs:SetText(L["SortRaidName"])
    -- SortRaidName:Size(4 * self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortRaidName, 4 *self.recordHeight,  self.recordHeight)

    local SortRLName =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.FindFrame, "SortRLName", E.Core.raidsTable, "rlName",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 4.2*self.recordHeight, 0},true,nil)
    SortRLName.fs:SetText(L["SortRLName"])
    -- SortRLName:Size(4 * self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortRLName, 4 *self.recordHeight,  self.recordHeight)

    local SortRLFaction =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.FindFrame, "SortFaction", E.Core.raidsTable, "rlFaction",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 10.1*self.recordHeight, 0},nil,true)
    SortRLFaction.texture:SetTexture(factionToTexture[UnitFactionGroup("player")]);
    -- SortRLFaction:Size(self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortRLFaction, self.recordHeight,  self.recordHeight)

    local SortDD =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.FindFrame, "SortDD", E.Core.raidsTable, "dd",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 12.1*self.recordHeight, 0},nil,true)
    SortDD.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\dps]]);
    -- SortDD:Size(self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortDD, self.recordHeight,  self.recordHeight)

    local SortHeal =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.FindFrame, "SortHeal", E.Core.raidsTable, "heal",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 13.1*self.recordHeight, 0},nil,true)
    SortHeal.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\healer]]);
    -- SortHeal:Size(self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortHeal, self.recordHeight,  self.recordHeight)

    local SortTank =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.FindFrame, "SortTank", E.Core.raidsTable, "tank",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 14.1*self.recordHeight, 0},nil,true)
    SortTank.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\tank]]);
    -- SortTank:Size(self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortTank, self.recordHeight,  self.recordHeight)

    local SortILVL =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.FindFrame,"SortILVL", E.Core.raidsTable, "ilvl",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 16*self.recordHeight, 0},true,nil)
    SortILVL.fs:SetText(L["SortILVL"])
    -- SortILVL:Size(4 * self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortILVL, 4 * self.recordHeight,  self.recordHeight)

    self.numLogRecordFrames = math.floor((ScrollParent:GetHeight() - 3) / self.recordHeight);
    E.GUI.CollapseFrame.MainFrame.FindFrame.MenuFrame = CreateFrame("Frame", "RBMinimapClickMenu", UIParent, "UIDropDownMenuTemplate")
    for i = 1, self.numLogRecordFrames do
        E.GUI:CreateFindFrameRecord(i)
    end

    E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent.ScrollBar = CreateFrame("ScrollFrame", "RBFindFrameScrollParentScrollBar", ScrollParent, "FauxScrollFrameTemplateLight")
    local ScrollBar = E.GUI.CollapseFrame.MainFrame.FindFrame.ScrollParent.ScrollBar
    ScrollBar:SetWidth(ScrollParent:GetWidth() - 35)
    ScrollBar:SetHeight(ScrollParent:GetHeight() - 10)
    ScrollBar:SetPoint("RIGHT", ScrollParent, "RIGHT", -25, 0)
    ScrollBar:SetScript("OnVerticalScroll",function(self, value)
        FauxScrollFrame_OnVerticalScroll(ScrollBar, value,  E.GUI.recordHeight,  E.GUI.FindFrameRaidInfoUpdate)
    end)

end

function  E.GUI:ShowFindFrame()
    E.GUI.CollapseFrame.MainFrame.FindFrame:Show();
end

function  E.GUI:HideFindFrame()
    E.GUI.CollapseFrame.MainFrame.FindFrame:Hide();
end

function  E.GUI:SecondTabInit()
    E.GUI:CreateFindFrame()
end

-- function TestaddS()
--     for i = 1,60 do
--         table.insert(E.Core.raidsTable,{
--             tank =  math.random(0,1),
--             ilvl =  270,
--             raidName =  "Охота",
--             rlLang =  "всеобщий",
--             message =  "DASFASGFAS",
--             difficulty =  4,
--             heal =  math.random(0,1),
--             lastSpamTime =  time(),
--             dd =  math.random(0,1),
--             instanceName =  {{"Логово Магтеридона",2}, {"Испытание крестоносца",2}},
--             rlName =  "Шутка",
--             patterns = { "table: 7C7BCC80"},
--             size =  25,
--             rlFaction = "Horde",
--          })
--     end
--     E.GUI:FindFrameRaidInfoUpdate()
-- end


