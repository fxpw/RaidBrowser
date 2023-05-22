local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB


E.Core.CanSendMessage = false
E.Core.IsNeedSendMessage = false

local function AddSpaceToString(str, limit, indent, indent1)
	indent = indent or ""
	indent1 = indent1 or indent
	limit = limit or 70
	local here = 1-#indent1
	local function check(sp, st, word, fi)
	   if fi - here > limit then
		  here = st - #indent
		  return "\n"..indent..word
	   end
	end
	return indent1..str:gsub("(%s+)()(%S+)()", check)
end



function E.Core:GetLFGMsg()
	local db = E.db
	local msg = ""

	if string.find(E.dungeonsForOptions[db.selectedRaid],"ilvl") then
		return "выберите другой рейд"
	end
	msg = msg .. E.dungeonsForOptions[db.selectedRaid] .. " нужны "
	if db.tankCount == 0 and db.healCount == 0 and db.ddCount == 0 then
		msg  = msg .. " нид все "
	else
		local tanksMSG = (db.tankCount > 0 and db.tankCount.." танка" or "") .. (db.tankInfo ~= "" and (" ("..db.tankInfo..") ") or " ")
		local healMSG = (db.healCount > 0 and db.healCount .." хила" or "") .. (db.healInfo ~= "" and (" ("..db.healInfo..") ") or " ")
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
		if E.db.channelNumbers.c4 then
			if GetChannelName(4) > 1  then
				if UnitFactionGroup("player") ~= "Renegade" then
					local lang = ""
					lang = UnitFactionGroup("player") == "Alliance"  and "всеобщий" or lang
					lang = UnitFactionGroup("player") == "Horde" and "орочий" or lang
					SendChatMessage(E.Core:GetLFGMsg(), "CHANNEL", lang, 4)
				end
			end
		end
		if E.db.channelNumbers.c5 then
			if select(2,GetChannelName(5)) then
				local lang = "всеобщий"
				lang = string.find(select(2,GetChannelName(5)), "(A)") and "всеобщий" or lang
				lang = string.find(select(2,GetChannelName(5)), "(О)") and "орочий" or lang
				-- if string.find(select(2,GetChannelName(5)), "(A)")  then
				-- 	local lang = UnitFactionGroup("player") == "Alliance" and "всеобщий" or "орочий"
				SendChatMessage(E.Core:GetLFGMsg(), "CHANNEL", lang, 5)
			end
		end
		if E.db.channelNumbers.c6 then
			if select(2,GetChannelName(6)) then
				local lang = "всеобщий"
				lang = string.find(select(2,GetChannelName(6)), "(A)") and "всеобщий" or lang
				lang = string.find(select(2,GetChannelName(6)), "(О)") and "орочий" or lang
				-- if string.find(select(2,GetChannelName(5)), "(A)")  then
				-- 	local lang = UnitFactionGroup("player") == "Alliance" and "всеобщий" or "орочий"
				SendChatMessage(E.Core:GetLFGMsg(), "CHANNEL", lang, 6)
			end
		end
		if E.db.channelNumbers.c7 then
			if select(2,GetChannelName(7)) then
				local lang = "всеобщий"
				lang = string.find(select(2,GetChannelName(7)), "(A)") and "всеобщий" or lang
				lang = string.find(select(2,GetChannelName(7)), "(О)") and "орочий" or lang
				-- if string.find(select(2,GetChannelName(5)), "(A)")  then
				-- 	local lang = UnitFactionGroup("player") == "Alliance" and "всеобщий" or "орочий"
				SendChatMessage(E.Core:GetLFGMsg(), "CHANNEL", lang, 7)
			end
		end

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
