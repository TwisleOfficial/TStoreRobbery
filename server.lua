---------------------------------------------
            -- TStoreRobbery --
            -- Made By Twisle --
---------------------------------------------
-- DO NOT EDIT IF YOU DONT KNOW WHAT YOU ARE DOING! --
-- ONLY EDIT THE CONFIG.LUA FILE -- 

RegisterNetEvent('TStoreRobber:server:Alert')
AddEventHandler('TStoreRobber:server:Alert', function(msg)
    TriggerClientEvent('chatMessage', -1, msg)
end)
