RegisterServerEvent('fivem-stores:weapon-menu:item-selected')
AddEventHandler('fivem-stores:weapon-menu:item-selected', function(s)
	TriggerEvent('es:getPlayerFromId', source, function(user)			
		local player = user.getIdentifier()

		if user.getMoney() >= tonumber(s.Price) then
			TriggerClientEvent('fivem-stores:giveWeapon', source, s.Name, s.FriendlyName)

			TriggerEvent('es:exposeDBFunctions', function(db)
				db.getDocumentByRow('fs_freemode', 'identifier', player, function(freemodeuser)
					local myWeapons = false
				 
				for k,v in ipairs(freemodeuser.weapons) do
					if (v == s.Name) then
						myWeapons = true
					end
				end	

				if not myWeapons then					 
						freemodeuser.weapons[#freemodeuser.weapons+1] = s.Name						
						db.updateDocument('fs_freemode', freemodeuser._id, {weapons = freemodeuser.weapons}, function()	 end) 
						user.removeMoney(tonumber(s.Price))
					end
				end)
			end)
		end
	end)
end)