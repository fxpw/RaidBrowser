local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local GUI = E.GUI;
GUI.FirstTab = {};
-- local mainFrame
-- local AGUI = E.Libs.AceGUI

E.dungeonsForOptions = {

    "----------------200-213 ilvl----------------",
	"на 3 рлк",
	"на 3 рбк",
    "Око вечности 10",
	"Око вечности 25",
	"Обсидиановое Святилище 10",
	"Обсидиановое Святилище 25",
	"Наксрамас 10",
	"Наксрамас 25",
    "----------------213-226 ilvl----------------",
	"ИК/Оня 10",
	"ИК/Оня 25",
	"Фул охота",
	"ИВК 10",
	"ИВК 25",
	"Сa 10",
	"Сa 25",
	"----------------232-251 ilvl----------------",
	"Логово Магтеридона 25 об",
	"Логово Магтеридона 25 хм",
    "Логово Груула 25 об",
	"Логово Груула 25 хм",
	"Магик/Груул 25 об",
	"Магик/Груул 25 хм",
    "Каражан (репофарм)",
	"Каражан об",
	"Каражан хм",
	"Зул'Аман",
    "----------------251-275 ilvl----------------",
    "ТТГ 10",
	"ТТГ 25",
    "Цлк (репофарм)",
    "Цлк 10 об",
	"Цлк 25 об",
	"Цлк 10 хм",
	"Цлк 25 хм",
	"----------------276-290 ilvl----------------",
    "Змеиное Святилише 25 об",
	"Змеиное Святилише 25 хм",
	"Крепость бурь: Око 25 об",
	"Крепость бурь: Око 25 хм",
	"Рубиновое Святилище 10 об",
    "Рубиновое Святилище 10 хм",
	"Рубиновое Святилище 25 об",
	"Рубиновое Святилище 25 хм",
	"----------------297+ ilvl----------------",
	"Ульдуар 10 об",
	"Ульдуар 10 хм",
	"Ульдуар 25 об",
	"Ульдуар 25 хм",
    "Бронзовое Святилище 25 об",
    "Бронзовое Святилище 25 хм",
	"Хиджал (репофарм)",
    "Хиджал",


}


E.GUI.Options.args.FirstTab = {
    order = 2,
	type = "group",
	name = L["Create Raid Tab"],
	childGroups = "tree",
	get = function(info) return E.db[info[#info]] end,
	set = function(info, value) E.db[info[#info]] = value end,
    args = {
		intro = {
			order = 1,
			type = "description",
			name = L["create raid opt desc"]
		},
        selectedRaid = {
            order = 2,
            type = "select",
            name = L["SelectedRaid"],
            width = "full",
            values = E.dungeonsForOptions,
        },
		tankCount = {
            order = 3,
            type = "range",
            min = 0, max = 5, step = 1,
            name = L["TankCount"],
            desc = L["TankCountdesc"],
        },
        healCount = {
            order = 4,
            type = "range",
            min = 0, max = 5, step = 1,
            name = L["HealCount"],
            desc = L["HealCountdesc"],
        },
        ddCount = {
            order = 5,
            type = "range",
            min = 0, max = 25, step = 1,
            name = L["DDCount"],
            desc = L["DDCountdesc"],
        },
        spacer = {
            order = 6,
            type = "description",
            name = ""
        },
        tankInfo = {
            order = 7,
            type = "input",
            -- min = 1, max = 5, step = 1,
            name = L["TankInfo"],
            desc = L["TankInfodesc"],
        },
        healInfo = {
            order = 8,
            type = "input",
            -- min = 1, max = 5, step = 1,
            name = L["HealInfo"],
            desc = L["HealInfodesc"],
        },
        ddInfo = {
            order = 9,
            type = "input",
            -- min = 1, max = 5, step = 1,
            name = L["DDInfo"],
            desc = L["DDInfodesc"],
        },
        spacer1 = {
            order = 10,
            type = "description",
            name = ""
        },
        ilvlCount = {
            order = 11,
            type = "range",
            min = 200, max = 300, step = 5,
            name = L["ilvlCount"],
            desc = L["ilvlCountdesc"],
        },
        anrolCount = {
            order = 12,
            type = "range",
            min = 0, max = 5, step = 1,
            name = L["anrolCount"],
            desc = L["anrolCountdesc"],
        },
        spacer2 = {
            order = 14,
            type = "description",
            name = ""
        },
        ilvlInfo = {
            order = 15,
            type = "input",
            -- min = 1, max = 5, step = 1,
            name = L["ilvlInfo"],
            desc = L["ilvlInfodesc"],
        },
        anrolInfo = {
            order = 16,
            type = "input",
            -- min = 1, max = 5, step = 1,
            name = L["anrolInfo"],
            desc = L["anrolInfodesc"],
        },
        addedInfo = {
            order = 17,
            type = "input",
            -- min = 1, max = 5, step = 1,
            name = L["addedInfo"],
            desc = L["addedInfodesc"],
        },
        spacer3 = {
            order = 18,
            type = "description",
            name = ""
        },
        channelNumbers = {
            order = 19,
            type = "multiselect",
            name = L["channelNumber"],
            -- width = "half",
            customWidth = 120,
            values = {
                c4 = L["ChannelName4"],
                c5 = L["ChannelName5"],
                c6 = L["ChannelName6"],
                c7 = L["ChannelName7"],
            },
            get = function(info, key) return E.db.channelNumbers[key] end,
            set = function(info, key, value)
                E.db.channelNumbers[key] = value
                -- GameTooltip:Hide()
            end
        },
        spacer4 = {
            order = 20,
            type = "description",
            name = ""
        },
        spamTime = {
            order = 21,
            type = "range",
            min = 35, max = 180, step = 1,
            name = L["spamTime"],
            desc = L["spamTimedesc"],
        },
        timeToClearAssemble = {
            order = 22,
            type = "range",
            min = 35, max = 180, step = 1,
            name = L["timeToClearAssemble"],
            desc = L["timeToClearAssembledesc"],
        },
        spacer6 = {
            order = 23,
            type = "header",
            name = L["spamText"],
            -- name = function() return E.db.addedInfo end,
            width = "full"
        },
        spamText = {
            order = 24,
            type = "description",
            name = function()  return E.Core:GetLFGMsg().."\n"..#E.Core:GetLFGMsg().."/255" end,
            width = "full"
        },
        spacer7 = {
            order = 25,
            type = "description",
            name = ""
        },
        spacer8 = {
            order = 26,
            type = "header",
            name = "",
            -- name = function() return E.db.addedInfo end,
            width = "full"
        },
        startSpam = {
            order = 27,
            type = "execute",
            name = function()
                E.GUI:UpdateInfoText("")
                return not E.Core.IsNeedSendMessage and L["startSpam"] or L["stopSpam"]
            end,
            func = function() E.Core.IsNeedSendMessage = not E.Core.IsNeedSendMessage end
        },
    }
}

function E.GUI:ShowAssembleFrame()
    E.GUI.CollapseFrame.MainFrame.AssembleFrame:Show();
end

function E.GUI:HideAssembleFrame()
    E.GUI.CollapseFrame.MainFrame.AssembleFrame:Hide();
end

local menuList = {
    {
		text = L["AddToParty"],
		notCheckable = 1,
		func = function(self, arg1, arg2)
            -- SendChatMessage("RB!: Хочу в рейд, я ".. arg2.pilvl.. " " .. arg2.pClass  .." " .. arg2.currentSpecName, "WHISPER", nil, arg1.rlName);
            InviteUnit(arg1.playerName);
            E.Core:ClearAssembleTableAtName(arg1.playerName);
		end
	},
    {
		text = L["Delete"],
		notCheckable = 1,
		func = function(self, arg1, arg2)
            -- SendChatMessage("RB!: Хочу в рейд, я ".. arg2.pilvl.. " " .. arg2.pClass  .." " .. arg2.currentSpecName, "WHISPER", nil, arg1.rlName);
            E.Core:ClearAssembleTableAtName(arg1.playerName);
        end
	},
}


function E.GUI:AssembleFrameInfoUpdate()
    if not E.GUI.CollapseFrame.MainFrame.AssembleFrame:IsVisible() then
        return;
    end
    local offset = FauxScrollFrame_GetOffset(E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.ScrollBar)
    local numRecords = #E.Core.InvTable
    local numDisplayedRecords = math.min(E.GUI.numLogRecordFrames, numRecords - offset)
    local record
    for i=1, E.GUI.numLogRecordFrames do
        record = E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.Records[i]
        local logIndex = i + offset - 1
        local logTableRecord = E.Core.InvTable[#E.Core.InvTable-logIndex]
        if logIndex < numRecords then
            if logTableRecord then
                record:UpdatePlayerInfo(logTableRecord);
            end
            record:Show();
        else
            record:Hide();
        end
    end
    FauxScrollFrame_Update(E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.ScrollBar, numRecords, numDisplayedRecords,  E.GUI.recordHeight)
end

function E.GUI:CreateAssembleFrameRecord(i)
    E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.Records[i] = E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.Records[i] or CreateFrame("Button", nil, E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent);
    local record = E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.Records[i]
    record.playerInfo = record.playerInfo or {
        playerName = "",
        currentSpecName = "",
        ilvl = "",
        playerClassName = "",
        dd = true,
        heal = true,
        tank = true,
        requestTime = 0,
    };
    record:SetHeight(self.recordHeight);
    record:SetWidth(self.recordWidth);
    record.playerName = record.playerName or record:CreateFontString(nil, OVERLAY, "GameTooltipText");
    record.playerName:SetPoint("LEFT",record,"LEFT",0,0);
    record.playerName:SetText(record.playerInfo.playerName);

    record.playerClassName =  record.playerClassName or record:CreateFontString(nil, OVERLAY, "GameTooltipText");
    record.playerClassName:SetPoint("LEFT",record,"LEFT",4.2*self.recordHeight,0);
    record.playerClassName:SetText(record.playerInfo.playerClassName);

    record.specName = record.specName or record:CreateFontString(nil, OVERLAY, "GameTooltipText");
    record.specName:SetPoint("LEFT",record,"LEFT",8*self.recordHeight,0);
    record.specName:SetText(record.playerInfo.specName);

    record.ilvl = record.ilvl or record:CreateFontString(nil, OVERLAY, "GameTooltipText");
    record.ilvl:SetPoint("RIGHT",record,"RIGHT",0,0);
    record.ilvl:SetText(record.playerInfo.ilvl);

    record.ddTexture = record.ddTexture or record:CreateTexture();
    record.ddTexture:SetSize(self.recordHeight,self.recordHeight);
    record.ddTexture:SetPoint("TOPLEFT", record ,"TOPLEFT", 12*self.recordHeight, 0);
    record.ddTexture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\dps]]);

    record.hTexture = record.hTexture or record:CreateTexture();
    record.hTexture:SetSize(self.recordHeight,self.recordHeight);
    record.hTexture:SetPoint("TOPLEFT", record ,"TOPLEFT", 13*self.recordHeight, 0);
    record.hTexture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\healer]]);

    record.tTexture = record.tTexture or record:CreateTexture();
    record.tTexture:SetSize(self.recordHeight,self.recordHeight);
    record.tTexture:SetPoint("TOPLEFT", record ,"TOPLEFT", 14*self.recordHeight, 0);
    record.tTexture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\tank]]);

	if i == 1 then
        record:SetPoint("TOPLEFT", E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent, "TOPLEFT", 0, 0);
		record:SetPoint("TOPRIGHT", E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent, "TOPRIGHT", -35, 0);
    else
        record:SetPoint("TOPLEFT", E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.Records[i-1], "BOTTOMLEFT");
		record:SetPoint("TOPRIGHT", E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.Records[i-1], "BOTTOMRIGHT");
    end
    record:Show();
    E.GUI:CreateBackdrop(record);


    record:RegisterForClicks("AnyUp");
    record:SetScript("OnClick", function(self, click)

        -- InviteUnit(self.playerInfo.playerName)
        -- E.Core:ClearAssembleTableAtName(self.playerInfo.playerName)
        -- E.Core:Send
        local position = self:GetPoint();

        menuList[1].arg1 = self.playerInfo;
        menuList[2].arg1 = self.playerInfo;
        -- menuList[1].arg2 = E.Core:GetPlayerInfo();
        -- for q = 1,menuList[1].arg2.maxSpecs do
        --     menuList[q+1]={
        --         text = L["SendMSGToRL(spec"..q..")"],
        --         notCheckable = 1,
        --         func = function()
        --             SendChatMessage("RB!: Хочу в рейд, я " ..menuList[1].arg2.pClass  .. " " .. E.Core:GetSpecNameFromTalents(q), "WHISPER", nil, menuList[1].arg1.rlName);
        --         end
        --     }
        -- end
        if position:match("LEFT") then
            EasyMenu(menuList, E.GUI.CollapseFrame.MainFrame.AssembleFrame.MenuFrame, "cursor", 0, 0, "MENU", 2);
        else
            EasyMenu(menuList, E.GUI.CollapseFrame.MainFrame.AssembleFrame.MenuFrame, "cursor", -160, 0, "MENU", 2);
        end
    end)
    record:SetScript("OnEnter",function(self)
		if self.backdrop then
            local class = select(2,UnitClass("player"));
            self.backdrop:SetBackdropBorderColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
        end
    end)
    record:SetScript("OnLeave",function()
        GameTooltip:Hide();
		if self.backdrop then
            self.backdrop:SetBackdropBorderColor(0,0,0,1);
        end
    end)
    function record:UpdatePlayerInfo(newTable)
        -- table.wipe(self.raidInfo)
        for k,v in pairs(newTable) do
            self.playerInfo[k] = v;
        end
        self:UpdateAll();
    end
    function record:UpdateAll()
        self.playerName:SetText(self.playerInfo.playerName);
        self.playerClassName:SetText(self.playerInfo.playerClassName);
        self.specName:SetText(self.playerInfo.currentSpecName);
        self.ilvl:SetText(self.playerInfo.ilvl);
        self.hTexture:SetShown(self.playerInfo.heal == 1);
        self.ddTexture:SetShown(self.playerInfo.dd == 1);
        self.tTexture:SetShown(self.playerInfo.tank == 1);
    end

end

function E.GUI:CreateAssembleFrame()
    -- E.GUI.CollapseFrame.MainFrame.CollectFrame = CreateFrame()
    E.GUI.CollapseFrame.MainFrame.AssembleFrame = CreateFrame("Frame", nil, E.GUI.CollapseFrame.MainFrame);
    local AssembleFrame = E.GUI.CollapseFrame.MainFrame.AssembleFrame;
    -- AssembleFrame:CreateBackdrop("Transparent");
    E.GUI:CreateBackdrop(AssembleFrame,"Transparent");

    AssembleFrame:SetAllPoints();
    -- local w,h = E.GUI.CollapseFrame.MainFrame:GetSize();
    -- AssembleFrame:SetSize(w,h-E.GUI.CollapseFrame.FrameWidth);
    AssembleFrame:Hide();
    AssembleFrame:SetScript("OnShow",function(self)
        E.GUI:AssembleFrameInfoUpdate();
    end)

    E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent = CreateFrame("Frame", "RBAssembleFrameScrollParent", AssembleFrame);
    local ScrollParent =  E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent;
    ScrollParent:SetPoint("TOPLEFT", AssembleFrame ,"TOPLEFT", 0, -E.db.CollapseFrameHeight);
    ScrollParent:SetPoint("BOTTOMRIGHT", AssembleFrame ,"BOTTOMRIGHT", 0, 0);
    E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.Records = {};

    local SortPlayerName =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.AssembleFrame, "SortPlayerName", E.Core.InvTable,"playerName",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 0, 0},true,nil)
    SortPlayerName.fs:SetText(L["SortPlayerName"]);
    -- SortPlayerName:Size(4 * self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortPlayerName, 4*self.recordHeight,  self.recordHeight);

    local SortClassName =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.AssembleFrame, "SortClassName", E.Core.InvTable,"playerClassName",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 4.2*self.recordHeight, 0},true,nil)
    SortClassName.fs:SetText(L["SortClassName"]);
    -- SortClassName:Size(4 * self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortClassName, 3*self.recordHeight,  self.recordHeight);

    local SortSpecName =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.AssembleFrame,"SortSpecName", E.Core.InvTable,"currentSpecName",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 8*self.recordHeight, 0},true,nil)
    SortSpecName.fs:SetText(L["SortSpecName"]);
    -- SortSpecName:Size(4 * self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortSpecName, 4*self.recordHeight,  self.recordHeight);

    local SortDD =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.AssembleFrame, "SortDD", E.Core.InvTable,"dd",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 12*self.recordHeight, 0},nil,true)
    SortDD.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\dps]]);
    -- SortDD:Size(self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortDD, self.recordHeight,  self.recordHeight);

    local SortHeal =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.AssembleFrame, "SortHeal", E.Core.InvTable,"heal",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 13*self.recordHeight, 0},nil,true)
    SortHeal.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\healer]]);
    -- SortHeal:Size(self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortHeal, self.recordHeight,  self.recordHeight);

    local SortTank =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.AssembleFrame,"SortTank", E.Core.InvTable,"tank",{"BOTTOMLEFT", ScrollParent ,"TOPLEFT", 14*self.recordHeight, 0},nil,true)
    SortTank.texture:SetTexture([[Interface\AddOns\RaidBrowser\Media\Textures\tank]]);
    -- SortTank:Size(self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortTank, self.recordHeight,  self.recordHeight);

    local SortILVL =  E.GUI:CreateSortButton(E.GUI.CollapseFrame.MainFrame.AssembleFrame,"SortILVL", E.Core.InvTable,"ilvl",{"BOTTOMRIGHT", ScrollParent, "TOPRIGHT", -35, 0},true,nil)
    SortILVL.fs:SetText(L["SortILVL"]);
    -- SortILVL:Size(4 * self.recordHeight,  self.recordHeight);
    E.GUI:Size(SortILVL, 4 * self.recordHeight,  self.recordHeight);

    self.numLogRecordFrames = math.floor((ScrollParent:GetHeight() - 3) / self.recordHeight);
    E.GUI.CollapseFrame.MainFrame.AssembleFrame.MenuFrame = CreateFrame("Frame", "RBMinimapClickMenu", UIParent, "UIDropDownMenuTemplate")
    for i = 1, self.numLogRecordFrames do
        E.GUI:CreateAssembleFrameRecord(i);
    end

    E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.ScrollBar = CreateFrame("ScrollFrame", "RBAssembleFrameScrollParentScrollBar", ScrollParent, "FauxScrollFrameTemplateLight")
    local ScrollBar = E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.ScrollBar
    ScrollBar:SetWidth(ScrollParent:GetWidth() - 35);
    ScrollBar:SetHeight(ScrollParent:GetHeight() - 10);
    ScrollBar:SetPoint("RIGHT", ScrollParent, "RIGHT", -25, 0);
    ScrollBar:SetScript("OnVerticalScroll",function(self, value)
        FauxScrollFrame_OnVerticalScroll(ScrollBar, value,  E.GUI.recordHeight,  E.GUI.AssembleFrameInfoUpdate);
    end)


end

function E.GUI:UpdateAssembleFrame()
	self.numLogRecordFrames = math.floor((E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent:GetHeight() - 3) / self.recordHeight);
    for i = 1, #E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.Records do
		if E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.Records[i] then
			E.GUI.CollapseFrame.MainFrame.AssembleFrame.ScrollParent.Records[i]:Hide();
		end
	end
	for i = 1, self.numLogRecordFrames do
        E.GUI:CreateAssembleFrameRecord(i);
    end

end


function E.GUI:FirstTabInit()
    E.GUI:CreateAssembleFrame();
    E.GUI:AssembleFrameInfoUpdate();
end




-- function TestaddF()
--     for i = 1,60 do
--         table.insert(E.Core.InvTable,{
--             playerName = "Шутка",
--             currentSpecName = "Фурик в теле энха" ..math.random(0,100) ,
--             ilvl = math.random(1,234),
--             playerClassName = "Шоумэн"..math.random(0,100),
--             dd = math.random(0,1),
--             heal = math.random(0,1),
--             tank = math.random(0,1),
--         })
--     end
--     E.GUI:AssembleFrameInfoUpdate()
-- end
