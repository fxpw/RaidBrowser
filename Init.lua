---@diagnostic disable: duplicate-set-field
--[[To load the AddOn engine add this to the top of your file:
	local AddOnName, Engine = ...
	local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
]]

local AddOnName, Engine = ...
local AceAddon, AceAddonMinor = _G.LibStub("AceAddon-3.0")
local CallbackHandler = _G.LibStub("CallbackHandler-1.0")

local AddOn = AceAddon:NewAddon(AddOnName, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0", "AceComm-3.0", "AceSerializer-3.0")
AddOn.Callbacks = AddOn.Callbacks or CallbackHandler:New(AddOn)
AddOn.Core = AddOn.Core  or {}
AddOn.Patterns = AddOn.Patterns or {}
AddOn.Func = AddOn.Func or {}
AddOn.GUI = AddOn.GUI or {}
AddOn.GUI.Options = {type = "group", name = AddOnName.. " Options", childGroups = "tab", args = {}}
AddOn.DF = {profile = {}, global = {}}; AddOn.privateVars = {profile = {}} -- Defaults
AddOn.debug = false
Engine[1] = AddOn
Engine[2] = {}
Engine[3] = AddOn.privateVars.profile
Engine[4] = AddOn.DF.profile
Engine[5] = AddOn.DF.global
_G[AddOnName] = Engine

do -- Libs
	AddOn.Libs = {}
	AddOn.LibsMinor = {}
	function AddOn:AddLib(name, major, minor)
		if not name then return end
		-- in this case: `major` is the lib table and `minor` is the minor version
		if type(major) == "table" and type(minor) == "number" then
			self.Libs[name], self.LibsMinor[name] = major, minor
		else -- in this case: `major` is the lib name and `minor` is the silent switch
			self.Libs[name], self.LibsMinor[name] = _G.LibStub(major, minor)
		end
	end
	AddOn:AddLib("AceAddon", AceAddon, AceAddonMinor)
	AddOn:AddLib("AceDB", "AceDB-3.0")
    AddOn:AddLib("ACL", "AceLocale-3.0-RB")
	AddOn:AddLib("AceGUI", "AceGUI-3.0")
	AddOn:AddLib("AceConfig", "AceConfig-3.0-ElvUI")
	AddOn:AddLib("AceConfigDialog", "AceConfigDialog-3.0-ElvUI")
	AddOn:AddLib("AceConfigRegistry", "AceConfigRegistry-3.0-ElvUI")
	AddOn:AddLib("LDB", "LibDataBroker-1.1")
	AddOn:AddLib("LDBI", "LibDBIcon-1.0-RB")
end

function AddOn:Initialize()
	self.initialized = true

	table.wipe(self.db)
	table.wipe(self.global)
	table.wipe(self.private)

	self.data = AddOn.Libs.AceDB:New("RaidBrowserDB", self.DF, true)

	self.data.RegisterCallback(self, "OnProfileChanged", "UpdateAll")
	self.data.RegisterCallback(self, "OnProfileCopied", "UpdateAll")
	self.data._ResetProfile = self.data.ResetProfile
	self.data.ResetProfile = self.OnProfileReset
	self.charSettings = AddOn.Libs.AceDB:New("RaidBrowserPrivateDB", self.privateVars,true)

	self.private = self.charSettings.profile
	self.db = self.data.profile
	self.global = self.data.global
    AddOn.Core:Init()
end


function AddOn:OnInitialize()

	if not RaidBrowserCharacterDB then
		RaidBrowserCharacterDB = {}
	end

	self.db = table.copy(self.DF.profile, true)
	self.global = table.copy(self.DF.global, true)

	if RaidBrowserDB then
		if RaidBrowserDB.global then
			self:CopyTable(self.global, RaidBrowserDB.global)
		end

		local profileKey
		if RaidBrowserDB.profileKeys then
			profileKey = RaidBrowserDB.profileKeys[UnitName("player").." - " ..GetRealmName()]
		end

		if profileKey and RaidBrowserDB.profiles and RaidBrowserDB.profiles[profileKey] then
			self:CopyTable(self.db, RaidBrowserDB.profiles[profileKey])
		end
	end

	self.private = table.copy(self.privateVars.profile, true)

	if RaidBrowserPrivateDB then
		local profileKey
		if RaidBrowserPrivateDB.profileKeys then
			profileKey = RaidBrowserPrivateDB.profileKeys[UnitName("player").." - " ..GetRealmName()]
		end

		if profileKey and RaidBrowserPrivateDB.profiles and RaidBrowserPrivateDB.profiles[profileKey] then
			self:CopyTable(self.private, RaidBrowserPrivateDB.profiles[profileKey])
		end
	end
	self.loadedtime = GetTime()
end


local LoadUI = _G.CreateFrame("Frame")
LoadUI:RegisterEvent("PLAYER_LOGIN")
LoadUI:RegisterEvent("ADDON_LOADED")
LoadUI:SetScript("OnEvent", function(self,event)
	if(event == "PLAYER_LOGIN") then
		AddOn:Initialize()
		Engine[1].GUI:InitMinimapIcon()
	end
end)


