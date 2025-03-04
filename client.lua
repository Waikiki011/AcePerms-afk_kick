-- Created by Waikiki for my server SAURP! Feel free to use this in your server

-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 1200 -- 20 minutes


-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true

-- CODE --

local time = secondsUntilKick
local prevPos = nil

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local playerPed = PlayerPedId()
        if playerPed then
            local currentPos = GetEntityCoords(playerPed, true)

            if currentPos == prevPos then
                if time > 0 then
                    if kickWarning and time == math.ceil(secondsUntilKick * 0.25) then
                        TriggerServerEvent("afk:checkPerm", time)
                    end
                    time = time - 1
                else
                    TriggerServerEvent("afk:checkKickPerm")
                end
            else
                time = secondsUntilKick
            end

            prevPos = currentPos
        end
    end
end)

RegisterNetEvent("afk:warn")
AddEventHandler("afk:warn", function(timeLeft)
    TriggerEvent("chat:addMessage", {
        color = {255, 0, 0},
        multiline = true,
        args = {"ALERT", "^1You'll be kicked in " .. timeLeft .. " seconds for being AFK!"}
    })
end)