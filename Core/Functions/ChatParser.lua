local _, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB


local ChatListeners = {
	["CHAT_MSG_CHANNEL"] = true,
	["CHAT_MSG_YELL"] = true,
	["CHAT_MSG_SAY"] = true,
}
local colors = {
	---@type ColorMixin_RCC
	DEATHKNIGHT = { r = 0.76862752437592, g = 0.11764706671238, b = 0.22745099663734, colorStr = "ffc41e3a" },
	---@type ColorMixin_RCC
	DEMONHUNTER = { r = 0.63921570777893, g = 0.18823531270027, b = 0.78823536634445, colorStr = "ffa330c9" },
	---@type ColorMixin_RCC
	DRUID = { r = 1, g = 0.48627454042435, b = 0.039215687662363, colorStr = "ffff7c0a" },
	---@type ColorMixin_RCC
	EVOKER = { r = 0.20000001788139, g = 0.57647061347961, b = 0.49803924560547, colorStr = "ff33937f" },
	---@type ColorMixin_RCC
	HUNTER = { r = 0.66666668653488, g = 0.82745105028152, b = 0.44705885648727, colorStr = "ffaad372" },
	---@type ColorMixin_RCC
	MAGE = { r = 0.24705883860588, g = 0.78039222955704, b = 0.9215686917305, colorStr = "ff3fc7eb" },
	---@type ColorMixin_RCC
	MONK = { r = 0, g = 1, b = 0.59607845544815, colorStr = "ff00ff98" },
	---@type ColorMixin_RCC
	PALADIN = { r = 0.95686280727386, g = 0.54901963472366, b = 0.7294117808342, colorStr = "fff48cba" },
	---@type ColorMixin_RCC
	PRIEST = { r = 1, g = 1, b = 1, colorStr = "ffffffff" },
	---@type ColorMixin_RCC
	ROGUE = { r = 1, g = 0.95686280727386, b = 0.4078431725502, colorStr = "fffff468" },
	---@type ColorMixin_RCC
	SHAMAN = { r = 0, g = 0.43921571969986, b = 0.8666667342186, colorStr = "ff0070dd" },
	---@type ColorMixin_RCC
	WARLOCK = { r = 0.52941179275513, g = 0.53333336114883, b = 0.93333339691162, colorStr = "ff8788ee" },
	---@type ColorMixin_RCC
	WARRIOR = { r = 0.77647066116333, g = 0.60784316062927, b = 0.42745101451874, colorStr = "ffc69b6d" },
}

E.Core.raidsTable = {}

function E.Core:FindIf(t, pred)
	for i, v in ipairs(t) do
		if pred(v) then
			return i;
		end
	end

	return nil
end

function E.Core:FindRaid(message)
	local raidInfoForReturn = {};
	for _, raid in pairs(E.Patterns.Raids) do
		if raid.patterns then
			for _, pattern in pairs(raid.patterns) do
				local result = string.find(message, pattern);
				-- If a raid was found then save it and continue.
				if result then
					E:CopyTable(raidInfoForReturn, raid);
					raidInfoForReturn.find = true;
					-- Remove the substring from the message
					message = string.gsub(message, pattern, '');
					return raidInfoForReturn, message;
				end
			end
		end
	end
	return raidInfoForReturn, message;
end

function E.Core:FindRoles(message)
	local roles = {}
	local findIter
	for roleName, roleTable in pairs(E.Patterns.Roles) do
		findIter = false
		for _, pattern in pairs(roleTable) do
			if not findIter then
				local result = string.find(message, pattern)
				-- If a raid was found then save it to our list of roles and continue.
				if result then
					findIter = true
					roles.find = true
					message = string.gsub(message, pattern, '')
					-- break
				end
			end
		end
		roles[roleName] = findIter and 1 or 0
	end
	return roles, message
end

-- tonumber(string.match("в цлк 25 об нид 1 хила дд-рдд 270+ 22/25 ", "[2-3][0-9][0-9]"))
function E.Core:FindILVL(message)
	local tableFR = {}
	for _, pattern in pairs(E.Patterns.ILVL) do
		local ilvl = tonumber(string.match(message, pattern))
		-- local gs_start, gs_end = string.find(message, pattern)
		if ilvl and ilvl > 200 and ilvl < 300 then
			-- if gs_start and gs_end then
			--type(tonumber(tostring(select(1,testP()))))
			-- local ilvlS = string.sub(message,  gs_start, gs_end);
			-- ilvlS,_ = string.gsub(ilvlS, "%+", '');
			-- local  ilvlN = tonumber(tostring(ilvlS));
			tableFR["ilvl"] = ilvl;
			message = string.gsub(message, pattern, '')
			-- if ilvlN > 0 then
			return tableFR, message
			-- end
		end
		-- ilvl.find = true
	end
	tableFR["ilvl"] = tableFR["ilvl"] or 0
	return tableFR, message
end

function E.Core:FindLFM(message)
	return E.Core:FindIf(E.Patterns.LFM, function(pattern)
		return string.find(message, pattern);
	end);
end

function E.Core:IsBlackListMSG(message)
	message = string.lower(message)
	return E.Core:FindIf(E.Patterns.BlackLists, function(pattern)
		return string.find(message, pattern);
	end);
end

function E.Core:RemoveGarbage(message)
	local http_pattern = 'https?://*[%a]*.[%a]*.[%a]*/?[%a%-%%0-9_]*/?';

	local achievement_pattern = '\124cffffff00\124.*\124h(%[.*%])\124h\124r';

	local instlink_pattern = '\124.*\124.*\124h(%[.*%])\124h\124r';

	local quest_pattern = '\124cff808080\124.*\124h(%[.*%])\124h\124r';

	message = message:gsub(achievement_pattern, '%1');
	message = message:gsub(instlink_pattern, '%1');
	message = message:gsub(quest_pattern, '%1');

	return string.gsub(message, http_pattern, '');
end

function E.Core:RemoveRecordsByName(sender)
	local tableindex = 1
	while E.Core.raidsTable[tableindex] and E.Core.raidsTable[tableindex].rlName do
		if E.Core.raidsTable[tableindex].rlName == sender then
			table.remove(E.Core.raidsTable, tableindex)
		else
			tableindex = tableindex + 1
		end
	end
	E.GUI:FindFrameRaidInfoUpdate();
end

function E.Core:ClearRaidTableAtTime()
	local currentTime = time()
	local tableindex = 1
	while E.Core.raidsTable[tableindex] and E.Core.raidsTable[tableindex].lastSpamTime do
		if (currentTime - E.Core.raidsTable[tableindex].lastSpamTime > E.db.TimeToClearRaids) then
			table.remove(E.Core.raidsTable, tableindex)
		else
			tableindex = tableindex + 1
		end
	end
end

local raidInfo = {};
local roles = {};
local ilvl = {};
local originalMessage
local function ChatParserFunc(self, event, message, sender, language, _, _, _, _, _, _, _, _, guid)
	table.wipe(raidInfo);
	table.wipe(roles);
	table.wipe(ilvl);
	originalMessage = message
	if not ChatListeners[event] then return end

	if E.Core:IsBlackListMSG(message) then return end
	if not E.Core:FindLFM(message) then return end

	ilvl, message = E.Core:FindILVL(message);
	message = E.Core:RemoveGarbage(message);
	message = string.lower(message);
	raidInfo, message = E.Core:FindRaid(message);

	if string.find(message, 'нид все') then
		roles = {
			dd = 1,
			heal = 1,
			tank = 1,
			find = true,
		};
		message = string.gsub(message, 'нид все', "");
	else
		roles, message = E.Core:FindRoles(message);
	end

	if raidInfo.find and roles.find then
		local tableForAdd = {};
		for k, v in pairs(raidInfo) do
			tableForAdd[k] = v;
		end
		for k, v in pairs(roles) do
			tableForAdd[k] = v;
		end
		for k, v in pairs(ilvl) do
			tableForAdd[k] = v;
		end
		local rlFaction             = language == "всеобщий" and "Alliance" or
			language == "орочий" and "Horde" or
			language == "арго скорпидов" and "Renegade"
		local rlClass               = select(2, GetPlayerInfoByGUID(guid))
		local rlColor               = rlClass and colors[rlClass].colorStr or "ffffffff"
		tableForAdd["rlName"]       = sender;
		tableForAdd["rlColor"]      = rlColor;
		tableForAdd["rlLang"]       = language;
		tableForAdd["rlFaction"]    = rlFaction;
		tableForAdd["lastSpamTime"] = time();
		tableForAdd["message"]      = originalMessage;
		tableForAdd["latestMSG"]    = message;
		local numRaidsWhithoutCD    = #raidInfo.instanceName
		for _, v in pairs(raidInfo.instanceName) do
			if E.Core:IsRaidInCD(v[1], raidInfo.size, v[2]) then
				numRaidsWhithoutCD = numRaidsWhithoutCD - 1
			end
		end
		E.Core:RemoveRecordsByName(sender);

		if E.db.HideRaidsWithCD then
			if numRaidsWhithoutCD == 0 then
				E.GUI:FindFrameRaidInfoUpdate();
				-- all
			elseif numRaidsWhithoutCD == #raidInfo.instanceName then
				-- half
				-- print(E.db["RaidBlackList" .. raidInfo.configOrder],"RaidBlackList" .. raidInfo.configOrder)
				if (E.db["RaidBlackList" .. raidInfo.configOrder]) then
					table.insert(E.Core.raidsTable, tableForAdd)
				end
			else
				-- zero
				if (E.db["RaidBlackList" .. raidInfo.configOrder]) then
					table.insert(E.Core.raidsTable, tableForAdd)
				end
			end
		else
			if (E.db["RaidBlackList" .. raidInfo.configOrder]) then
				table.insert(E.Core.raidsTable, tableForAdd)
			end
		end

		E.GUI:FindFrameRaidInfoUpdate();
	end
end


function E.Core:CreateUpdateRaidFrame()
	E.Core.RaidTableUpdateFrame = CreateFrame("Frame")
	E.Core.RaidTableUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
		if self.lastUpdate < time() - E.db.TimeToClearRaids then
			self.lastUpdate = time();
			E.Core:ClearRaidTableAtTime();
			E.GUI:FindFrameRaidInfoUpdate();
		end
	end)
	E.Core.RaidTableUpdateFrame.lastUpdate = time();
end

function E.Core:CreateChatParserFrame()
	self.ChatParserFrame = CreateFrame("Frame")
	for k, _ in pairs(ChatListeners) do
		self.ChatParserFrame:RegisterEvent(k);
	end
	self.ChatParserFrame:SetScript("OnEvent", ChatParserFunc);
end

function E.Core:InitChatParser()
	E.Core:CreateChatParserFrame();
	E.Core:CreateUpdateRaidFrame();
end