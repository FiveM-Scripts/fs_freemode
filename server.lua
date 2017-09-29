local version = 'v1.2.2'

TriggerEvent("es:setDefaultSettings", {
	debugInformation = false,
	moneyIcon = Setup.Currency,
	nativeMoneySystem = Setup.NativeMoney,
	pvpEnabled = Setup.pvp,
	startingCash = Setup.Money,
	commandDelimeter= "/"
})

AddEventHandler('es:playerLoaded', function(source, player)
	player.displayMoney(player.getMoney())
end)

RegisterServerEvent("fs_freemode:playerSpawned")
AddEventHandler("fs_freemode:playerSpawned", function(spawn)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('fs_freemode:loadWeapons', source)
	end)
end)

RegisterServerEvent("fs_freemode:loadWeapons")
AddEventHandler("fs_freemode:loadWeapons", function(source)
	TriggerEvent('es:getPlayerFromId', source, function(user)
	db.getUser(user.getIdentifier(), function(freemodeuser)
		for i=1, #freemodeuser.weapons do
			TriggerClientEvent('fs_freemode:spawnWeapons', source, freemodeuser.weapons[i])
		end
		end)
	end)
end)

RegisterServerEvent('fs_freemode:missionComplete')
AddEventHandler('fs_freemode:missionComplete', function(total)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		user.addMoney(total)
	end)
end)

PerformHttpRequest("https://updates.fivem-scripts.org/verify/" .. GetCurrentResourceName(), function(err, rData, headers)
	if err == 404 or err == 403 then
		print("\nUPDATE ERROR: your version could not be verified\n")		
	else
		local vData = json.decode(rData)
		if vData.version ~= version then
			print("\n************************************************************************************************")
			print("You are running an outdated version of " .. GetCurrentResourceName())
			print("************************************************************************************************\n")
		end
	end
end, "GET", "", {["Content-Type"] = 'application/json'})
