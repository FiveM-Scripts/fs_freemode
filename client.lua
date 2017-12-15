i18n.setLang("en")

AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:setAutoSpawn(true)
	exports.spawnmanager:forceRespawn()
end)

AddEventHandler("playerSpawned", function(spawn)
		local playerID = PlayerId()
		local player = GetPlayerPed(-1)
		local playerName = GetPlayerName(playerID)

		Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', Setup.ServerName)
		if Setup.DisplayWelcomeNotification then
			TriggerEvent("fs_freemode:notify", "CHAR_SOCIAL_CLUB", 4, 2, Setup.ServerName, false, i18n.translate("welcome_message") .. playerName)
		end

		SetAudioFlag("LoadMPData", true)
		SetAudioFlag("WantedMusicDisabled", Setup.WantedMusicDisabled)

		GiveWeaponToPed(player, GetHashKey("WEAPON_PISTOL"), 100, false, true)
		GiveWeaponToPed(player, GetHashKey("WEAPON_KNIFE"), true, true)
		spawned = true
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
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		-- Check if the player is wanted
		if Setup.WantedHeadDisplay == true then
			if GetPlayerWantedLevel(PlayerId()) ~= 0 then
				gamerTagId = CreateMpGamerTag(GetPlayerPed(-1), "", false, false, "", 0)
				SetMpGamerTagWantedLevel(gamerTagId, PlayerId())
				SetMpGamerTagVisibility(gamerTagId, 7, true)
				SetMpGamerTagAlpha(gamerTagId, 7, 240)
			else
				SetMpGamerTagVisibility(gamerTagId, 7, false)
			end
		end

		-- Check if the player is talking
		if Setup.VoiceHeadDisplay == true then
			local pid = GetPlayerServerId(PlayerId())
			if NetworkIsPlayerTalking(pid) then
				gamerTagId = CreateMpGamerTag(GetPlayerPed(-1), "", false, false, "", 0)
				SetMpGamerTagWantedLevel(gamerTagId, PlayerId())
				SetMpGamerTagVisibility(gamerTagId, 4, true)
				SetMpGamerTagAlpha(gamerTagId, 4, 240)
			else
				SetMpGamerTagVisibility(gamerTagId, 4, false)
			end
		end
	end
end)
