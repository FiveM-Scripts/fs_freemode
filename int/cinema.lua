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

local cinemaLocations = {
  { ['name'] = "Downtown", ['x'] = 300.788, ['y'] = 200.752, ['z'] = 104.385},
  { ['name'] = "Morningwood", ['x'] = -1423.954, ['y'] = -213.62, ['z'] = 46.5},
  { ['name'] = "Vinewood",  ['x'] = 302.907, ['y'] = 135.939, ['z'] = 160.946}
}

local MovieState = false

local function DeconstructMovie()
	local obj = GetClosestObjectOfType(319.884, 262.103, 82.917, 20.475, cin_screen, 0, 0, 0)
	cin_screen = GetHashKey("v_ilev_cin_screen")	
	SetTvChannel(-1)  
	
	ReleaseNamedRendertarget(GetHashKey("cinscreen"))
	SetTextRenderId(GetDefaultScriptRendertargetRenderId())
	SetEntityAsMissionEntity(obj,true,false)

	DeleteObject(obj)
end

local function DrawCinemaTip()
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(i18n.translate("leave_cinema"))
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

local function SetupMovie()
	cinema = GetInteriorAtCoords(320.217, 263.81, 82.974)
	LoadInterior(cinema)	
	cin_screen = GetHashKey("v_ilev_cin_screen")

	if not DoesEntityExist(tv) then
		tv = CreateObjectNoOffset(cin_screen, 320.1257, 248.6608, 86.56934, 1, true, false)
		SetEntityHeading(tv, 179.99998474121)
	else 
		tv = GetClosestObjectOfType(319.884, 262.103, 82.917, 20.475, cin_screen, 0, 0, 0)
	end

	RegisterNamedRendertarget("cinscreen", 0)	
	while not IsNamedRendertargetRegistered("cinscreen") do
	    Wait(0)    
	end

	LinkNamedRendertarget(cin_screen)
	while not IsNamedRendertargetLinked(cin_screen) do	    
	    Wait(0)
	end

	rendertargetid = GetNamedRendertargetRenderId("cinscreen")
	if IsNamedRendertargetLinked(cin_screen) and IsNamedRendertargetRegistered("cinscreen") then
	    Citizen.InvokeNative(0x9DD5A62390C3B735, 2, "PL_STD_CNT", 0)
	    SetTvVolume(100)
	    SetTvChannel(2)
	    
	    EnableMovieSubtitles(true)
	end

	CinemaTip = GetGameTimer()

	if MovieState == false then
		MovieState = true
		TriggerEvent("fs_freemode:StartCinemaMovie")
	end
end

local function StartMovie()
	SetTextRenderId(rendertargetid)
	SetScreenDrawPosition(0, 0)

	Citizen.InvokeNative(0x67A346B3CDB15CA5, 100.0)
	Citizen.InvokeNative(0x61BB1D9B3A95D802, 4)
	Citizen.InvokeNative(0xC6372ECD45D73BCD, true)

	DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
	ScreenDrawPositionEnd()
	SetTextRenderId(GetDefaultScriptRendertargetRenderId())

	if GetGameTimer() < CinemaTip + 15000 then
		DrawCinemaTip()
	end	
end

RegisterNetEvent("fs_freemode:cinemaPayed")
AddEventHandler("fs_freemode:cinemaPayed", function()
	DoScreenFadeOut(1000)
	Citizen.Wait(500)
	local playerPed = PlayerPedId()

	SetEntityCoords(playerPed, 320.217, 263.81, 81.974, true, true, true, true)
	SetEntityHeading(playerPed, 180.475)
	TaskLookAtCoord(playerPed, 319.259, 251.827, 85.648, -1, 2048, 3)

	SetPedKeepTask(playerPed, true)
	SetFollowPedCamViewMode(0)

	FreezeEntityPosition(playerPed, true)
	DoScreenFadeIn(800)
	SetupMovie()
end)

RegisterNetEvent("fs_freemode:StartCinemaMovie")
AddEventHandler("fs_freemode:StartCinemaMovie", function()
	Citizen.CreateThread(function()
		while(true) do
			Wait(0)
			if MovieState then
				StartMovie()

				DisableControlAction(0, 29, true)
				DisableControlAction(0, 32, true)
				DisableControlAction(0, 33, true)

				DisableControlAction(0, 34, true)
				DisableControlAction(0, 35, true)

				SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
				HideHudAndRadarThisFrame()				
				TriggerEvent('es:setMoneyDisplay', 0.0)
			end
		end
	end)
 end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		playerPed = PlayerPedId()
		playerCoords = GetEntityCoords(playerPed, true)
		hour = GetClockHours()

		for k,v in ipairs(cinemaLocations) do
			if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z) < 4.8 then
				if hour < tonumber(Setup.CinemaOpen) or hour > tonumber(Setup.CinemaClose) then					
					TriggerEvent("fs_freemode:displayHelp", i18n.translate("cinema_closed") .. tonumber(Setup.CinemaOpen) .. i18n.translate("andtext") .. tonumber(Setup.CinemaClose), 0)
				else
					TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_cinema"), 0)
					if IsControlPressed(0, 38) then
						TriggerServerEvent("fs_freemode:CheckMoneyForTheater", tonumber(Setup.CinemaPrice))
					end
				end
			end
		end

		if MovieState and IsControlJustPressed(0, 202) then
			DoScreenFadeOut(1000)
			Citizen.Wait(500)

			SetEntityCoords(PlayerPedId(), 282.080, 185.671, 104.496)
			SetEntityHeading(PlayerPedId(), 169.973)
			FreezeEntityPosition(PlayerPedId(), false)

			SetFollowPedCamViewMode(GetRandomIntInRange(1, 3))
			DoScreenFadeIn(800)

			DeconstructMovie()
			MovieState = false
		end
	end
end)

Citizen.CreateThread(function()
	if GetRoomKeyFromEntity(PlayerPedId()) ~= -1337806789 and DoesEntityExist(GetClosestObjectOfType(319.884, 262.103, 82.917, 20.475, cin_screen, 0, 0, 0)) then
		DeconstructMovie() 
	end

	if GetRoomKeyFromEntity(PlayerPedId()) ~= 1196036993 and DoesEntityExist(GetClosestObjectOfType(-802.0, 343.19, 158.81, cin_screen, 0, 0, 0)) then
		-- do something
	end	
end)