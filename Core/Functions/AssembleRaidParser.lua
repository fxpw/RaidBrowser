local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

E.Core.InvTable = {}
-- local SendAddToRaidPrefix = "RB!_SendAddToRaidPrefix"
local ReceiveRaidAsseblePrefix = "RB_RequestAddToRaid"



local function ReceiveRequestAddToRaid(prefix, msg, dist, sender)
    local success, receivedPlayerData = E:Deserialize(msg)
    E.Core:Print("ReceiveRequestAddToRaid", prefix, msg, dist, sender)
    if type(receivedPlayerData) == "table" then
        table.insert(E.Core.InvTable, receivedPlayerData)
        E.GUI:AssembleFrameInfoUpdate()
    end

    -- E.Core:Print("ReceiveRequestAddToRaid",text, distribution, target)
end

function E.Core:SendRequestAddToRaid(target)
    local sendedPlayerData = E.Core:GetPlayerInfo()
    sendedPlayerData.requestTime = time()
    E.Core:Print("SendRequestAddToRaid", target)
    E:SendCommMessage(ReceiveRaidAsseblePrefix, E:Serialize(sendedPlayerData), "WHISPER", target);

end

function E.Core:ClearAssembleTableAtTime()
    local currentTime = time()
    local tableindex = 1
    while E.Core.InvTable[tableindex] and E.Core.InvTable[tableindex].requestTime do
        if (currentTime - E.Core.InvTable[tableindex].requestTime > E.db.timeToClearAssemble) then
            table.remove(E.Core.InvTable, tableindex)
        else
            tableindex = tableindex + 1
        end
    end
end


function E.Core:ClearAssembleTableAtName(name)
    -- local currentTime = time()
    local tableindex = 1
    while E.Core.InvTable[tableindex] and E.Core.InvTable[tableindex].playerName do
        if (E.Core.InvTable[tableindex].playerName == name) then
            table.remove(E.Core.InvTable, tableindex)
        else
            tableindex = tableindex + 1
        end
    end
    E.GUI:AssembleFrameInfoUpdate()
end
function E.Core:CreateAssembleRaidFrame()
    E.Core.AssebleRaidUpdateFrame = CreateFrame("Frame")
    E.Core.AssebleRaidUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
        if self.lastUpdate < time() - E.db.timeToClearAssemble then
            self.lastUpdate = time();
            E.Core:ClearAssembleTableAtTime();
            E.GUI:AssembleFrameInfoUpdate()
        end
    end)
    E.Core.AssebleRaidUpdateFrame.lastUpdate = time();
end



function E.Core:AssebleRaidParserInit()
    E.Core:CreateAssembleRaidFrame();
    E:RegisterComm(ReceiveRaidAsseblePrefix,ReceiveRequestAddToRaid);
end

-- /dump TestRequest1("Chozik")
-- /dump TestRequest1("Шутка")
-- function TestRequest1(target)
--     E.Core:SendRequestAddToRaid(target)
-- end


-- SendAddonMessage("TEST", "test", "CHANNEL", "4.ПоискСпутников");
