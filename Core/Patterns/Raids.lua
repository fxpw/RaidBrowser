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

E.Patterns.Raids = {
    { -- фул охота 25
        raidName = "Охота",
        instanceName = {
            {"Логово Магтеридона",1},
            {"Логово Груула",1},
            {"Испытание крестоносца",2},
            {"Логово Ониксии",2},
        },
        size = 25,
        difficulty = 2,
        patterns = {
            "охота на великих чудовищ",
            "%[?охота на великих чудовищ%]?"..csep.."на"..csep.."фул",
            "%[?охота на великих чудовищ%]?"..csep.."25"..csep.."на"..csep.."фул",
            "%[?охота на великих чудовищ%]?"..csep.."25",
            "%[?охота на великих чудовищ%]?"..csep.."фул",
			"%[?охота на великих чудовищ%]?",
			"охота на великих чудовищ",
            "фул"..csep.."охота",
            "на"..csep.."фул"..csep.."охоту",
            "фаст"..csep.."охота",
            "охота"..csep.."фул",
			"охота",
			"охота"..csep.."по"..csep.."фулу",
            -- "на"..csep.."охоту",
            }
    },
    { -- гм хм
		raidName = "Г/М хм",
		instanceName = {
            {"Логово Магтеридона", 2},
            {"Логово Груула", 2},
        },
		size = 25,
		difficulty = 4,
        patterns = {
            "м"..csep.."г"..csep.."хм",
            "г"..csep.."м"..csep.."хм",
            "магик/грул"..csep.."хм",
            "магик/грул"..csep.."гер",
            "гм"..csep.."гер",
            "мг"..csep.."гер",
            "мг"..csep.."хм",
            "м%/г"..csep.."хм",
            "г%/м"..csep.."хм",
            "г%/м"..csep.."гер",
            "м%/г"..csep.."гер",
            "м"..csep.."г"..csep.."гер",
            "мг"..csep.."хм",
            "магик"..csep.."грул"..csep.."25хм",
            "магик"..csep.."грул"..csep.."25"..csep.."хм",
            "магик"..csep.."грул"..csep.."25гер",
            "магик"..csep.."грул"..csep.."25"..csep.."гер",
            "гм"..csep.."хм",
            "грул%/магик"..csep.."хм",
            "грул"..csep.."магик"..csep.."хм",
        }
    },
	{ -- гм об
        raidName = "Г/М об",
        instanceName = {
            {"Логово Магтеридона", 1},
            {"Логово Груула", 1},
        },
        size = 25,
        difficulty = 1,
        patterns = {
			"м"..csep.."г"..csep.."25"..csep.."об",
            "м"..csep.."г"..csep.."об",
            "г"..csep.."м"..csep.."об",
            "м"..csep.."и"..csep.."г"..csep.."об",
            "м"..csep.."и"..csep.."г",
			-- "логово"..csep.."груула"..csep.."25"..csep.."об",
			"логово"..csep.."груула"..csep.."логово"..csep.."магтеридона",
            "гм"..csep.."об",
            "груул%/магик"..csep.."об",
            "мг"..csep.."об",
            "магик%/грул",
            "м%/г"..csep.."об",
            "г%/м"..csep.."об",
            "мг"..csep.."%(об%)",
            "мг%(об%)",
            "магик"..csep.."грул",
            "в"..csep.."мг",
            "гм"..csep.."нид",
        }
	},
	{ -- ик оня 25
        raidName = "Ик/Оня 25",
        instanceName = {
            {"Испытание крестоносца", 2},
            {"Логово Ониксии", 2},
        },
        size = 25,
        difficulty = 2,
        patterns = {
            "ик"..csep.."оня"..csep.."25",
			"ик"..csep.."оня"..csep.."25"..csep.."об",
			"ик\\оня"..csep.."25"..csep.."об",
            "оня"..csep.."ик"..csep.."25",
            "ик"..csep.."оня"..csep.."об",
            "оня"..csep.."ик"..csep.."об",
        }
	},
	{ -- ик оня 10
        raidName = "Ик/Оня 10",
        instanceName = {
            {"Испытание крестоносца", 1},
            {"Логово Ониксии", 1},
        },
        size = 10,
        difficulty = 1,
        patterns = {
            "ик"..csep.."оня"..csep.."10",
            "ик/оня"..csep.."10",
            "ик\\оня"..csep.."10",
            "оня"..csep.."ик"..csep.."10",
            "ик"..csep.."оня"..csep.."об",
            "оня"..csep.."ик"..csep.."об",
        }
	},
	{ -- Хиджал
		raidName = "Хиджал(реп)",
		instanceName = {
			{"Битва за гору Хиджал", 1},
		},
		size = 25,
		difficulty = 1,
		patterns = {
            "хиджал"..csep.."репофарм",
            "репофарм"..csep.."хиджал",
            -- "хиджал",
        }
	},
	{ -- магик хм
		raidName = "Магтеридон(хм)",
		instanceName = {
			{"Логово Магтеридона", 4},
		},
		size = 25,
		difficulty = 4,
		patterns = {
			"магик"..csep.."25"..csep.."хм",
			"магик"..csep.."25"..csep.."гер",
            "магик"..csep.."хм",
            "магик"..csep.."гер",
            -- "м"..csep.."хм",
            -- "г"..csep.."гер",
            "%[?логово магтеридона%]?"..csep.."хм",
            "%[?логово магтеридона%]?"..csep.."гер",
            -- "%[?охота на великих чудовищ%]?"..csep.."хм",
            -- "%[?охота на Великих чудовищ%]?"..csep.."гер",

        }

	},
	{ -- магик об
		raidName = "Магтеридон(об)",
		instanceName = {
			{"Логово Магтеридона", 1},
		},
		size = 25,
		difficulty = 1,
		patterns = {
			"магик"..csep.."25"..csep.."об",
            "магик"..csep.."об",
            "магик",
            "только"..csep.."магик",
            "%[?логово магтеридона%]?"..csep.."об",
			"%[?логово магтеридона%]?",
            -- "фул"..csep.."%[?охота на великих чудовищ%]?",
            -- "на"..csep.."фул"..csep.."%[?охота на великих чудовищ%]?",
            -- "%[?охота на великих чудовищ%]?",
        }
	},
	{ -- грул хм
		raidName = "Груул(хм)",
		instanceName = {
			{"Логово Груула", 2},
		},
		size = 25,
		difficulty = 4,
		patterns ={
            "грул"..csep.."хм",
            "груул"..csep.."хм",
            "грулл"..csep.."хм",
            "грул"..csep.."гер",
            "груул"..csep.."гер",
            "грулл"..csep.."гер",
            "%[?логово груула%]?"..csep.."хм",
            "%[?логово груула%]?"..csep.."гер",
            "г"..csep.."хм",
        }
	},
	{ -- грул об
		raidName = "Груул(об)",
		instanceName = {
			{"Логово Груула", 1},
		},
		size = 25,
		difficulty = 1,
		patterns = {
            "грул"..csep.."об",
            "груул"..csep.."об",
            "грулл"..csep.."об",
            "грул",
            "груул",
            "грулл",
            "на"..csep.."грула",
            "на"..csep.."грулла",
            "на"..csep.."груула",
            -- "закрыть"..csep.."охоту",
            "%[?логово груула%]?"..csep.."об",
            "%[?логово груула%]?"..csep.."кто"..csep.."не",
        }
	},


	{ -- снeговик
		raidName = "Снеговик",
		instanceName = {
			{"Логово замёрзшего снеговика", 1}
		},
		size = 5,
		difficulty = 1,
		patterns = {
            "на"..csep.."снеговика",
            "снеговик",
            "%[?логово замёрзшего снеговика%]?",
            "%[?снежный доспех%]?",
        }
	},

	{ -- контр + эттин
		raidName = "Контракты",
		instanceName = {
			{"Черные топи", 1}
		},
		size = 5,
		difficulty = 2,
		patterns =
			{
				"контракты",
				"эттины",
				"контры",
				"контракты",
				"эттины",
				"элит"..csep.."тг"..csep.."место",
				"элит"..csep.."тг"..csep.."места",
				"на"..csep.."элиток",
				"на"..csep.."эллиток",
				"элитки"..csep.."тг",
				"элитки"..csep.."ттг",
				"эттг",
				"этг",
				"тг"..csep.."элитки",
				"контракты"..csep.."%+"..csep.."эттины",
				"контракты"..csep.."%+"..csep.."этины",
				"эттины"..csep.."%+"..csep.."контракты",
			}
	},
	{ -- норигорн
		raidName = "Норигорн",
		instanceName = {
			{"Черные топи", 1}
		},
		size = 5,
		difficulty = 2,
		patterns = {
            "норигорна",
            "норигорн",
            "на"..csep.."норигорна",
            "на норика",
			"норик",
            "Обуздать твердыню",
            "обуздать твердыню",
        }
	},
	{ -- рбк
		raidName = "РБК",
		instanceName = {
			{"Черные топи", 1}
		},
		size = 5,
		difficulty = 2,
		patterns = {
            "нрбк",
            "рбк",
            "н"..csep.."рбк",
            "три"..csep.."рбк",
            "онли"..csep.."нрбк",
            "темный"..csep.."лабиринт",
            "собираю"..csep.."рбк",
            "собераю"..csep.."рбк",
			"рбк"..csep.."7/7",
			"рбк"..csep.."7\\7",
            "собераю"..csep.."в"..csep.."рбк",
            "собераю"..csep.."на"..csep.."3"..csep.."рбк",
            "собераю"..csep.."на"..csep.."три"..csep.."рбк",
            "собераю"..csep.."на"..csep.."3"..csep.."нрбк",
            "собираю"..csep.."на"..csep.."три"..csep.."рбк",
            "собираю"..csep.."на"..csep.."3"..csep.."рбк",
            "собираю"..csep.."на"..csep.."три"..csep.."нрбк",
            "собираю"..csep.."на"..csep.."3"..csep.."нрбк",
            "н"..csep.."р"..csep.."б"..csep.."к",
            "собираю"..csep.."в"..csep.."рбк",
            "в"..csep.."нрбк",
            "на"..csep.."3"..csep.."рбк",
            "на"..csep.."3"..csep.."нрбк",

        }
	},

	{ -- рлк
		raidName = "РЛК",
		instanceName = {
			{"Испытание чемпиона", 1}
		},
		size = 5,
		difficulty = 2,
		patterns ={
            "рлк"..csep.."гер",
            "в"..csep.."залы",
            "в "..csep.."кузню",
            "в"..csep.."яму",
            "3рлк",
            "3"..csep.."рлк",
            "на"..csep.."3"..csep.."рлк",
        }
	},

	{ -- 5 ката
		raidName = "5 ката",
		instanceName = {
			{"Испытание чемпиона", 1}
		},
		size = 5,
		difficulty = 2,
		patterns =	{
			"5"..csep.."ката",
			"на"..csep.."5"..csep.."кату",
			"5"..csep.."категория",
			"на"..csep.."5"..csep.."категорию",
			"%[?5 категория%]",
			"на"..csep.."%[?5 категория%]",
        }
	},

	{ -- 4 ката
		raidName = "4 ката",
		instanceName = {
			{"Испытание чемпиона", 1}
		},
		size = 5,
		difficulty = 2,
		patterns = {
			"4"..csep.."ката",
			"на"..csep.."4"..csep.."кату",
			"4"..csep.."категория",
			"на"..csep.."4"..csep.."категорию",
			"%[?4 категория%]?",
			"на"..csep.."%[?4 категория%]?",
        }
	},
	{ -- 3 ката
		raidName = "3 ката",
		instanceName = {
			{"Испытание чемпиона", 1}
		},
		size = 5,
		difficulty = 2,
		patterns = {
			"3"..csep.."ката",
			"на"..csep.."3"..csep.."кату",
			"3"..csep.."категория",
			"на"..csep.."3"..csep.."категорию",
			"%[?3 категория%]?",
			"на"..csep.."%[?3 категория%]?",
        }
	},
	{ -- 2 ката
		raidName = "2 ката",
		instanceName = {
			{"Испытание чемпиона", 1}
		},
		size = 5,
		difficulty = 2,
		patterns = {
			"2"..csep.."ката",
			"на"..csep.."2"..csep.."кату",
			"2"..csep.."категория",
			"на"..csep.."2"..csep.."категорию",
			"%[?2 категория%]?",
			"на"..csep.."%[?2 категория%]?",

        }
	},

	{ -- 1 ката
		raidName = "1 ката",
		instanceName = {
			{"Испытание чемпиона", 1}
		},
		size = 5,
		difficulty = 2,
		patterns = {
			"1"..csep.."ката",
			"на"..csep.."1"..csep.."кату",
			"1"..csep.."категория",
			"на"..csep.."1"..csep.."категорию",
			"%[?1 категория%]?",
			"на"..csep.."%[?1 категория%]?",
        }
	},

	{ -- цлк10хм
		raidName = "ЦЛК 10 хм",
		instanceName = {
			{"Цитадель Ледяной Короны",2}
		},
		size = 10,
		difficulty = 3,
		patterns = {
            "лич"..csep.."цлк"..csep.."10"..csep.."хм",
            "цлк"..csep.."10"..csep.."хм",
			"цлк"..csep.."10"..csep.."гер",
            "на"..csep.."лича"..csep.."10"..csep.."хм",
            "на"..csep.."лича"..csep.."цлк"..csep.."10"..csep.."хм",
            "%[?цитадель ледяной короны%]?"..csep.."10"..csep.."хм",
            "%[?цитадель ледяной короны%]?"..csep.."10"..csep.."гер",
        }
	},

	{ -- цлк25хм
		raidName = "ЦЛК 25 хм",
		instanceName = {
			{"Цитадель Ледяной Короны",4}
		},
		size = 25,
		difficulty = 4,
		patterns = {
            "лич"..csep.."цлк"..csep.."25"..csep.."хм",
            "лич"..csep.."цлк"..csep.."25"..csep.."гер",
            "цлк"..csep.."25"..csep.."хм",
            "цлк"..csep.."25"..csep.."гер",
            "в"..csep.."цлк"..csep.."25"..csep.."хм",
            "в"..csep.."цлк"..csep.."25"..csep.."гер",
            "лич"..csep.."25"..csep.."хм",
            "лич"..csep.."25"..csep.."гер",
            "на"..csep.."лича"..csep.."25"..csep.."хм",
            "на"..csep.."лича"..csep.."25"..csep.."гер",
            "на"..csep.."лича"..csep.."цлк"..csep.."25"..csep.."хм",
            "на"..csep.."лича"..csep.."цлк"..csep.."25"..csep.."гер",
            "%[?цитадель ледяной короны%]?"..csep.."25"..csep.."хм",
            "%[?цитадель ледяной короны%]?"..csep.."25"..csep.."гер",
        }
	},

	{ -- цлк10об
		raidName = "ЦЛК 10 об",
		instanceName = {
			{"Цитадель Ледяной Короны",1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
            "лич"..csep.."цлк"..csep.."10",
            "цлк"..csep.."10"..csep.."об",
			"цлк"..csep.."10",
            "цлк"..csep.."10"..csep.."репа",
            "цлк"..csep.."репа",
            "цлк"..csep.."репофарм",
            "репофарм"..csep.."цлк",
            "лич"..csep.."10"..csep.."об",
            "%[?слава рейдеру ледяной короны %(10 игроков%)%]?",
            "%[?чума нежизни%]?"..csep.."10"..csep.."об",
            "%[?чума нежизни%]?"..csep.."10",
            "%[?чума нежизни%]?",
            "%[?цитадель ледяной короны%]?" ..csep.. "10",
            "%[?падение короля%-лича %(10 игроков%)%]?",
		}
	},

	{ -- цлк25об
		raidName = "ЦЛК 25 об",
		instanceName = {
			{"Цитадель Ледяной Короны",2}
		},
		size = 25,
		difficulty = 2,
		patterns = {
            "лич"..csep.."цлк"..csep.."25",
            "лич"..csep.."25"..csep.."об",
            "цлк"..csep.."25"..csep.."об",
            "цлк"..csep.."%("..csep.."25"..csep.."об"..csep.."%)",
            "цлк"..csep.."25об",
			"цлк"..csep.."25",
            "%[?цитадель ледяной короны%]?"..csep.."25",
        }
	},
	{ -- ттг10
		raidName = "ТТГ 10",
		instanceName = {
			{"Тол'Гародская тюрьма",1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
            "ттг"..csep.."10",
            "тюрьма 10"..csep.."10",
		}
	},

	{ -- ттг25
		raidName = "ТТГ 25",
		instanceName = {
			{"Тол'Гародская тюрьма",2}
		},
		size = 25,
		difficulty = 3,
		patterns = {
            "ттг"..csep.."25",
            "тюрьма 10"..csep.."25",
		}
	},

	{ -- ульда 10 хм
		raidName = "Ульда 10 хм",
		instanceName = {
			{"Ульдуар",3}
		},
		size = 10,
		difficulty = 3,
		patterns = {
            "ульда"..csep.."10"..csep.."хм",
            "ульд"..csep.."10"..csep.."хм",
            "ульд"..csep.."10"..csep.."гер",
            "ульда"..csep.."10"..csep.."гер",
            "в"..csep.."ульду"..csep.."10"..csep.."гер",
            "в"..csep.."ульду"..csep.."10"..csep.."хм",
            "ульда10хм",
            "утюг"..csep.."10"..csep.."хм",
            "утюг"..csep.."10",
            "на"..csep.."утюга"..csep.."в"..csep.."ульду"..csep.."10",
            "%[?ульдуар%]?"..csep.."10"..csep.."хм",
            "%[?генерал везакс%]?"..csep.."10",
            "%[?йогг%-сарон%]?"..csep.."10",
            "%[?ульдуар%]?"..csep.."10"..csep.."гер",
        }
	},

	{ -- ульда10
		raidName = "Ульда 10 об",
		instanceName = {
			{"Ульдуар",1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
			"ульда"..csep.."10",
			"ульд"..csep.."10",
			"ульдар"..csep.."10",
			"ульдуар"..csep.."10",
			"в"..csep.."ульду"..csep.."10",
			"в"..csep.."ульду"..csep.."10",
			"%[?слава рейдеру ульдуара %(10 игроков%)%]?",
			"%[?защитник ульдуара%]?",
			"%[?посланник титанов%]?",
			"%[?ульдуар%]?"..csep.."10"..csep.."об",
			"%[?ульдуар%]?"..csep.."10",
		},
	},


	{ -- ульда25 хм
		raidName = "Ульда 25 хм",
		instanceName = {
			{"Ульдуар",4}
		},
		size = 25,
		difficulty = 4,
		patterns = {
            "ульда"..csep.."25"..csep.."хм"..csep.."на",
            "ульд"..csep.."25"..csep.."хм",
            "ульд"..csep.."25"..csep.."гер",
			"ульда"..csep.."25"..csep.."гер",
			"ульда"..csep.."25"..csep.."хм",
            "ульда"..csep.."10%-25"..csep.."хм",
            "ульда"..csep.."10%-25"..csep.."гер",
            -- "в"..csep.."ульду"..csep.."на"..csep.."утюга",
            -- "в"..csep.."ульду"..csep.."25"..csep.."на"..csep.."утюга",
            "утюг"..csep.."ульда"..csep.."хм",
            "утюг"..csep.."ульда"..csep.."гер",
            "утюг"..csep.."25"..csep.."хм",
            -- "на"..csep.."утюга"..csep.."25",
            "на"..csep.."утюга"..csep.."в"..csep.."ульду"..csep.."25"..csep.."хм",
            -- "в"..csep.."ульду"..csep.."25",
            "%[?ульдуар%]?"..csep.."25"..csep.."хм",
            "%[?ульдуар%]?"..csep.."25"..csep.."гер",
        }
	},


	{ -- ульда25
		raidName = "Ульда 25 об",
		instanceName = {
			{"Ульдуар",2}
		},
		size = 25,
		difficulty = 2,
		patterns = {
			"ульда"..csep.."25"..csep.."на",
			"ульда"..csep.."25",
			"ульдуар"..csep.."25",
			"утюг"..csep.."ульда",
			"на"..csep.."утюга"..csep.."в"..csep.."ульду",
			"в"..csep.."ульду"..csep.."25",
			"%[?слава рейдеру ульдуара %(25 игроков%)%]?",
			"%[?завоеватель ульдуара%]?",
			"%[?ульдуар%]?"..csep.."25",
        }
	},

	{ -- ос10
        raidName = "Ос 10",
		instanceName = {
			{"Обсидиановое святилище",1}
		},
        size = 10,
        difficulty = 1,
        patterns = {
            "в"..csep.."ос"..csep.."10",
            "ос"..csep.."10",
            "ос"..csep.."10"..csep.."на"..csep.."%+"..csep.."3",
            "в"..csep.."ос"..csep.."на"..csep.."%+"..csep.."3",
            "%[?сартарион должен умереть%!?%]?",
            "%[?обсидиановое святилище%]?"..csep.."10",
        }
	},

	{ -- ос25
		raidName = "Ос 25",
		instanceName = {
			{"Обсидиановое святилище",2}
		},
		size = 25,
		difficulty = 2,
		patterns = {
            "в"..csep.."ос"..csep.."25",
            "ос"..csep.."25"..csep.."на"..csep.."%+"..csep.."3",
            "ос"..csep.."25",
            "%[?Обсидиановое святилище%]?"..csep.."25",
            "%[?меньше – не значит хуже %(25 игроков%)%]?",
        }
	},

	{ -- накс10
		raidName = "Накс 10",
		instanceName = {
			{"Наксрамас",1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
			"накс"..csep.."10",
			"на"..csep.."неуяз",
			"%наксрамас%]?"..csep.."10",
			"%[?ануб\"рекан должен умереть%!?%]?",
			"%[?нот чумной должен умереть%!?%]?",
			"%[?инструктор разувий должен умереть%!?%]?",
			"%[?лоскутик должен умереть%!?%]?",
		},
	},

	{ -- накс25
		raidName = "Накс 25",
		instanceName = {
			{"Наксрамас",2}
		},
		size = 25,
		difficulty = 2,
		patterns = {
			"накс"..csep.."25",
			"бессмертный",
			"на"..csep.."бессмертного",
			"%[?наксрамас%]?"..csep.."25",
			"%[?ануб\"рекан должен умереть%!?%]?"..csep.."25",
			"%[?нот чумной должен умереть%!?%]?"..csep.."25",
			"%[?инструктор разувий должен умереть%!?%]?"..csep.."25",
			"%[?лоскутик должен умереть%!?%]?"..csep.."25",
		},
	},


	{ -- око хм
		raidName = "Око хм",
		instanceName = {
			{"Крепость Бурь",4}
		},
		size = 25,
		difficulty = 4,
		patterns = {
            "%[?око%]?"..csep.."хм",
            "%[?око%]?"..csep.."гер",
            "в"..csep.."око"..csep.."хм",
            "в"..csep.."око"..csep.."хм"..csep.."нуля",
        }
	},

	{ -- око
		raidName = "Око об",
		instanceName = {
			{"Крепость Бурь", 1}
		},
		size = 25,
		difficulty = 1,
		patterns = {
            "в"..csep.."око"..csep.."об",
            "в"..csep.."око"..csep.."об"..csep.."нуля",
            "око"..csep.."об",

        }
	},

	{ -- зс хм
		raidName = "Зс хм",
		instanceName = {
			{"Кривой Клык: Змеиное святилище", 4}
		},
		size = 25,
		difficulty = 4,
		patterns = {
            "зс"..csep.."хм",
            "в"..csep.."зс"..csep.."хм",
            "%[?змеиное святилище%]?"..csep.."хм",
            "%[?змеиное святилище%]?"..csep.."гер",
        }
	},

	{ -- зс
		raidName = "Зс об",
		instanceName = {
			{"Кривой Клык: Змеиное святилище", 1}
		},
		size = 25,
		difficulty = 1,
		patterns = {
			"зс"..csep.."об",
			"зс"..csep.."%(об%)",
			"зс",
			"вайши",
			"каратрес",
			"зс"..csep.."от",
			"в"..csep.."зс"..csep.."от",
			"в"..csep.."зс"..csep.."об",
			"зс"..csep.."об"..csep.."время на сбор",
			"%[?змеиное святилище%]?"..csep.."об",
			"%[?змеиное святилище%]?",
        }
	},

	{ -- за
		raidName = "ЗА",
		instanceName = {
			{"Зул'Аман", 1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
            "за"..csep.."об",
            "в"..csep.."за",
			"3"..csep.."+3",
			"3"..csep.."3+",
            "за%+3",
            "за"..csep.."%+"..csep.."3",
            "за"..csep.."нид",
            "на"..csep.."3"..csep.."сундука",
            "на"..csep.."4%+"..csep.."сундука",
            "3"..csep.."сундука",
            "сундука",
            "%[?зул'аман%]?",
			"зул'аман",
            "%[?мщение амани%]?",
        }
	},

	{ -- ивк10
		raidName = "Ивк 10",
		instanceName = {
			{"Испытание крестоносца", 3}
		},
		size = 10,
		difficulty = 3,
		patterns = {
            "ивк"..csep.."10",
            "%[?дань фанатичному безумию%]?",
            "%[?призыв великого крестоносца %(10 игроков%)%]?",
            "%[?испытание крестоносца%]?"..csep.."10"..csep.."гер",
            "%[?испытание крестоносца%]?"..csep.."10"..csep.."хм",
        }
	},

	{ -- ивк25
		raidName = "Ивк 25",
		instanceName = {
			{"Испытание крестоносца", 4}
		},
		size = 25,
		difficulty = 4,
		patterns = {
            "ивк"..csep.."25",
            "%[?призыв великого крестоносца %(25 игроков%)%]?",
            "%[?испытание крестоносца%]?"..csep.."25"..csep.."гер",
            "%[?испытание крестоносца%]?"..csep.."25"..csep.."хм",
        }
	},

	{ -- ик10
		raidName = "Ик 10",
		instanceName = {
			{"Испытание крестоносца", 1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
			"%[?призыв авангарда %(10 игроков%)%]?",
			-- "ик"..csep.."оня"..csep.."10",
			-- "ик"..csep.."оню"..csep.."10",
			-- "ик"..csep.."оня"..csep.."10",
			-- "ик%/оня"..csep.."10",
			-- "иконя"..csep.."10",
			-- "ик"..csep.."и"..csep.."оня",
			-- "ик"..csep.."после"..csep.."они",
			-- "ик%+оня"..csep.."10",
			-- "ик%/оня"..csep.."10",
			-- "ик%/оня"..csep.."(10)",
			-- "ик%+оня"..csep.."(10)",
			-- "ик%/оня"..csep.."10",
			"ик"..csep.."10",
			"ик"..csep.."10"..csep.."об",
			"%[?испытание крестоносца%]?"..csep.."10"..csep.."об",
			"%[?испытание крестоносца%]?"..csep.."10",
			"%[?испытание крестоносца%]?",
			}
	},

	{ -- ик25
		raidName = "Ик 25",
		instanceName = {
			{"Испытание крестоносца", 2}
		},
		size = 25,
		difficulty = 2,
		patterns = {
			"%[?призыв авангарда %(25 игроков%)%]?",
			"%[?испытание крестоносца%]?"..csep.."25",
			"в"..csep.."ик"..csep.."25",
			"ик"..csep.."25",
			-- "фул"..csep.."охота"..csep.."25",
			-- "фул"..csep.."охота"..csep.."25об",
			-- "фул"..csep.."охота"..csep.."25"..csep.."об",
        }
	},

	{ -- рс10хм
		raidName = "Рс 10 хм",
		instanceName = {
			{"Рубиновое святилище", 3}
		},
		size = 10,
		difficulty = 3,
		patterns ={
			"рс"..csep.."10"..csep.."хм",
			"рс"..csep.."10"..csep.."гер",
			"%[?рубиновое святилище%]?"..csep.."10"..csep.."хм",
			"%[?рубиновое святилище%]?"..csep.."10"..csep.."гер",
        }
	},

	{ -- рс25хм
		raidName = "Рс 25 хм",
		instanceName = {
			{"Рубиновое святилище", 4}
		},
		size = 25,
		difficulty = 4,
		patterns = {
			"рс"..csep.."25"..csep.."хм",
			"рс"..csep.."25"..csep.."гер",
			"%[?рубиновое святилище%]?"..csep.."25"..csep.."хм",
			"%[?рубиновое святилище%]?"..csep.."25"..csep.."гер",
        }
	},

	{ -- рс10об
		raidName = "Рс 10 об",
		instanceName = {
			{"Рубиновое святилище", 1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
			"рс"..csep.."10"..csep.."об",
			"рс"..csep.."10",
			"%[?рубиновое святилище%]?"..csep.."10",
        }
	},

	{ -- рс25об
		raidName = "Рс 25 об",
		instanceName = {
			{"Рубиновое святилище", 2}
		},
		size = 25,
		difficulty = 2,
		patterns = {
			"рс"..csep.."25",
			"рс"..csep.."25"..csep.."об",
			"%[?рубиновое святилище%]?"..csep.."25",
        }
	},
	{ -- са25
        raidName = "СА 25",
		instanceName = {
			{"Склеп Аркавона", 2}
		},
        size = 25,
        difficulty = 2,
        patterns = {
            "са"..csep.."25",
            "склеп"..csep.."25",
            "с"..csep.."а"..csep.."25",
            "%[?склеп аркавона%]?"..csep.."25",
        },
    },
	{ -- са10
		raidName = "СА 10",
		instanceName = {
			{"Склеп Аркавона", 1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
			"са"..csep.."10",
			"склеп"..csep.."10",
			"с"..csep.."а"..csep.."10",
			"%[?склеп аркавона%]?"..csep.."10",
		},
	},

	{ -- оня25
		raidName = "Оня 25",
		instanceName = {
			{"Логово Ониксии", 2}
		},
		size = 25,
		difficulty = 2,
		patterns = {
			"оня"..csep.."25",
			"только"..csep.."оня"..csep.."25",
			"в"..csep.."оню"..csep.."25",
			"%[?логово ониксии%]?"..csep.."25",
		},
	},

	{ -- оня10
		raidName = "Оня 10",
		instanceName = {
			{"Логово Ониксии", 1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
			"оня"..csep.."10",
			"только"..csep.."оня"..csep.."10",
			"только"..csep.."оня",
			"на"..csep.."оню",
			"на"..csep.."оню"..csep.."10",
			"в"..csep.."оню"..csep.."10",
			"%[?логово ониксии%]?"..csep.."10",
		},
	},

	{ -- каражан хм
		raidName = "Кара хм",
		instanceName = {
			{"Каражан", 2}
		},
		size = 10,
		difficulty = 2,
		patterns = {
            "кара"..csep.."хм",
            "кара"..csep.."гер",
            "кара"..csep.."хм"..csep.."на"..csep.."гнева",
            "кару"..csep.."хм",
            "кара"..csep.."гер"..csep.."на"..csep.."гнева",
            "кару"..csep.."гер",
            "в"..csep.."кару"..csep.."хм",
            "в"..csep.."кару"..csep.."гер",
            "%[?каражан%]?"..csep.."гер",
            "%[?каражан%]?"..csep.."хм",
        }
	},

	{ -- каражан
		raidName = "Кара об",
		instanceName = {
			{"Каражан", 1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
            "кара"..csep.."об",
            "кара",
            "кару",
            "кара"..csep.."по"..csep.."токенам",
            "кару"..csep.."по"..csep.."токенам",
            "по"..csep.."токенам",
            "каражан"..csep.."по"..csep.."токенам",
            "%[?каражан%]?",
            "%[?каражан%]?"..csep.."об",
        }
	},

	{ -- огненные недра
		raidName = "Огненные Недра",
		instanceName = {
			{"Огненные Недра", 1}
		},
		size = 40,
		difficulty = 1,
		patterns = {
			"огненные"..csep.."недра",
			"он"..csep.."за"..csep.."транс",
			"%[?огненные недра%]?"
		},
	},

	{ -- ов 25
        raidName = "ОВ 25",
		instanceName = {
			{"Око Вечности", 2}
		},
        size = 25,
        difficulty = 2,
        patterns = {
            "в"..csep.."ов"..csep.."25",
            "ов"..csep.."25",
            "%[?око вечности%]?"..csep.."25",
        }
    },
	{ -- ов 10
		raidName = "ОВ 10",
		instanceName = {
			{"Око Вечности", 1}
		},
		size = 10,
		difficulty = 1,
		patterns = {
            "в"..csep.."ов"..csep.."10",
            "ов"..csep.."10",
            "%[?малигос должен умереть%!?%]?",
            "%[?око вечности%]?"..csep.."10",
        }
	},
	{ -- бс 25 хм
		raidName = "БС 25 хм",
		instanceName = {
			{"Бронзовое святилище", 2}
		},
		size = 25,
		difficulty = 2,
		patterns = {
            "бс"..csep.."25"..csep.."хм",
            "бс"..csep.."25"..csep.."гер",
            "в"..csep.."бс"..csep.."хм",
            "в"..csep.."бс"..csep.."гер",
            "%[?бронзовое святилище%]?"..csep.."хм",
            "%[?бронзовое святилище%]?"..csep.."гер",
        }
	},

	{ -- бс 25 об
		raidName = "БС 25 об",
		instanceName = {
			{"Бронзовое святилище", 1}
		},
		size = 25,
		difficulty = 1,
		patterns = {
            "в"..csep.."бс"..csep.."об",
            "бс"..csep.."об",
            "в"..csep.."бс",
            "%[?бронзовое святилище%]?",
            "%[?бронзовое святилище%]?"..csep.."об",
        }
	},
	{ -- на зорта
		raidName = "Зорт",
		instanceName = {
			{"Пустота зорта", 1}
		},
		size = 25,
		difficulty = 1,
		patterns =  {
            "на"..csep.."зорта",
            "зорт",
		}
	},

}