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

i18n.setLang(Setup.Language)
MissionStarted = false

firstTick = false
firstJoin = true

spawnLock = false
sendmsg = false
playerName = nil

scaleform = nil
instructional = nil

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

local function generateSpawn()
	for i = 1, #SpawnLocations do
		math.randomseed(GetGameTimer())
		math.random(); math.random(); math.random();
		
		local number =  math.random(1, #SpawnLocations)
		local q = SpawnLocations[number]
		local a = SpawnLocations[number]

		return q
	end
end

local function RequestDeathScaleform()
    scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
    Instructional = RequestScaleformMovie("instructional_buttons")
    while not HasScaleformMovieLoaded(scaleform) do
    	Wait(0)
    end

    return scaleform
end

local function death_screen()
	HideHudAndRadarThisFrame()
	
	if not locksound then
		ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 2.0)
		StartScreenEffect("DeathFailOut", 0, true)
		PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		
		deathscale = RequestDeathScaleform()
		locksound = true
	end

	PushScaleformMovieFunction(deathscale, "SHOW_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString(i18n.translate("wasted_message"))
	PushScaleformMovieFunctionParameterString("")
	
	PushScaleformMovieFunctionParameterFloat(105.0)
	PushScaleformMovieFunctionParameterBool(true)
	PopScaleformMovieFunctionVoid()

	SetScreenDrawPosition(0.00, 0.00)
	DrawScaleformMovieFullscreen(deathscale, 255, 255, 255, 255, 0)

	-- Instructional buttons
    PushScaleformMovieFunction(Instructional, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(Instructional, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Instructional, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)

    Button(GetControlInstructionalButton(2, 329, true))
    ButtonMessage(i18n.translate("continue"))
    PopScaleformMovieFunctionVoid()

    if Setup.EMS then
    	PushScaleformMovieFunction(Instructional, "SET_DATA_SLOT")
    	PushScaleformMovieFunctionParameterInt(3)
    	Button(GetControlInstructionalButton(2, 153, true))
    	ButtonMessage(i18n.translate("call_ems"))
    	PopScaleformMovieFunctionVoid()
    end

    PushScaleformMovieFunction(Instructional, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Instructional, "SET_BACKGROUND_COLOUR")
    
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    
    PopScaleformMovieFunctionVoid()
    DrawScaleformMovieFullscreen(Instructional, 255, 255, 255, 255, 0)
	TriggerEvent('es:setMoneyDisplay', 0.0)

	return deathscale
end

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if not Setup.NativeMoney then
			HideHudComponentThisFrame(3)
			HideHudComponentThisFrame(4)
			HideHudComponentThisFrame(13)
		end

		if GetEntityHealth(PlayerPedId()) <= 0 then
			deathscale = death_screen()
		
			if IsControlJustPressed(0, 24) then
				DoScreenFadeOut(800)
				Wait(800)

				local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
				local _, vector = GetNthClosestVehicleNode(x, y, z, math.random(20, 180), 0, 0, 0)
				success, vec3 = GetSafeCoordForPed(vector.x, vector.y, vector.z, false, 28)
				heading = 0

				if success then
					x, y, z = table.unpack(vec3)
				else
					temp = generateSpawn()
					x, y, z = temp.x, temp.y, temp.z
				end

				NetworkResurrectLocalPlayer(x, y, z, 0.0, true, false)
				ClearPedBloodDamage(PlayerPedId())

				StopScreenEffect("DeathFailOut")
				locksound = false
				Wait(200)
				DoScreenFadeIn(800)

				SetScaleformMovieAsNoLongerNeeded(deathscale)
				SetScaleformMovieAsNoLongerNeeded(Instructional)

				TriggerEvent('es:setMoneyDisplay', 1.0)
				TriggerServerEvent("fs_freemode:playerSpawned")
			end

			if Setup.EMS then
				if IsControlJustPressed(0, 38) then
					TriggerServerEvent("fs_freemode:notifyAll", "CHAR_CALL911", i18n.translate("dispatch"), i18n.translate("ems_heal"), playerName .. i18n.translate("ems_request"))
				end
			end
		else
			if HasScaleformMovieLoaded(deathscale) then
					StopScreenEffect("DeathFailOut")
					locksound = false

					TriggerEvent('es:setMoneyDisplay', 1.0)
					SetScaleformMovieAsNoLongerNeeded(Instructional)
					SetScaleformMovieAsNoLongerNeeded(deathscale)
			end
		end

		if not firstTick and NetworkIsSessionStarted() then
			exports.spawnmanager:setAutoSpawn(false)
			exports.spawnmanager:forceRespawn()

			exports.spawnmanager:setAutoSpawnCallback(function()
				if spawnLock then
					return
				end

				spawnLock = true
				TriggerEvent('playerSpawn')

				local temp = generateSpawn()
				x, y, z = temp.x, temp.y, temp.z

				exports.spawnmanager:spawnPlayer({x = x, y = y, z = z, model = GetHashKey("mp_m_freemode_01")})
				firstTick = true
				end)
		end
	end
end)

AddEventHandler("playerSpawned", function(spawn)
	if firstJoin then
		StartPlayerSwitch(PlayerPedId(), PlayerPedId(), 2050, 1)
	end
	
	AddTextEntry('FE_THDR_GTAO', Setup.ServerName)

	if Setup.SetTextChatEnabled then
		SetTextChatEnabled(true)
	else
		SetTextChatEnabled(false)
	end	

	SetPedHeadBlendData(PlayerPedId(), 0, math.random(12), 0,math.random(12), math.random(5), math.random(5),1.0,1.0,1.0,true)
	
	SetPedComponentVariation(PlayerPedId(), 0, math.random(0, 5), 0, 2)
	SetPedComponentVariation(PlayerPedId(), 2, math.random(1, 17), 3, 2)
    SetPedComponentVariation(PlayerPedId(), 3, 164, 0, 2)

    SetPedComponentVariation(PlayerPedId(), 4, 1, math.random(2), 2)
    SetPedComponentVariation(PlayerPedId(), 6, math.random(0, 6), 0, 2)
    SetPedComponentVariation(PlayerPedId(), 10, 7, 0, 2)
        
    SetPedComponentVariation(PlayerPedId(), 8, 2, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 11, 0, math.random(0, 9), 2)

	SetPedHairColor(PlayerPedId(), math.random(1, 4), 1)

	while firstJoin do
		Wait(1)
		HideHudAndRadarThisFrame()
		TriggerEvent('es:setMoneyDisplay', 0.0)
	end

	TriggerEvent('es:setMoneyDisplay', 1.0)
	TriggerServerEvent("fs_freemode:playerSpawned")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsPauseMenuActive() and not pauseMenu then
			pauseMenu = true
			TriggerEvent('es:setMoneyDisplay', 0.0)
		elseif not IsPauseMenuActive() and pauseMenu then
			pauseMenu = false
			TriggerEvent('es:setMoneyDisplay', 1.0)
		end

		if firstJoin and IsPlayerSwitchInProgress() then
			Wait(10000)
			StopPlayerSwitch()
			
			if Setup.DisplayWelcomeNotification then
				playerID = PlayerId()
				playerName = GetPlayerName(playerID)

				TriggerEvent("fs_freemode:notify", Setup.WelcomeNotification, 4, 2, Setup.ServerName, false, i18n.translate("welcome_message") .. playerName)
			end

			TriggerEvent('es:setMoneyDisplay', 1.0)
			firstJoin = false
		end
	end
end)