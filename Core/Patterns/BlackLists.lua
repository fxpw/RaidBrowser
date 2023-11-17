local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

-- Separator characters
local sep_chars = "%s-_,.<>%*)(/#+&x*"

-- Whitespace separator
local sep = "[" .. sep_chars .. "]";

-- Kleene closure of sep.
local csep = sep.."*";

-- Positive closure of sep.
-- local psep = sep.."+";



E.Patterns.BlackLists = {

    --wts msg
    "скупаю"..sep,
    "продам"..sep,
    "прода"..sep,
    "продает"..sep,
    "продажа"..sep,
    "продае"..sep,
    "продаёт"..sep,
    "голдран"..sep,
    "продаю"..sep,
    "куплю"..sep,
    "wts"..sep,
    "selling"..sep,
    "покупатель"..sep,
    "по всем вопросам"..sep,
    "покупателя"..sep,
    "покупатели"..sep,

    --lfg msg
    "гильдию",
	"гильдия",
	"набор",
	"рассмотрим",
	"pve"..sep,
	"guild",
	"рассмотрим",
	"rt",
	"kick",
	"состав",
	"молодую"..sep,
	"закрытия"..sep,
	"проходок",
	"epgp"..sep,
	"ep"..sep,
	"приглашает",
	"закрываем",
	"приглашаются",
	"доступом",
	"набирает",
	"приглашаем",
	"хорошим",
	"онлайн",
	"закрытое",
	"приглашает",
	"требуется",
	"активность",
	"активных",
	"от нас",
	"от вас",
	"требуются",
	"берем",
	"осваиваем",
	"освоено",
	"примет",
	"прогресс",
	"рт",
	"ходим",
	"донабор",
	"открывает",
	"знаменитая",
	"статик",
	"pvp"..sep,
	"ведет"..csep.."набор",
	"ведет"..csep.."добор",
	"идет"..csep.."добор",
	"производит"..csep.."набор",
	"открыт"..csep.."набор",
	"в"..csep.."пве"..csep.."ги",
	"в"..csep.."ги"..sep,
	"в"..csep.."pve"..sep,
	"в"..csep.."пве"..csep.."гильдию"..sep,
	"прогресс"..csep.."ги",

}
