local AddOnName, Engine = ...

local gameLocale
do -- Locale doesn't exist yet, make it exist.
	local convert = {["enGB"] = "enUS", ["esES"] = "esMX", ["itIT"] = "enUS"}
	local lang = GetLocale()

	gameLocale = convert[lang] or lang or "enUS"
	Engine[2] = Engine[1].Libs.ACL:GetLocale(AddOnName, gameLocale)
end

local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
E.GUI.Options.args.Header = { -- Header RaidBrowser
	order = 1,
	type = "header",
	name = format("%s: |cff99ff33%s|r", L["Version"], GetAddOnMetadata(AddOnName, "Version")),
	width = "full"
}

function E:CopyTable(currentTable, defaultTable)
	if type(currentTable) ~= "table" then currentTable = {} end

	if type(defaultTable) == "table" then
		for option, value in pairs(defaultTable) do
			if type(value) == "table" then
				value = self:CopyTable(currentTable[option], value)
			end

			currentTable[option] = value
		end
	end

	return currentTable
end

function E:UpdateAll()
	E.private = E.charSettings.profile
	E.db = E.data.profile
	E.global = E.data.global
end

function E:ResetProfile()
	local profileKey

	if RaidBrowserPrivateDB.profileKeys then
		profileKey = RaidBrowserPrivateDB.profileKeys[UnitName("player").." - " ..GetRealmName()]

		if profileKey and RaidBrowserPrivateDB.profiles and RaidBrowserPrivateDB.profiles[profileKey] then
			RaidBrowserPrivateDB.profiles[profileKey] = nil
		end
	end

	RaidBrowserCharacterDB = nil
	self.data:_ResetProfile()
	ReloadUI()
end

function E:OnProfileReset()
	self:ResetProfile()
end

function E.Core:GetConfigSize()
	return 600, 650
end

function E.Core:SplitString(str, limit, indent, indent1)
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

function E.Core:GetConfigDefaultSize()
	local width, height = E.Core:GetConfigSize()
	local maxWidth, maxHeight = UIParent:GetSize()
	width, height = min(maxWidth - 50, width), min(maxHeight - 50, height)
	return width, height
end

function E.Core:Print(...)

	if E.debug then
		DEFAULT_CHAT_FRAME:AddMessage(strjoin(" ", "RB!: ", ...))
	end
end
function E.Core:ChangeDebug(boolParam)
	if type(boolParam) == "boolean" then
		E.debug = boolParam
	else
		E.debug = not E.debug
	end

end
function E.Core:Init()
	E.GUI:Init();
	E.Core:InitRaidCDInfo();
	E.Core:InitChatParser();
	E.Core:AssebleRaidParserInit();
	E.Core:InitSendMessage();
end