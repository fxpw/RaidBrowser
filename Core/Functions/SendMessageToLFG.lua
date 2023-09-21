local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB


E.Core.CanSendMessage = false
E.Core.IsNeedSendMessage = false
-- /run local a = GetFixedLink function GetFixedLink(...) print(...) return a(...) end
-- /run hooksecurefunc("SetItemRef", function(link, ...) local printable = gsub(link, "\124", "\124\124"); if (printable) then ItemRefTooltip:AddDoubleLine("print: " .. printable); ItemRefTooltip:Show();end end)
-- hooksecurefunc("EncounterJournal_OpenJournalLink",function(...)print(...) end) -- test links
function E.Core:GetLFGMsg()
	local db = E.db
	local msg = ""

	if string.find(E.dungeonsForOptions[db.selectedRaid],"ilvl") then
		return "Выберите другой рейд"
	end
	-- local selectedRaidMSG = db.selectedRaid
	local type1,type2,type3 = unpack(E.dungeonsForSpam[db.selectedRaid])
	if not type1 or not type2 or not type3 then
		return "Выберите другой рейд"
	end
	-- " \124cffffff00\124Hquest:99:15\124h[Arugal's Folly]\124h\124r"
	-- /run print(" \124cffffff00\124Hquest:22387:15\124h[Arugal's Folla]\124h\124r")
	local selectedRaidMSG = string.format("\124cffffff00\124H%s:%s\124h[%s]\124h\124r",type1,type2,type3)
	-- print(selectedRaidMSG)
	msg = msg .. selectedRaidMSG .. " нужны "
	if db.tankCount == 0 and db.healCount == 0 and db.ddCount == 0 then
		msg  = msg .. " все "
	else
		local tanksMSG = (db.tankCount > 0 and db.tankCount.." танк(а)" or "") .. (db.tankInfo ~= "" and (" ("..db.tankInfo..") ") or " ")
		local healMSG = (db.healCount > 0 and db.healCount .." хил(а)" or "") .. (db.healInfo ~= "" and (" ("..db.healInfo..") ") or " ")
		local ddMSG = (db.ddCount > 0 and db.ddCount.." дд/рдд" or "") .. (db.ddInfo ~= "" and (" ("..db.ddInfo..") ") or " ")
		msg = msg .. tanksMSG
		msg = msg .. healMSG
		msg = msg .. ddMSG
	end

	local ilvlMSG = ("от "..db.ilvlCount.." ilvl") .. (db.ilvlInfo ~= "" and (" ("..db.ilvlInfo..") ") or " ")
	msg = msg .. ilvlMSG

	local anrollMSG = (db.anrolCount > 0 and (db.anrolCount .. " a") or "") .. (db.anrolInfo ~= "" and (" (" .. db.anrolInfo .. ") ") or " ")
	msg = msg .. anrollMSG

	msg = msg .. db.addedInfo
	return msg
end

function E.Core:SendLFGMsg()
	if E.Core.CanSendMessage and E.Core.IsNeedSendMessage then
		if #(E.Core:GetLFGMsg()) > 255 then
			return E.Core:Print("Слишком много символов в сообщении для отправки в чат")
		end
		local lang = "всеобщий"
		local channel = 4
		if E.db.ChannelNumbers.c4 then
			if GetChannelName(4) > 1  then
				if UnitFactionGroup("player") ~= "Renegade" then
					-- local lang = ""
					lang = UnitFactionGroup("player") == "Alliance" and "всеобщий" or lang
					lang = UnitFactionGroup("player") == "Horde" and "орочий" or lang
					channel = "4"
				end
			end
		end
		if E.db.ChannelNumbers.c5 then
			if select(2,GetChannelName(5)) then
				-- local lang = "всеобщий"
				lang = string.find(select(2,GetChannelName(5)), "(A)") and "всеобщий" or lang
				lang = string.find(select(2,GetChannelName(5)), "(О)") and "орочий" or lang
				-- if string.find(select(2,GetChannelName(5)), "(A)")  then
				-- 	local lang = UnitFactionGroup("player") == "Alliance" and "всеобщий" or "орочий"
				-- SendChatMessage(E.Core:GetLFGMsg(), "CHANNEL", lang, 5)
				channel = "5"
			end
		end
		if E.db.ChannelNumbers.c6 then
			if select(2,GetChannelName(6)) then
				-- local lang = "всеобщий"
				lang = string.find(select(2,GetChannelName(6)), "(A)") and "всеобщий" or lang
				lang = string.find(select(2,GetChannelName(6)), "(О)") and "орочий" or lang
				-- if string.find(select(2,GetChannelName(5)), "(A)")  then
				-- 	local lang = UnitFactionGroup("player") == "Alliance" and "всеобщий" or "орочий"
				-- SendChatMessage(E.Core:GetLFGMsg(), "CHANNEL", lang, 6)
				channel = "6"
			end
		end
		if E.db.ChannelNumbers.c7 then
			if select(2,GetChannelName(7)) then
				-- local lang = "всеобщий"
				lang = string.find(select(2,GetChannelName(7)), "(A)") and "всеобщий" or lang
				lang = string.find(select(2,GetChannelName(7)), "(О)") and "орочий" or lang
				-- if string.find(select(2,GetChannelName(5)), "(A)")  then
				-- 	local lang = UnitFactionGroup("player") == "Alliance" and "всеобщий" or "орочий"
				-- SendChatMessage(E.Core:GetLFGMsg(), "CHANNEL", lang, 7)
				channel = "7"
			end
		end
		-- print(123)
		-- print(E.Core:GetLFGMsg(), "CHANNEL", lang, channel)
		SendChatMessage(E.Core:GetLFGMsg(), "CHANNEL", lang, channel)
		E.Core.CanSendMessage = false
		E.Core.SendMessageFrame.lastSpam = time()
	end
end


function E.Core:CanSendMSG()
	return E.Core.CanSendMessage
end

function E.Core:ChangeCanSendMSG(bool)
	E.Core.CanSendMessage = (type(bool) == "boolean" and bool) or not E.Core.CanSendMessage
end

function E.Core:InitSendMessage()
	self.SendMessageFrame = CreateFrame("Frame")
	local SendMessageFrame = self.SendMessageFrame
	SendMessageFrame.lastSpam = time()
	SendMessageFrame:SetScript("OnUpdate",function(self,elapsed)
		if E.Core.IsNeedSendMessage then
			if self.lastSpam < time() - E.db.spamTime then
				-- self.lastUpdate = time();
				-- if not E.Core:CanSendMSG() then
				-- E.Core:ChangeCanSendMSG(true)
				E.Core.CanSendMessage = true
				E.GUI:UpdateInfoText("Отправить сообщение")
				-- end
			elseif self.lastSpam > time() - E.db.spamTime and not E.Core.CanSendMessage then
				E.GUI:UpdateInfoText("Отправка сообщения:"..string.format("%.0f",(E.db.spamTime - (time() - self.lastSpam))))
			end
		end
	end)
end
