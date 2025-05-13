local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local GetTalentTabInfo = _G.GetTalentTabInfo
local C_Talent = C_Talent
-- local SendWho = SendWho
-- local GetNumWhoResults = GetNumWhoResults
-- local GetWhoInfo = GetWhoInfo
E.Core.PlayerInfo = {};

local function GetTalentTabPoints(i)
	local _, _, pts = GetTalentTabInfo(i)
	return pts;
end
local ItemLevelMixIn = _G.ItemLevelMixIn

--from stdlib
local function transform(values, fn)
	local t = {}
	for _, v in ipairs(values) do
		local result = fn(v);
		table.insert(t, result)
	end
	return t;
end

local function max_of(t)
	local result = -math.huge;
	local index = 1;
	for i, v in ipairs(t) do
		if v and v > result then
			result = v;
			index = i;
		end
	end
	return index, result;
end

local function GetAllSpecInfo()
	-- local tableForReturn = {}
	local SpecInfoCache = C_Talent.GetSpecInfoCache()
	local tableForReturn = SpecInfoCache.talentGroupData
	return tableForReturn;
end

local function GetActiveSpecIndex()
	local indices = transform({ 1, 2, 3 }, GetTalentTabPoints)
	local i, _ = max_of(indices);
	return i;
end

local function GetActiveSpecName()
	return GetTalentTabInfo(GetActiveSpecIndex());
end

function E.Core:PlayerIsHeal()
	return math.random(1, 2) == 2
end

function E.Core:PlayerIsTank()
	return math.random(1, 2) == 2
end

function E.Core:PlayerIsDD()
	return math.random(1, 2) == 2
end

function E.Core:Has4t4()
	for i = 1,40 do
		local buffname = UnitBuff("player",i)
		if buffname then
			if string.find(buffname,"Тир 4") then
				return true
			end
		else
			return false
		end
	end
end

function E.Core:GetPlayerInfo()
	table.wipe(E.Core.PlayerInfo)
	E.Core.PlayerInfo.playerClassName = UnitClass("player");
	E.Core.PlayerInfo.playerName = UnitName("player");
	E.Core.PlayerInfo.ilvl = ItemLevelMixIn:GetItemLevel(UnitGUID("player"));
	E.Core.PlayerInfo.specInfo = GetAllSpecInfo();
	E.Core.PlayerInfo.currentSpecName = GetActiveSpecName();
	E.Core.PlayerInfo.maxSpecs = C_Talent.GetNumTalentGroups();
	E.Core.PlayerInfo.heal = E.Core:PlayerIsHeal();
	E.Core.PlayerInfo.dd = E.Core:PlayerIsDD();
	E.Core.PlayerInfo.tank = E.Core:PlayerIsTank();
	E.Core.PlayerInfo.myFaction = UnitFactionGroup("player");
	E.Core.PlayerInfo._4t4 = E.Core:Has4t4();
	return E.Core.PlayerInfo;
end

function E.Core:GetSpecNameFromTalents(specId)
	local specInfo = E.Core:GetPlayerInfo().specInfo;
	local i, _ = max_of(specInfo[specId]);
	return GetTalentTabInfo(i);
end