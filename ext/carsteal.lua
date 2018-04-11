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

local vehicle = nil

local DestinationCoords = {
    {x= -997.668, y= -2990.800, z= 13.4695},
    {x= 631.529, y= 126.205, z= 92.8359},
    {x= 926.907, y= -42.7272, z= 78.7644},
    {x= -1329.81, y= -228.173, z= 42.9079},
    {x= -1404.1, y= 51.9143, z= 53.0204},
    {x= -1457.21, y= 54.7377, z= 53.6327},
    {x= -1577.0, y= -85.6834, z= 54.1345},
    {x= -1457.21, y= 54.7377, z= 53.6327},
    {x= -1580.19, y= -59.6213, z= 56.4917},
    {x= -1103.34, y= 357.133, z= 68.4808},
    {x= -1857.91, y= 328.757, z= 88.6483},
    {x= -1935.02, y= 182.621, z= 84.5771},
    {x= -2983.09, y= 654.768, z= 24.927},
    {x= -1906.26, y= 2061.11, z= 140.738},
}

local CarModels = {"AUTARCH", "CHEETAH","CYCLONE", "CASCO", "COMET4", "FELTZER3", "GT500", "HUSTLER", "INFERNUS2", "JB700",
                   "BESTIAGTS", "DOMINATOR2", "VISIONE"}

local function GenerateDestinationCoords()
	for i = 1, #DestinationCoords do
		math.randomseed(GetGameTimer())
		math.random(); math.random(); math.random();
		
		local number =  math.random(1, #DestinationCoords)
		local q = DestinationCoords[number]

		return q
	end
end

local function GenerateRandomModel()
	for i = 1, #CarModels do
		math.randomseed(GetGameTimer())
		math.random(); math.random(); math.random(); math.random();

		local number =  math.random(1, #CarModels)
		local q = CarModels[number]

		return q
	end
end	

local function CreateRandomVehicle(x, y, z)
	model = GetHashKey(tostring(GenerateRandomModel()))
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end

	vehicle = CreateVehicle(model, x, y, z, 0.0, true, false)
  SetVehicleTyresCanBurst(vehicle, false)
  SetRadioToStationName("OFF")
  Citizen.Wait(800)

	netid = NetworkGetNetworkIdFromEntity(vehicle)
	SetNetworkIdCanMigrate(netid, true)
	NetworkRegisterEntityAsNetworked(VehToNet(vehicle))

	SetModelAsNoLongerNeeded(model)
	return vehicle
end

local function SetDestinationCoords()
	local VehicleBlip = AddBlipForCoord(1204.59, -3117.26, 4.98403)
	SetBlipColour(VehicleBlip, 83)
	SetBlipRoute(VehicleBlip, true)

	return VehicleBlip
end

local function DeleteCar(vehicle)
	if DoesBlipExist(destinationBlip) then
		RemoveBlip(destinationBlip)
	end

	if DoesEntityExist(vehicle) then
		RemoveBlip(blip)
		DeleteEntity(vehicle)
	end
end

local function SpawnSimeon(x, y, z)
	local modelHash = GetHashKey("ig_siemonyetarian")
	
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		Wait(0)
	end

	ped = CreatePed(6, modelHash, x, y, z-1.0001, 0.0, false, false)
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetEntityInvincible(ped, true)
  SetModelAsNoLongerNeeded(modelHash)

  return ped
end

Citizen.CreateThread(function()
   while true do
   	Wait(1)
      Px, Py, Pz = table.unpack(GetEntityCoords(PlayerPedId(), true))

   	if not MissionStarted then
         if Vdist2(Px, Py, Pz, -46.56327, -1097.382, 25.99875) < 285.0 then
            if not DoesEntityExist(simeon) then
               simeon = SpawnSimeon(-28.0952, -1104.11, 26.4223)
            end

            if DoesEntityExist(simeon) then
               if not DoesBlipExist(simeonBlip) then
                  simeonBlip = AddBlipForEntity(simeon)
                  SetBlipSprite(simeonBlip, 120)
                  
                  BeginTextCommandSetBlipName("STRING")
                  AddTextComponentString("Simeon")
                  EndTextCommandSetBlipName(simeonBlip)
               end

               TaskTurnPedToFaceEntity(simeon, PlayerPedId(), -1)
            end
           end

           if Vdist2(Px, Py, Pz, -28.0952, -1104.11, 26.4223) < 4.5 then
            TriggerEvent("fs_freemode:displayHelp", i18n.translate("StartMissionDialog"))
            if IsControlJustPressed(0, 38) then
               PlayAmbientSpeech1(simeon, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
               TaskTurnPedToFaceEntity(PlayerPedId(), simeon, -1)
               DisableAllControlActions(0)

               Wait(1000)
               TriggerEvent("fs_freemode:displaytext", i18n.translate("simeon_firstline"), 5000)
               Wait(5000)
               TriggerEvent("fs_freemode:displaytext",  i18n.translate("simeon_secondline"), 6000)
               Wait(6000)
               TriggerEvent("fs_freemode:displaytext",  i18n.translate("simeon_thirthline"), 7000)
               Wait(7000)

               DoScreenFadeOut(500)
               Citizen.Wait(500)

               if not DoesEntityExist(vehicle) then
                  spawn = GenerateDestinationCoords()
                  vehicle = CreateRandomVehicle(spawn.x, spawn.y, spawn.z)

                  if DoesEntityExist(vehicle) then
                     VehicleBlip = AddBlipForEntity(vehicle)
                     SetBlipColour(VehicleBlip, 8)

                     ClearPedTasksImmediately(PlayerPedId())
                     EnableAllControlActions(0)
                     RemoveBlip(simeonBlip)
                  end
               end

               Citizen.Wait(500)
               DoScreenFadeIn(500)

               SetMissionName(true, "RE_TITLE")
               DeleteEntity(simeon)

               MissionStarted = true
               MissionStep = 1
            end
         end
      end

   	if MissionStarted then
      if GetEntityHealth(PlayerPedId()) <= 0 then
        if DoesBlipExist(blip) then
          RemoveBlip(blip)
        end

        if DoesBlipExist(destinationBlip) then
          RemoveBlip(destinationBlip)
        end

        if DoesEntityExist(vehicle) then
          DeleteCar(vehicle)
        end

        SetMissionName(false, "RE_TITLE")
        MissionStep = nil
        MissionStarted = false
      end

   		if IsPedInVehicle(PlayerPedId(), vehicle, false) then
            if MissionStep == 1 then
               if not DoesBlipExist(destinationBlip) then
                  TriggerEvent("fs_freemode:displaytext", i18n.translate("simeon_coordinates"), 6000)
                  destinationBlip = SetDestinationCoords()

                  Wait(10000)
                  SetVehicleIsStolen(vehicle, true)
                  WantedTimer = GetGameTimer()

                  RemoveBlip(VehicleBlip)                  
                  wantedLevel = math.random(2, 4)

                  SetVehicleAlarm(vehicle, true)
                  SetVehicleAlarmTimeLeft(vehicle, 50000)
                  
                  MissionStep = 2
               end
            end

            if MissionStep == 2 then
              if GetGameTimer() > WantedTimer + 1000 and GetGameTimer() < WantedTimer + 7500 then
                TriggerEvent("fs_freemode:displayHelp", i18n.translate("clear_wantedLevel"))
              end

               if GetGameTimer() > WantedTimer + 1000 and GetGameTimer() < WantedTimer + 35000 then
                  SetPlayerWantedLevel(PlayerId(), wantedLevel, true)
                  SetPlayerWantedLevelNow(PlayerId(), wantedLevel)
               end

               if not IsVehicleDriveable(vehicle, true) then
                  SetEntityHealth(PlayerPedId(), 0)
               end

               if IsEntityInZone(PlayerPedId(), "TERMINA") then
                  if IsPedInVehicle(PlayerPedId(), vehicle, false) then
                     if GetPlayerWantedLevel(PlayerId()) > 0 then
                      -- do something
                     else
                        if not DoesEntityExist(simeon) then
                           simeon = SpawnSimeon(1208.87, -3121.15, 5.54032)
                        end

                        if Vdist2(GetEntityCoords(PlayerPedId(), true), 1204.59, -3117.26, 4.98403) <= 5.0 then
                           TaskTurnPedToFaceEntity(simeon, PlayerPedId(), -1)
                           Citizen.Wait(500)
                           
                           TaskLeaveVehicle(PlayerPedId(), vehicle, 64)
                           PlayAmbientSpeech1(simeon, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
                           Citizen.Wait(3000)

                           cashOut = tonumber(math.random(10000, 50000))
                           TriggerServerEvent('fs_freemode:missionComplete', cashOut)
                           PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

                           Wait(5000)
                           DeleteCar(vehicle)

                           if DoesEntityExist(simeon) then
                              SetEntityAsNoLongerNeeded(simeon)
                           end

                           SetMissionName(false, "RE_TITLE")
                           MissionStep = nil
                           MissionStarted = false
                        end
                     end
                  end
               end
            end

            if IsPedInVehicle(PlayerPedId(), vehicle, false) then
              if GetPlayerWantedLevel(PlayerId()) > 1 then
                if DoesBlipExist(destinationBlip) then
                  RemoveBlip(destinationBlip)
                end
              else
                if not DoesBlipExist(destinationBlip) then
                  destinationBlip = SetDestinationCoords()
                end
              end
            end
          end
        end
      end
  end)