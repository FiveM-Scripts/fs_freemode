local carList = {}
local personalvehicles = {}
local version = 'v1.3.1'

if Setup.SetTextChatEnabled then
	StopResource('chat')
else
	StartResource('chat')
end

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

PerformHttpRequest("https://updates.fivem-scripts.org/verify/" .. GetCurrentResourceName(), function(err, rData, headers)
	if err == 404 or err == 403 then
		print("\n***************************************************************************************************************")
		print("\nFREEMODE UPDATE ERROR: your version could not be verified.\n")
		print("Verify that the folder in your resources directory is named fs_freemode.")
		print("\n***************************************************************************************************************")		
		
		StopResource(GetCurrentResourceName())		
	else
		local vData = json.decode(rData)
		if vData.version ~= version then
			print("\n***************************************************************************************************************")
			print("You are running an outdated version of " .. GetCurrentResourceName())
			print("Please get the latest version from our GitHub page https://github.com/FiveM-Scripts/fs_freemode/releases/latest")
			print("\n***************************************************************************************************************")

		end
	end
end, "GET", "", {["Content-Type"] = 'application/json'})
