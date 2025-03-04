--server.lua 
RegisterServerEvent("afk:checkKickPerm")
AddEventHandler("afk:checkKickPerm", function()
    local src = source
    if not IsPlayerAceAllowed(src, "afk.bypass") then
        DropPlayer(src, "You were AFK for too long.")
    end
end)

RegisterServerEvent("afk:checkPerm")
AddEventHandler("afk:checkPerm", function(timeLeft)
    local src = source
    if not IsPlayerAceAllowed(src, "afk.bypass") then
        TriggerClientEvent("afk:warn", src, timeLeft)
    end
end)

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local src = source
    if IsPlayerAceAllowed(src, "afk.bypass") then
        print("[AFK SYSTEM]: Player " .. name .. " is bypassed from AFK kick.")
    else
        print("[AFK SYSTEM]: Player " .. name .. " is NOT bypassed from AFK kick.")
    end
end)
