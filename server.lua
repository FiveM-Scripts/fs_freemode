TriggerEvent("es:setDefaultSettings", {
	debugInformation = false,
	moneyIcon = Setup.Currency,
	nativeMoneySystem = Setup.NativeMoney,
	pvpEnabled = Setup.pvp,
	startingCash = Setup.Money
})

AddEventHandler('es:playerLoaded', function(source, player)
	player.displayMoney(player.getMoney())
end)

RegisterServerEvent('fs_core:missionComplete')
AddEventHandler('fs_core:missionComplete', function(total)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		user.addMoney(total)
	end)
end)
