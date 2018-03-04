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

local carList = {}
local personalvehicles = {}

AddEventHandler('onResourceStart', function(resource)
	if resource == 'fs_freemode' then	
		link = GetResourceMetadata(GetCurrentResourceName(), 'resource_repository', 0)
		version = GetResourceMetadata(GetCurrentResourceName(), 'resource_version', 0)

		if version then		
			PerformHttpRequest("https://updates.fivem-scripts.org/verify/" .. GetCurrentResourceName(), function(err, rData, headers)
				print("\nStarting fs_freemode ".. version .."\n----------------------------------------------------")
				if err == 404 then
					print("\nUPDATE ERROR: your version could not be verified.\n")
					print("If you keep receiving this error then please contact FiveM-Scripts.")
					print("\n----------------------------------------------------")	
				else
					local vData = json.decode(rData)
					if vData.version ~= version then
						print("You are running an outdated version of " .. GetCurrentResourceName())
						print("Please get the latest version from our GitHub page ".. link .."\n----------------------------------------------------")
						SendUpdateNotification = true
					else 
						print("You are running the latest version of fs_freemode.\n----------------------------------------------------")				
					end
				end
			end, "GET", "", {["Content-Type"] = 'application/json'})
		end
	else
		print("Your folder is not set set to fs_freemode")
		CancelEvent()
	end
end)

if Setup.SetTextChatEnabled then
	StopResource('chat')
else
	StartResource('chat')
end

TriggerEvent("es:setDefaultSettings", {
        debugInformation = false,
        moneyIcon = Setup.Currency,
        nativeMoneySystem = Setup.NativeMoney,
        pvpEnabled = true,
        startingCash = Setup.Money,
        commandDelimeter= "/"
})

AddEventHandler('es:playerLoaded', function(source, player)
	player.displayMoney(player.getMoney())
	local group = player.getGroup()

	if(database.driver == "couchdb") then  
		TriggerEvent('es:exposeDBFunctions', function(db)
			db.getDocumentByRow('es_vehshop', 'identifier', player.get('identifier'), function(vehshopuser)
				if(vehshopuser)then
					personalvehicles = vehshopuser.personalvehicles
				else
					personalvehicles = {}
				end

				TriggerClientEvent('es_vehshop:myVehicles', source, personalvehicles)
				end)
			end)
	else
		local identifier = player.get('identifier')
		MySQL.Async.fetchScalar("SELECT vehicles FROM fs_freemode WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier}, function (vehicles)
			if vehicles then
				myVehicles = json.decode(vehicles)
				personalvehicles = myVehicles
			else
				personalvehicles = {}
			end
			    TriggerClientEvent('es_vehshop:myVehicles', source, personalvehicles)
			end)
	end

	if SendUpdateNotification then
	    if group == "superadmin" or group == "admin" then
	    	TriggerClientEvent("fs_freemode:UpdateNofity", source)
	    end
	end

end)

RegisterServerEvent("fs_freemode:playerSpawned")
AddEventHandler("fs_freemode:playerSpawned", function(spawn)
	TriggerEvent('fs_freemode:loadInventory', source)
end)

RegisterServerEvent("fs_freemode:loadInventory")
AddEventHandler("fs_freemode:loadInventory", function(source)
	local src = source
	TriggerEvent('es:getPlayerFromId', src, function(user)
		db.getUser(user.getIdentifier(), function(freemodeuser)
			for i=1, #freemodeuser.weapons do
				TriggerClientEvent('fs_freemode:spawnWeapons', source, freemodeuser.weapons[i])
			end
		end)

		if(database.driver == "couchdb") then
			TriggerEvent('es:exposeDBFunctions', function(db)
				db.getDocumentByRow('es_vehshop', 'identifier', user.get('identifier'), function(vehshopuser)
					if(vehshopuser)then
						personalvehicles = vehshopuser.personalvehicles
					else
						personalvehicles = {}
					end
					TriggerClientEvent('es_vehshop:myVehicles', src, personalvehicles)
					end)
				end)
		else
			MySQL.Async.fetchScalar("SELECT vehicles FROM fs_freemode WHERE identifier = '"..user.get('identifier').."'", { ['@identifier'] = identifier}, function (vehicles)
				if vehicles then
					local myVehicles = json.decode(vehicles)
					personalvehicles = myVehicles
				else
					personalvehicles = {}
				end
				TriggerClientEvent('es_vehshop:myVehicles', source, personalvehicles)
				end)
		end
	end)
end)

RegisterServerEvent('fs_freemode:missionComplete')
AddEventHandler('fs_freemode:missionComplete', function(total)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		user.addMoney(tonumber(total))
	end)
end)

RegisterServerEvent('fs_freemode:notifyAll')
AddEventHandler('fs_freemode:notifyAll', function(icon, sender, title, text)
	TriggerEvent("es:getPlayers", function(users)
		for k,v in pairs(users) do
			TriggerClientEvent("fs_freemode:notify", k, tostring(icon), 4, 2, tostring(sender), tostring(title), tostring(text))
		end
	end)	
end)

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
				print("Error: No database driver has been set in the server config.")
			end
		 end
	end)
end)

RegisterServerEvent('fs_freemode:CheckMoneyForTheater')
AddEventHandler('fs_freemode:CheckMoneyForTheater', function(price)
	local Source = tonumber(source)
	TriggerEvent('es:getPlayerFromId', Source, function(user)
		if user.getMoney() >= tonumber(price) then
			user.removeMoney(tonumber(price))
			TriggerClientEvent('fs_freemode:cinemaPayed', Source)
		end
	end)
end)

RegisterServerEvent('fs_freemode:CheckMoneyForWeed')
AddEventHandler('fs_freemode:CheckMoneyForWeed', function(price)
	local Source = tonumber(source)
	TriggerEvent('es:getPlayerFromId', Source, function(user)   
		if user.getMoney() >= tonumber(price) then
			user.removeMoney(tonumber(price))
			TriggerClientEvent('fs_freemode:buyweed', Source)
		end
	end)
end)

RegisterServerEvent('CheckMoneyForVeh')
AddEventHandler('CheckMoneyForVeh', function(vehicle, price)
	local Source = source
  TriggerEvent('es:getPlayerFromId', Source, function(user)
    local player = user.getIdentifier()

    if user.getMoney() >= tonumber(price) then
      user.removeMoney(tonumber(price))
      personalvehicles[#personalvehicles + 1] = vehicle
      TriggerClientEvent('es_vehshop:myVehicles', Source, personalvehicles)
      TriggerClientEvent('FinishMoneyCheckForVeh', Source, "valid")
            
      if database.driver == "couchdb" then
        TriggerEvent('es:exposeDBFunctions', function(db)
          db.getDocumentByRow('es_vehshop', 'identifier', user.get('identifier'), function(vehshopuser)
            local myVehicles = false

            for k,v in ipairs(vehshopuser.personalvehicles) do
              if (v == vehicle) then
                myVehicles = true

              end
            end

            if not myVehicles then
              vehshopuser.personalvehicles[#vehshopuser.personalvehicles+1] = vehicle
              db.updateDocument('es_vehshop', vehshopuser._id, {personalvehicles = vehshopuser.personalvehicles}, function()  end) 
            end
          end)
        end)
        elseif database.driver == "mysql-async" then
          MySQL.Async.fetchScalar("SELECT vehicles FROM fs_freemode WHERE identifier = '"..player.."'", { ['@identifier'] = player}, function (vehicles)
            if vehicles then
            	arrayVehicles = json.decode(vehicles)
            	for k,v in ipairs(arrayVehicles) do
            		if (v == vehicle) then
            			vehicleExists = true
            		end
            	end

                if not vehicleExists then
                  arrayVehicles[#arrayVehicles+1] = vehicle
                  local update = json.encode(arrayVehicles)
                  MySQL.Async.execute("UPDATE fs_freemode SET vehicles='"..update.."' WHERE identifier = '"..player.."'", {})
                else
                  TriggerClientEvent('FinishMoneyCheckForVeh', Source, "exists")
                end
            end
           end)
          else
            print("Error: No database driver has been set in the server config.")
          end
       else
      TriggerClientEvent('FinishMoneyCheckForVeh', Source, "invalid")
    end
  end)
end)