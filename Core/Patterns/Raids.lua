local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine)

-- Separator characters (including Cyrillic and common special chars)
local sep_chars = "%s-_,.<>%*)(/#+&x*"
local sep = "[" .. sep_chars .. "]"
local csep = sep .. "*"

E.Patterns.Raids = {
    -- Классические подземелья
    {
        raidName = "Огненная пропасть",
        instanceName = {
            {"Огненная пропасть", 1}
        },
        size = 5,
        difficulty = 2,
        patterns = {
            "огненная" .. csep .. "пропасть" .. csep .. "",
            "" .. csep .. "оп",
            "" .. csep .. "ОП",
            "оп" .. csep .. "",
            "%[?Огненная" .. csep .. "Пропасть%]?" .. csep .. "?",
            "огненная" .. csep .. "пропасть",
        }
    },
    {
        raidName = "Пещеры стенаний",
        instanceName = {
            {"Пещеры стенаний", 1}
        },
        size = 5,
        difficulty = 2,
        patterns = {
            "пещеры" .. csep .. "стенаний" .. csep .. "",
            "" .. csep .. "пс",
            "%[?Пещеры" .. csep .. "Стенаний%]?" .. csep .. "?",
            "пещеры" .. csep .. "стенаний",
        }
    },
    {
        raidName = "Крепость Темного Клыка",
        instanceName = {
            {"Крепость Темного Клыка", 1}
        },
        size = 5,
        difficulty = 2,
        patterns = {
            "крепость" .. csep .. "темного" .. csep .. "клыка" .. csep .. "",
            "" .. csep .. "ктк",
            "%[?Крепость" .. csep .. "Темного" .. csep .. "Клыка%]?" .. csep .. "?",
            "крепость" .. csep .. "темного" .. csep .. "клыка",
        }
    },
    {
        raidName = "Лабиринты Иглошкурых",
        instanceName = {
            {"Лабиринты Иглошкурых", 1}
        },
        size = 5,
        difficulty = 2,
        patterns = {
            "лабиринты" .. csep .. "иглошкурых" .. csep .. "",
            "" .. csep .. "ли",
            "" .. csep .. "ЛИ",
            "%[?Лабиринты" .. csep .. "Иглошкурых%]?" .. csep .. "?",
            "лабиринты" .. csep .. "иглошкурых",
        }
    },
    {
        raidName = "Монастырь Алого Ордена",
        instanceName = {
            {"Монастырь Алого Ордена", 1}
        },
        size = 5,
        difficulty = 2,
        patterns = {
            "монастырь" .. csep .. "алого" .. csep .. "ордена" .. csep .. "",
            "" .. csep .. "мао",
            "МАО" .. csep .."",
            "%[?Монастырь" .. csep .. "Алого" .. csep .. "Ордена%]?" .. csep .. "?",
            "монастырь" .. csep .. "алого" .. csep .. "ордена",
        }
    },
    {
        raidName = "Зул'Фаррак",
        instanceName = {
            {"Зул'Фаррак", 1}
        },
        size = 5,
        difficulty = 2,
        patterns = {
            "зул'фаррак" .. csep .. "",
            "зф" .. csep .. "",
            "" .. csep .. "зул'фаррак",
            "%[?Зул'Фаррак%]?" .. csep .. "?",
            "зул'фаррак",
        }
    },
    {
        raidName = "Аметистовая крепость",
        instanceName = {
            {"Аметистовая крепость", 1}
        },
        size = 5,
        difficulty = 2,
        patterns = {
            "аметистовая" .. csep .. "крепость" .. csep .. "",
            "%[?Аметистовая" .. csep .. "крепость%]?" .. csep .. "?",
            "аметистовая" .. csep .. "крепость",
        }
    },
    {
        raidName = "Глубины Черной горы",
        instanceName = {{"Глубины Черной горы", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "глубины"..csep.."черной"..csep.."горы"..csep.."",
            "гчг"..csep.."",
            ""..csep.."гчг",
            "%[?Глубины"..csep.."Черной"..csep.."горы%]?"..csep.."?"
        }
    },
    {
        raidName = "Нижняя часть пика черной горы",
        instanceName = {{"Нижняя часть пика черной горы", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "нижняя"..csep.."черной"..csep.."горы"..csep.."",
            "гчг"..csep.."",
            "%[?Нижняя"..csep.."Черной"..csep.."горы%]?"..csep.."?"
        }
    },
    {
        raidName = "Гномреган",
        instanceName = {{"Гномреган", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "гномреган"..csep.."",
            ""..csep.."гномреган",
            "%[?Гномреган%]?"..csep.."?"
        }
    },
    {
        raidName = "Забытый город",
        instanceName = {{"Забытый город", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "забытый"..csep.."город"..csep.."",
            "%[?Забытый"..csep.."Город%]?"..csep.."?"
        }
    },
    {
        raidName = "Курганы Иглошкурых",
        instanceName = {{"Курганы Иглошкурых", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "курганы"..csep.."иглошкурых"..csep.."",
            ""..csep.."курганы",
            ""..csep.."ки",
            ""..csep.."КИ",
            "%[?Курганы"..csep.."Иглошкурых%]?"..csep.."?"
        }
    },
    {
        raidName = "Мародон",
        instanceName = {{"Мародон", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "мародон"..csep.."",
            ""..csep.."мародон",
            "%[?Мародон%]?"..csep.."?"
        }
    },
    {
        raidName = "Мертвые копи",
        instanceName = {{"Мертвые копи", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "мертвые"..csep.."копи"..csep.."",
            "%[?Мертвые"..csep.."копи%]?"..csep.."?"
        }
    },
    {
        raidName = "Некроситет",
        instanceName = {{"Некроситет", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "некроситет"..csep.."",
            ""..csep.."некроситет",
            "%[?Некроситет%]?"..csep.."?"
        }
    },
    {
        raidName = "Непроглядная пучина",
        instanceName = {{"Непроглядная пучина", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "непроглядная"..csep.."пучина"..csep.."",
            ""..csep.."нп",
            ""..csep.."НП",
            "%[?Непроглядная"..csep.."Пучина%]?"..csep..""
        }
    },
    {
        raidName = "Стратхольм",
        instanceName = {{"Стратхольм", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "стратхольм"..csep.."",
            ""..csep.."стратхольм",
            "%[?Стратхольм%]?"..csep.."?"
        }
    },
    {
        raidName = "Ульдаман",
        instanceName = {{"Ульдаман", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "ульдаман"..csep.."",
            ""..csep.."ульдаман",
            "%[?Ульдаман%]?"..csep.."?"
        }
    },
    {
        raidName = "Храм Атал'Хаккара",
        instanceName = {{"Храм Атал'Хаккара", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "храм"..csep.."атал'хаккара"..csep.."",
            "%[?Храм"..csep.."Атал'Хаккара%]?"..csep.."?"
        }
    },

    -- Подземелья Burning Crusade
    {
        raidName = "Аркатрац",
        instanceName = {{"Аркатрац", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "аркатрац"..csep.."",
            ""..csep.."аркатрац",
            "%[?Аркатрац%]?"..csep.."?"
        }
    },
    {
        raidName = "Аукенайские Гробницы",
        instanceName = {{"Аукенайские Гробницы", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "аукенайские"..csep.."гробницы"..csep.."",
            "%[?Аукенайские"..csep.."гробницы%]?"..csep.."?"
        }
    },
    {
        raidName = "Бастионы Адского Пламени",
        instanceName = {{"Бастионы Адского Пламени", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "бастионы"..csep.."адского"..csep.."пламени"..csep.."",
            ""..csep.."бастионы",
            "%[?Бастионы"..csep.."Адского"..csep.."Пламени%]?"..csep.."?"
        }
    },
    {
        raidName = "Ботаника",
        instanceName = {{"Ботаника", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "ботаника"..csep.."",
            ""..csep.."ботаника",
            "%[?Ботаника%]?"..csep.."?"
        }
    },
    {
        raidName = "Гробницы Маны",
        instanceName = {{"Гробницы Маны", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "гробницы"..csep.."маны"..csep.."",
            "%[?Гробницы"..csep.."Маны%]?"..csep.."?"
        }
    },
    {
        raidName = "Кузня Крови",
        instanceName = {{"Кузня Крови", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "кузня"..csep.."крови"..csep.."",
            ""..csep.."кузня",
            "%[?Кузня"..csep.."Крови%]?"..csep.."?"
        }
    },
    {
        raidName = "Механар",
        instanceName = {{"Механар", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "механар"..csep.."",
            ""..csep.."механар",
            "%[?Механар%]?"..csep.."?"
        }
    },
    {
        raidName = "Нижетопь",
        instanceName = {{"Нижетопь", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "нижетопь"..csep.."",
            ""..csep.."нижетопь",
            "%[?Нижетопь%]?"..csep.."?"
        }
    },
    {
        raidName = "Паровое Подземелье",
        instanceName = {{"Паровое Подземелье", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "паровое"..csep.."подземелье"..csep.."",
            "%[?Паровое"..csep.."подземелье%]?"..csep.."?"
        }
    },
    {
        raidName = "Разрушенные залы",
        instanceName = {{"Разрушенные залы", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "разрушенные"..csep.."залы"..csep.."",
            "%[?Разрушенные"..csep.."залы%]?"..csep.."?"
        }
    },
    {
        raidName = "Сетеккские залы",
        instanceName = {{"Сетеккские залы", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "сетеккские"..csep.."залы"..csep.."",
            "%[?Сетеккские"..csep.."залы%]?"..csep.."?"
        }
    },
    {
        raidName = "Старые предгорья Хилсбрада",
        instanceName = {{"Старые предгорья Хилсбрада", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "старые"..csep.."предгорья"..csep.."хилсбрада"..csep.."",
            "%[?Старые"..csep.."предгорья"..csep.."Хилсбрада%]?"..csep.."?"
        }
    },
    {
        raidName = "Темный лабиринт",
        instanceName = {{"Темный лабиринт", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "темный"..csep.."лабиринт"..csep.."",
            "%[?Темный"..csep.."лабиринт%]?"..csep.."?"
        }
    },
    {
        raidName = "Узилище",
        instanceName = {{"Узилище", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "узилище"..csep.."",
            ""..csep.."узилище",
            "%[?Узилище%]?"..csep.."?"
        }
    },
    {
        raidName = "Черные топи",
        instanceName = {{"Черные топи", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "черные"..csep.."топи"..csep.."",
            "%[?Черные"..csep.."топи%]?"..csep.."?"
        }
    },

    -- Подземелья Wrath of the Lich King
    {
        raidName = "Азжол-Неруб",
        instanceName = {{"Азжол-Неруб", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "азжол-неруб"..csep.."",
            ""..csep.."азжол",
            "%[?Азжол-Неруб%]?"..csep.."?"
        }
    },
    {
        raidName = "Ан'Кахет: Старое Королевство",
        instanceName = {{"Ан'Кахет: Старое Королевство", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "ан'кахет"..csep.."старое"..csep.."королевство"..csep.."",
            "%[?Ан'кахет"..csep.."старое"..csep.."королевство%]?"..csep.."?"
        }
    },
    {
        raidName = "Вершина Утгарда",
        instanceName = {{"Вершина Утгарда", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "вершина"..csep.."утгарда"..csep.."",
            ""..csep.."вершину",
            "%[?Вершина"..csep.."Утгарда%]?"..csep.."?"
        }
    },
    {
        raidName = "Гундрак",
        instanceName = {{"Гундрак", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "гундрак"..csep.."",
            ""..csep.."гундрак",
            "%[?Гундрак%]?"..csep.."?"
        }
    },
    {
        raidName = "Крепость Драк'Тарон",
        instanceName = {{"Крепость Драк'Тарон", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "крепость"..csep.."драк'тарон"..csep.."",
            "%[?крепость"..csep.."Драк'Тарон%]?"..csep.."?"
        }
    },
    {
        raidName = "Крепость Утгарда",
        instanceName = {{"Крепость Утгарда", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "крепость"..csep.."утгарда"..csep.."",
            ""..csep.."крепость",
            "%[?Крепость"..csep.."Утгарда%]?"..csep.."?"
        }
    },
    {
        raidName = "Нексус",
        instanceName = {{"Нексус", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "нексус"..csep.."",
            ""..csep.."нексус",
            "%[?Нексус%]?"..csep.."?"
        }
    },
    {
        raidName = "Очищение Стратхольма",
        instanceName = {{"Очищение Стратхольма", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "очищение"..csep.."стратхольма"..csep.."",
            "%[?Очищение"..csep.."Стратхольма%]?"..csep.."?"
        }
    },
    {
        raidName = "Чертоги Камня",
        instanceName = {{"Чертоги Камня", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "чертоги"..csep.."камня"..csep.."",
            ""..csep.."чертоги",
            "%[?Чертоги"..csep.."Камня%]?"..csep.."?"
        }
    },
    {
        raidName = "Чертоги Молний",
        instanceName = {{"Чертоги Молний", 1}},
        size = 5,
        difficulty = 2,
        patterns = {
            "чертоги"..csep.."молний"..csep.."",
            "%[?Чертоги"..csep.."Молний%]?"..csep.."?"
        }
    },
}
