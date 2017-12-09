RegisterServerEvent('fivem-stores:weapon-menu:item-selected')
AddEventHandler('fivem-stores:weapon-menu:item-selected', function(s)
	local src = source
	TriggerEvent('es:getPlayerFromId', src, function(user)
		local player = user.getIdentifier()
		if user.getMoney() >= tonumber(s.Price) then
			TriggerClientEvent('fivem-stores:giveWeapon', src, s.Name, s.FriendlyName)
			if(database.driver == "couchdb") then
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
							db.updateDocument('fs_freemode', freemodeuser._id, {weapons = freemodeuser.weapons}, function()  end)
							user.removeMoney(tonumber(s.Price))
						end
					end)
				end)
			elseif(database.driver == "mysql-async") then
				MySQL.Async.fetchScalar("SELECT weapons FROM fs_freemode WHERE identifier = '"..player.."'", { ['@identifier'] = player}, function (weapons)
					if(weapons) then
						local arrayWeapons = json.decode(weapons)
						local myWeapons = false
						for k,v in ipairs(arrayWeapons) do						
							if (v == s.Name) then								
								print(k,v)
								myWeapons = true
							end
						end

						if not myWeapons then
							arrayWeapons[#arrayWeapons+1] = s.Name
							local update = json.encode(arrayWeapons)
							MySQL.Async.execute("UPDATE fs_freemode SET weapons='"..update.."' WHERE identifier = '"..player.."'", {})
							user.removeMoney(tonumber(s.Price))
						end
					end
				end)
			else
				print("Error : database driver not recognized!")
			end
		 end
	end)
end)
