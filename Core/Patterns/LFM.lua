local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

-- Separator characters
local sep_chars = "%s-_,.<>%*)(/#+&x*"

-- Whitespace separator
local sep = "[" .. sep_chars .. "]";

-- Kleene closure of sep.
local csep = sep .. "*";

-- Positive closure of sep.
-- local psep = sep.."+";
E.Patterns.LFM = {
	'нид',
	'нужны',
	'нужен',
	'надо',
	'на' .. csep .. 'фул',
	'рег',
	'все',
	'дпс++',
	'дд',
	'хил',
	'танк',
}