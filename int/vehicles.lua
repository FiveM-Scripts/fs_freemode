local carList = {}
local fakecar = {model = '', car = nil, costs= nil}

RegisterNetEvent('es_vehshop:myVehicles')
AddEventHandler('es_vehshop:myVehicles', function(vehicles)
        for i=1, #vehicles do
            Citizen.Trace(vehicles[i] ..'\n')
        end
        carList = vehicles
end)

AddEventHandler('playerSpawned', function(spawn)
    TriggerServerEvent('es_vehshop:GetVehicles')
end)


local function SpawnFakeCar(vehicle, price)
  local playerCoords = GetEntityCoords(playerPed)

  if fakecar.model ~= vehicle then
    if DoesEntityExist(fakecar.car) then
      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
    end

    local hash = GetHashKey(vehicle)

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

    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh,-1)
    SetVehRadioStation(veh, "OFF")
    SetVehicleLights(veh, 2)
    for i = 0,24 do
      SetVehicleModKit(veh,0)
      RemoveVehicleMod(veh,i)
    end
    fakecar = { model = vehicle, car = veh, costs = price}

    WarMenu.OpenMenu('confirmMenu')
  end
end

local function spawnVehicle(vehicle)
    local car = GetHashKey(vehicle)
    local playerPed = GetPlayerPed(-1)
    
    if playerPed and playerPed ~= -1 then
        if DoesEntityExist(fakecar.car) then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
        end

        RequestModel(car)
        while not HasModelLoaded(car) do
            Citizen.Wait(0)
        end

        local veh = CreateVehicle(car, -19.521, -1117.096, 26.765, 175.394, true, true)
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

    WarMenu.CreateSubMenu('confirmMenu', 'vehshop', i18n.translate("confirm"))
    WarMenu.CreateSubMenu('closeMenu', 'vehshop', i18n.translate("vehicles_shop_title"))
    
    WarMenu.SetSubTitle('vehshop', i18n.translate("categories"))
    WarMenu.SetSubTitle('confirmMenu', i18n.translate("vehicle_shop_confirmation"))    
    
    WarMenu.SetTitleColor('vehshop', 255, 255, 255)
    WarMenu.SetTitleColor('confirmMenu', 255, 255, 255)
    
    WarMenu.SetTitleBackgroundColor('vehshop', 255, 255, 255)
    WarMenu.SetTitleBackgroundColor('confirmMenu', 255, 255, 255)
    WarMenu.SetMenuBackgroundColor('closeMenu', 255, 255, 255)    
    
    for k,v in ipairs(carGroups) do
      WarMenu.CreateSubMenu(v.type, 'vehshop', v.name)
    end

    while true do
    local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
    DrawMarker(1, -46.56327,-1097.382,25.99875-0.500,0,0,0,0,0,0,2.001,2.0001,0.5001,0,191,43,88,0,0,0,0)
    if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, -46.56327, -1097.382, 25.99875) <= 14.0 then
        if IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
            TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_vehicleshop"))
        end

        if WarMenu.IsMenuOpened('vehshop') then
            for k,v in ipairs(carGroups) do
                if WarMenu.MenuButton(v.name, v.type) then
                  -- Go to the subcategory

                end
            end

            if WarMenu.Button('Exit') then
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
            elseif WarMenu.IsMenuOpened('confirmMenu') then
                if WarMenu.Button(i18n.translate("buy"), fakecar.costs .." $") then
                    TriggerServerEvent('CheckMoneyForVeh', fakecar.model, tonumber(fakecar.costs))
                    WarMenu.CloseMenu()
                    elseif WarMenu.MenuButton(i18n.translate("no"), 'vehshop') then

                    end

            WarMenu.Display()                                     
        elseif IsControlJustReleased(0, 38) then
            FreezeEntityPosition(GetPlayerPed(-1),true)
            SetEntityVisible(GetPlayerPed(-1),false)
            local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,-46.56327,-1097.382,25.99875, Citizen.PointerValueFloat(),0)
            SetEntityCoords(GetPlayerPed(-1),-46.56327,-1097.382,25.99875, g)
            SetEntityHeading(GetPlayerPed(-1), 120.1953)
            WarMenu.OpenMenu('vehshop')
        end
    end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent('FinishMoneyCheckForVeh')
AddEventHandler('FinishMoneyCheckForVeh', function(moneyCheck)
  if moneyCheck == "valid" then  
        local playerPed = GetPlayerPed(-1)

        local veh = GetVehiclePedIsUsing(playerPed)
        local model = GetEntityModel(veh)
        local colors = table.pack(GetVehicleColours(veh))
        local extra_colors = table.pack(GetVehicleExtraColours(veh))
        if DoesEntityExist(fakecar.car) then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end

        FreezeEntityPosition(GetPlayerPed(-1), false)
        local personal = CreateVehicle(model, -19.521, -1117.096, 26.765, 175.394, true, true)        
        local id = NetworkGetNetworkIdFromEntity(personal)

        SetNetworkIdCanMigrate(id, true)
        SetVehicleOnGroundProperly(personal)

        SetEntityAsMissionEntity(personal, true, true)
        SetEntityVisible(playerPed, true)

        SetVehRadioStation(personal, "OFF")
        SetVehicleHasBeenOwnedByPlayer(personal, true)

        SetVehicleColours(personal, colors[1],colors[2])
        SetVehicleExtraColours(personal, extra_colors[1],extra_colors[2])
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), personal, -1)

  else
    WarMenu.OpenMenu('vehshop')
    TriggerEvent("fs_freemode:notify", "CHAR_SIMEON", 4, 2, "Simeon", false, i18n.translate("more_cash_needed"))

  end
end)

Citizen.CreateThread(function()
    local currentItemIndex = 1
    local selectedItemIndex = 1
    local checkbox = true

    WarMenu.CreateMenu('test', 'default', i18n.translate("vehicle_inventory"))
    WarMenu.SetTitleColor('test', 255, 255, 255)
    WarMenu.SetTitleBackgroundColor('test', 255, 255, 255)
    WarMenu.SetSubTitle('test', i18n.translate("options"))
    while true do
        if WarMenu.IsMenuOpened('test') then
            if WarMenu.ComboBox(i18n.translate("vehicles_owned"), carList, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
                    currentItemIndex = currentIndex
                    selectedItemIndex = selectedIndex
                end) then
              if selectedItemIndex then
                Citizen.Trace('Selected index ' ..selectedItemIndex)
              end
                    for k, v in pairs(carList) do
                        if selectedItemIndex == k then                            
                            TriggerEvent('vehshop:spawnVehicle', v)
                            WarMenu.CloseMenu()
                    end
                end
                    elseif WarMenu.Button(i18n.translate("exit")) then
                        if fakecar.model then
                          if DoesEntityExist(fakecar.car) then
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
                          end
                        end
                        WarMenu.CloseMenu('test')
            end

            WarMenu.Display()        
        elseif IsControlJustReleased(0, 56) then
            WarMenu.OpenMenu('test')
        end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent('vehshop:spawnVehicle')
AddEventHandler('vehshop:spawnVehicle', function(v)
    local car = GetHashKey(v)
    local playerPed = GetPlayerPed(-1)
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

        local veh = CreateVehicle(car, playerCoords, true, true)
        local id = NetworkGetNetworkIdFromEntity(veh)
        SetNetworkIdCanMigrate(id, true)

        TaskWarpPedIntoVehicle(playerPed, veh, -1)
        SetEntityAsMissionEntity(veh, true, true)
        SetVehicleHasBeenOwnedByPlayer(veh, true)
        SetVehRadioStation(veh, "OFF")

        FreezeEntityPosition(GetPlayerPed(-1), false)
        SetEntityVisible(GetPlayerPed(-1), true)
    end
end)