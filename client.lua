i18n.setLang("en")

AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:setAutoSpawn(true)
	exports.spawnmanager:forceRespawn()
end)

AddEventHandler("playerSpawned", function(spawn)
	local player = GetPlayerPed(-1)
	local playerID = PlayerId()
	local playerName = GetPlayerName(playerID)
	
	AddTextEntry('FE_THDR_GTAO', Setup.ServerName)
	if Setup.DisplayWelcomeNotification then
		TriggerEvent("fs_freemode:notify", "CHAR_SOCIAL_CLUB", 4, 2, Setup.ServerName, false, i18n.translate("welcome_message") .. playerName)
	end

	if Setup.SetTextChatEnabled then
		SetTextChatEnabled(true)
	else
		SetTextChatEnabled(false)
	end
	
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
