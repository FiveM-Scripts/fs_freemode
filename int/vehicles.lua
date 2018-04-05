--[[
            fs_freemode - game mode for FiveM.
              Copyright (C) 2018 FiveM-Scripts
              
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.
You should have received a copy of the GNU Affero General Public License
along with fs_freemode in the file "LICENSE". If not, see <http://www.gnu.org/licenses/>.
]]

local carList = {}
local fakecar = {model = '', car = nil, costs= nil}

RegisterNetEvent('es_vehshop:myVehicles')
AddEventHandler('es_vehshop:myVehicles', function(vehicles)
        carList = vehicles
end)

AddEventHandler('playerSpawned', function(spawn)
    TriggerServerEvent('es_vehshop:GetVehicles')
end)


local function SpawnFakeCar(vehicle, price)
  local playerCoords = GetEntityCoords(playerPed)
  local hash = GetHashKey(vehicle)

  if fakecar.model ~= vehicle then
    if DoesEntityExist(fakecar.car) then
      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
    end

    RequestModel(hash)
    while not HasModelLoaded(hash) do
      Citizen.Wait(0)
    end

    local veh = CreateVehicle(hash, -46.56327, -1097.382, 25.99875, 0.0, false, false)
    while not DoesEntityExist(veh) do
      Citizen.Wait(0)
    end

    FreezeEntityPosition(veh,true)
    SetEntityInvincible(veh,true)
    SetVehicleDoorsLocked(veh,4)

    TaskWarpPedIntoVehicle(PlayerPedId(), veh,-1)
    SetVehRadioStation(veh, "OFF")
    SetVehicleLights(veh, 2)
    for i = 0,24 do
      SetVehicleModKit(veh,0)
      RemoveVehicleMod(veh,i)
    end
    fakecar = { model = vehicle, car = veh, costs = price}

    WarMenu.OpenMenu('vehshopConfirm')
  end
end

local function spawnVehicle(vehicle)
    local car = GetHashKey(vehicle)
    local playerPed = PlayerPedId()
    
    if playerPed and playerPed ~= -1 then
        if DoesEntityExist(fakecar.car) then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
        end

        RequestModel(car)
        while not HasModelLoaded(car) do
            Citizen.Wait(0)
        end

        local veh = CreateVehicle(car, -19.521, -1117.096, 26.765, 175.394, true, false)
        local id = NetworkGetNetworkIdFromEntity(veh)
        SetNetworkIdCanMigrate(id, true)
        SetVehicleOnGroundProperly(veh)

        TaskWarpPedIntoVehicle(playerPed, veh, -1)
        SetEntityAsMissionEntity(veh, true, true)
        FreezeEntityPosition(playerPed, false)
        
        SetEntityVisible(playerPed, true)
        SetVehRadioStation(veh, "OFF")
        SetVehicleHasBeenOwnedByPlayer(veh, true)
    end
end    

CreateThread(function()
    local currentItemIndex = 1
    local selectedItemIndex = 1
    local checkbox = true

    WarMenu.CreateMenu('vehshop', 'default', i18n.translate("vehicles_shop_title"))
    WarMenu.SetMenuMaxOptionCountOnScreen('vehshop', 11)

    WarMenu.CreateSubMenu('vehshopConfirm', 'vehshop', i18n.translate("confirm"))
    WarMenu.CreateSubMenu('closeMenu', 'vehshop', i18n.translate("vehicles_shop_title"))
    
    WarMenu.SetSubTitle('vehshop', i18n.translate("categories"))
    WarMenu.SetSubTitle('vehshopConfirm', i18n.translate("vehicle_shop_confirmation"))    
    
    WarMenu.SetTitleColor('vehshop', 255, 255, 255)
    WarMenu.SetTitleColor('vehshopConfirm', 255, 255, 255)
    
    WarMenu.SetTitleBackgroundColor('vehshop', 255, 255, 255)
    WarMenu.SetTitleBackgroundColor('vehshopConfirm', 255, 255, 255)
    WarMenu.SetMenuBackgroundColor('closeMenu', 255, 255, 255)    
    
    for k,v in ipairs(carGroups) do
      WarMenu.CreateSubMenu(v.type, 'vehshop', v.name)
    end

    while true do
    local playerCoords = GetEntityCoords(PlayerPedId(), true)

    if not WarMenu.IsAnyMenuOpened() then
        DrawMarker(1, -46.56327,-1097.382,25.99875-0.500,0,0,0,0,0,0,2.001,2.0001,0.5001,0,191,43,88,0,0,0,0)
    end

    if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, -46.56327, -1097.382, 25.99875) <= 14.0 then
        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
            if GetPlayerWantedLevel(PlayerId()) >= 1 then
                NotWanted = false
                TriggerEvent("fs_freemode:displayHelp", "You need to lose your wanted level before you can enter the shop.")
            else
                NotWanted = true
                TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_vehicleshop"))
            end
        end

        if WarMenu.IsMenuOpened('vehshop') then
            DisableControlAction(0, 202, true)
            DisableControlAction(0, 177, true)

            for k,v in ipairs(carGroups) do
                if WarMenu.MenuButton(v.name, v.type) then
                  -- Go to the subcategory

                end
            end

            if WarMenu.Button(i18n.translate("exit")) then
                if fakecar.model ~= vehicle then
                    if DoesEntityExist(fakecar.car) then
                        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
                    end
                end

                SetEntityVisible(PlayerPedId(), true)
                FreezeEntityPosition(PlayerPedId(), false)
                WarMenu.CloseMenu('vehshop')
            end
            
            WarMenu.Display()
            elseif WarMenu.IsMenuOpened('compacts') then
                for k,v in pairs(compacts) do
                    if WarMenu.Button(v.name, v.costs.." $") then
                        SpawnFakeCar(tostring(v.model), tonumber(v.costs))
                    end
                end

            WarMenu.Display()

            elseif WarMenu.IsMenuOpened('coupes') then
                for k,v in pairs(coupes) do
                    if WarMenu.Button(v.name, v.costs.." $") then
                        SpawnFakeCar(tostring(v.model), tonumber(v.costs))
                    end
                end

            WarMenu.Display()
            elseif WarMenu.IsMenuOpened('sedans') then
                for k,v in pairs(sedans) do
                    if WarMenu.Button(v.name, v.costs.." $") then
                        SpawnFakeCar(tostring(v.model), tonumber(v.costs))
                    end
                end

            WarMenu.Display()
            elseif WarMenu.IsMenuOpened('sports') then
                for k,v in pairs(sports) do
                    if WarMenu.Button(v.name, v.costs.." $") then
                        SpawnFakeCar(tostring(v.model), tonumber(v.costs))
                    end
                end

            WarMenu.Display()

            elseif WarMenu.IsMenuOpened('sportclassics') then
                for k,v in pairs(sportclassics) do
                    if WarMenu.Button(v.name, v.costs.." $") then
                        SpawnFakeCar(tostring(v.model), tonumber(v.costs))
                    end
                end

            WarMenu.Display()

            elseif WarMenu.IsMenuOpened('super') then
                for k,v in pairs(super) do
                    if WarMenu.Button(v.name, v.costs.." $") then
                        SpawnFakeCar(tostring(v.model), tonumber(v.costs))
                    end
                end

            WarMenu.Display()
            elseif WarMenu.IsMenuOpened('muscle') then
                for k,v in pairs(muscle) do
                    if WarMenu.Button(v.name, v.costs.." $") then
                        SpawnFakeCar(tostring(v.model), tonumber(v.costs))
                    end
                end

            WarMenu.Display()          
            elseif WarMenu.IsMenuOpened('offroad') then
                for k,v in pairs(offroad) do
                    if WarMenu.Button(v.name, v.costs.." $") then
                        SpawnFakeCar(tostring(v.model), tonumber(v.costs))
                    end
                end

            WarMenu.Display()
            elseif WarMenu.IsMenuOpened('suvs') then
                for k,v in pairs(suvs) do
                    if WarMenu.Button(v.name, v.costs.." $") then
                        SpawnFakeCar(tostring(v.model), tonumber(v.costs))
                    end
                end

            WarMenu.Display()
            elseif WarMenu.IsMenuOpened('vans') then
                for k,v in pairs(vans) do
                    if WarMenu.Button(v.name, v.costs.." $") then
                        SpawnFakeCar(tostring(v.model), tonumber(v.costs))
                    end
                end

            WarMenu.Display()
            elseif WarMenu.IsMenuOpened('vehshopConfirm') then
                if WarMenu.Button(i18n.translate("buy"), fakecar.costs .." $") then
                    TriggerServerEvent('CheckMoneyForVeh', fakecar.model, tonumber(fakecar.costs))                    
                    elseif WarMenu.MenuButton(i18n.translate("no"), 'vehshop') then

                    end

            WarMenu.Display()                                     
        elseif GetPlayerWantedLevel(PlayerId()) < 1 then
            if IsControlJustReleased(0, 38) then
                FreezeEntityPosition(PlayerPedId(),true)
                SetEntityVisible(PlayerPedId(),false)

                local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,-46.56327,-1097.382,25.99875, Citizen.PointerValueFloat(),0)
                SetEntityCoords(PlayerPedId(),-46.56327,-1097.382,25.99875, g)
                SetEntityHeading(PlayerPedId(), 120.1953)
                WarMenu.OpenMenu('vehshop')
            end
        end
    end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent('FinishMoneyCheckForVeh')
AddEventHandler('FinishMoneyCheckForVeh', function(moneyCheck)
  if moneyCheck == "valid" then
    WarMenu.CloseMenu('vehshop')  
        local playerPed = PlayerPedId()

        local veh = GetVehiclePedIsUsing(playerPed)
        local model = GetEntityModel(veh)
        local colors = table.pack(GetVehicleColours(veh))
        local extra_colors = table.pack(GetVehicleExtraColours(veh))
        local lastVehicle = GetPlayersLastVehicle()

        if DoesEntityExist(fakecar.car) then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end

        FreezeEntityPosition(PlayerPedId(), false)
        local personal = CreateVehicle(model, -19.521, -1117.096, 26.765, 175.394, true, true)        
        SetVehicleOnGroundProperly(personal)
        SetEntityVisible(playerPed, true)

        SetVehRadioStation(personal, "OFF")
        SetVehicleHasBeenOwnedByPlayer(personal, true)

        SetVehicleColours(personal, colors[1],colors[2])
        SetVehicleExtraColours(personal, extra_colors[1],extra_colors[2])
        TaskWarpPedIntoVehicle(PlayerPedId(), personal, -1)

        local netid = NetworkGetNetworkIdFromEntity(personal)
        SetNetworkIdCanMigrate(netid, true)
        NetworkRegisterEntityAsNetworked(VehToNet(personal))        
  else
    if DoesEntityExist(fakecar.car) then
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
    end    
    TriggerEvent("fs_freemode:notify", "CHAR_SIMEON", 4, 2, "Simeon", false, i18n.translate("more_cash_needed"))

  end
end)

Citizen.CreateThread(function()
    local currentItemIndex = 1
    local selectedItemIndex = 1

    local currentEngineIndex = 1
    local selectedEngineIndex = 1

    local doorslocked = false
    local checkbox = true

    WarMenu.CreateMenu('inventory', 'default', i18n.translate("vehicle_inventory"))
    WarMenu.SetTitleColor('inventory', 255, 255, 255)
    WarMenu.SetTitleBackgroundColor('inventory', 255, 255, 255)
    WarMenu.SetSubTitle('inventory', i18n.translate("options"))
    while true do
        if WarMenu.IsMenuOpened('inventory') then
            if WarMenu.ComboBox(i18n.translate("vehicles_owned"), carList, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
                currentItemIndex = currentIndex
                selectedItemIndex = selectedIndex
                end) then
            if selectedItemIndex then

            end

            for k, v in pairs(carList) do
                if selectedItemIndex == k then 
                    TriggerEvent('vehshop:spawnVehicle', v)
                    WarMenu.CloseMenu()
                end
            end
            elseif IsPedInAnyVehicle(PlayerPedId(), false) then
                local currentVeh = GetVehiclePedIsUsing(PlayerPedId())
                if WarMenu.CheckBox(i18n.translate("vehicles_lockdoors"), doorslocked, function(checked)
                    doorslocked = checked
                    end) then
                if doorslocked then
                    SetVehicleDoorsLocked(currentVeh, 2)
                    else
                    SetVehicleDoorsLocked(currentVeh, 0)
                    end
                end

                if WarMenu.CheckBox(i18n.translate("vehicles_engine_on"), checkbox, function(checked)
                    checkbox = checked
                    end) then
                if checkbox then
                    engineoff = false
                    SetVehicleEngineOn(currentVeh, true, false, true)
                    else
                        engineoff = true
                    end
                end
            elseif WarMenu.Button(i18n.translate("exit")) then
                if fakecar.model then
                    if DoesEntityExist(fakecar.car) then
                        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
                    end
                end

                WarMenu.CloseMenu('inventory')
            end

            WarMenu.Display()        
            elseif not IsPlayerSwitchInProgress() then
                if IsControlJustReleased(0, Setup.InventoryKey) then
                    WarMenu.OpenMenu('inventory')
                end
            end

            if engineoff then
                local currentVeh = GetVehiclePedIsUsing(PlayerPedId())
                SetVehicleEngineOn(currentVeh, false, false, false)
            end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('vehshop:spawnVehicle')
AddEventHandler('vehshop:spawnVehicle', function(v)
    local car = GetHashKey(v)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local lastVehicle = GetPlayersLastVehicle()
 
    if playerPed and playerPed ~= -1 then
        if DoesEntityExist(lastVehicle) then
            DeleteVehicle(lastVehicle)
        end

        RequestModel(car)
        while not HasModelLoaded(car) do
            Citizen.Wait(0)
        end

        local veh = CreateVehicle(car, playerCoords, true, false)
        SetVehicleHasBeenOwnedByPlayer(veh, true)
        SetVehRadioStation(veh, "OFF")

        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityVisible(PlayerPedId(), true)

        TaskWarpPedIntoVehicle(playerPed, veh, -1)

        local netid = NetworkGetNetworkIdFromEntity(veh)
        SetNetworkIdCanMigrate(netid, true)
        NetworkRegisterEntityAsNetworked(VehToNet(veh))
    end
end)