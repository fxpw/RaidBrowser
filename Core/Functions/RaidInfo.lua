local AddOnName, Engine = ...
local E, L, V, P, G = unpack(Engine); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

E.Core.RaidCDInfo = {}

function E.Core:UpdateRaidCDInfo()
    table.wipe(E.Core.RaidCDInfo)
    for i = 1, GetNumSavedInstances() do
        local savedName, id, reset, difficulty, locked, _, _, _, savedSize = GetSavedInstanceInfo(i);
        E.Core.RaidCDInfo[i] = {
            savedName = savedName,
            id = id,
            reset = reset,
            isCD = reset>1,
            savedSize = savedSize,
            difficulty = difficulty,
            locked = locked,
        }
    end
end

function E.Core:IsRaidInCD(name, size, difficulty)
    for _,v in pairs(E.Core.RaidCDInfo) do
        if v.savedName == name and v.savedSize == size and v.difficulty == difficulty then
            return v.locked
        end
    end
    return false
end

function E.Core:GetRaidCDInfo(name,size,difficulty)
    for k,v in pairs(E.Core.RaidCDInfo) do
        if v.savedName == name and v.savedSize == size and v.difficulty == difficulty then
            return v
        end
    end
    return {
        savedName = name,
        id = -1,
        reset = 0;
        isCD = false,
        savedSize = size,
        difficulty = difficulty,
        locked = false,
    }
end

function E.Core:GetCDInfo(table)
    local numRaidsWhithoutCD = #table.instanceName
    for _,v in pairs(table.instanceName) do
        if E.Core:IsRaidInCD(v[1], table.size, v[2]) then
            numRaidsWhithoutCD = numRaidsWhithoutCD - 1
        end
    end
    if numRaidsWhithoutCD == 0 then
       return "all", "|cff".."ff0000"
    elseif numRaidsWhithoutCD == #table.instanceName then
        return "half", "|cff".."00ff1e"
    else
        return "zero", "|cff".."f2ff00"
    end
end

function E.Core:InitRaidCDInfo()
    E.Core.UpdateRaidCDInfoFrame = CreateFrame("Frame")
    E.Core.UpdateRaidCDInfoFrame:RegisterEvent("UPDATE_INSTANCE_INFO")
    E.Core.UpdateRaidCDInfoFrame:SetScript("OnEvent",E.Core.UpdateRaidCDInfo)
end

