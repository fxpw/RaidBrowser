local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
-- local GUI = E.GUI
-- local Core = E.Core

E.GUI.Options.args.FourTab = {
    order = 5,
	type = "group",
	name = L["Frame Change Size Tab"],
	childGroups = "tree",
	get = function(info) return E.db[info[#info]] end,
	set = function(info, value)
		E.db[info[#info]] = value
		E.GUI:UpdateAllFramesSize()
	end,
    args = {
        CollapseFrameWidth = {
            order = 1,
            type = "range",
            min = 550, max = 900, step = 1,
            name = L["CollapseFrameWidth"],
            desc = L["CollapseFrameWidthdesc"],
		},
		CollapseFrameHeight = {
            order = 2,
            type = "range",
            min = 30, max = 64, step = 1,
            name = L["CollapseFrameHeight"],
            desc = L["CollapseFrameHeightdesc"],
		},
		MainFrameHeight = {
            order = 3,
            type = "range",
            min = 180, max = 755, step = 1, -- 190 min
            name = L["MainFrameHeight"],
            desc = L["MainFrameHeightdesc"],
		},


    }
}
