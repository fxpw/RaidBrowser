-- English localization file for enUS and enGB.
local AddOnName, Engine = ...
local E = unpack(Engine); --Import: Engine, Locales, PrivateDB, GlobalDB
local L = E.Libs.ACL:NewLocale(AddOnName, "enUS", true, true)

L["HideRaidsWithCD"] = "Hide raids with CD"
L["HideRaidsWithCDdesc"] = "If enabled, raids with cooldown will not be displayed in the list"
