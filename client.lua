---------------------------------------------
            -- TStoreRobbery --
            -- Made By Twisle --
---------------------------------------------
-- DO NOT EDIT IF YOU DONT KNOW WHAT YOU ARE DOING! --
-- ONLY EDIT THE CONFIG.LUA FILE -- 

local _robbed = false
local _onCoolDown = false

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

RegisterNetEvent("TStoreRobbery:client:Stealing", function()
    local _ped = PlayerPedId()
    local _pos = GetEntityCoords(_ped)

    for _, Stores in pairs(Config.Stores) do
        if (GetDistanceBetweenCoords(_pos.x, _pos.y, _pos.z, Stores.x, Stores.y, Stores.z, true)) < 15 then
            if _onCoolDown == false then
            if _robbed == false then
                _robbed = true

                print(Stores.Alert)

                TriggerServerEvent('TStoreRobber:server:Alert', Stores.Alert)

                FreezeEntityPosition(_ped, true)
                loadAnimDict("amb@prop_human_bum_bin@base")
                TaskPlayAnim(_ped, "amb@prop_human_bum_bin@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)

                -- Makes A Big Red Cricle Around The Store
                local blip = AddBlipForRadius(Stores.x, Stores.y, Stores.z, 276.0)
                SetBlipHighDetail(blip, true)
                SetBlipColour(blip, 1)
                SetBlipAlpha(blip, 128)
                local blipDesc = AddBlipForCoord(x, y, z)
                SetBlipSprite(blipDesc, sprite)
                SetBlipDisplay(blipDesc, true)
                SetBlipScale(blipDesc, 0.9)
                SetBlipColour(blipDesc, 11)
                SetBlipAsShortRange(blipDesc, true)

                -- This Is For The Mini Game 
                local _seconds = math.random(9,12)
                local _circles = math.random(3,6)
                local _success = exports['qb-lock']:StartLockPickCircle(_circles, _seconds, _success)
                
                if _success then
                    ShowNotification("Wait " .. Config.lootTime / 1000 .. " Seconds While You Grab The Loot!")

                    Citizen.Wait(Config.lootTime)

                    StopAnimTask(_ped, "amb@prop_human_bum_bin@base", "base", 1.0)
                    FreezeEntityPosition(_ped, false)

                    _onCoolDown = true
                    Citizen.Wait(Config.coolDown)
                    RemoveBlip(blip)
                    RemoveBlip(blipDesc)
                    _onCoolDown = false
                    _robbed = false

                    else
                        if _success == false then 
                            FreezeEntityPosition(_ped, false)
                            _onCoolDown = true
                            Citizen.Wait(Config.coolDown)
                            RemoveBlip(blip)
                            RemoveBlip(blipDesc)
                            _robbed = false
                            _onCoolDown = false

                        end
                end
            end
            end
        end
    end
end)

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

CreateThread(function()
    exports['qb-target']:AddTargetModel('prop_till_01', {
        options = {
            {
                type = 'client',
                event = "TStoreRobbery:client:Stealing",
                icon = 'fas fa-user-secret',
                label = 'Rob Till',
            }
        },
        distance = 4.0, 
    })
end)
