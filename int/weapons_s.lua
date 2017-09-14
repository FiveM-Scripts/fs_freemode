RegisterServerEvent('fivem-stores:weapon-menu:item-selected')
AddEventHandler('fivem-stores:weapon-menu:item-selected', function(s)
	TriggerClientEvent('fivem-stores:giveWeapon', source, s.Name)
end)
