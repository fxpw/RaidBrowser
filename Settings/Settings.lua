local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB


--gui
P.CollapseFrameHeight = 30
P.CollapseFrameWidth = 600

P.MainFrameHeight = 600
--

P.tankCount = 1
P.healCount = 1
P.ddCount = 1
P.selectedRaid = 2
P.tankInfo = ""
P.healInfo = ""
P.ddInfo = ""
P.ilvlCount = 200
P.anrolCount = 4
P.ilvlInfo = ""

P.anrolInfo = ""
P.addedInfo = ""
P.spamTime = 30

P.TimeToClearRaids = 32
P.timeToClearAssemble = 60
P.CollapseFrameX = -300
P.CollapseFrameY = 0
P.LastTabIndex = 2
P.IsMainFrameShown = true
P.ShowWhoMessages = false
P.channelNumbers = {
    -- ["1"] = "1",
    -- ["2"] = "2",
    -- ["3"] = "3",
    ["4"] = false,
    ["5"] = false,
    ["6"] = false,
    ["7"] = false,
}

