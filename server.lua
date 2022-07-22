---------------------------------------------
            -- TStoreRobbery --
            -- Made By Twisle --
---------------------------------------------
-- DO NOT EDIT IF YOU DONT KNOW WHAT YOU ARE DOING! --
-- ONLY EDIT THE CONFIG.LUA FILE -- 

RegisterServerEvent('TStoreRobber:server:Alert')
AddEventHandler('TStoreRobber:server:Alert', function()
    local _source = source
    for i = 1, #Config.Stores, 1 do
        TriggerClientEvent('chatMessage', -1, '^7[^124/7 Store Alarm^7]^2', {0,0,0} , Config.Stores[i].Name .. " Its Being Robbed")
    end
end)