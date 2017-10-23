local function LoadBunkerWorkers()
	local Workers = {
	    {x=885.606, y=-3199.558, z=-98.196, heading= 33.884},
	    {x= 893.9716, y= -3201.912, z= -98.19622, heading= 33.884},
	    {x= 889.994, y= -3201.95, z= -98.1963, heading= 100.0}
	}
	
	RequestModel(GetHashKey("s_m_m_scientist_01"))
	while not HasModelLoaded(GetHashKey("s_m_m_scientist_01")) do
		Wait(0)
	end

	for k,v in pairs(Workers) do
		worker = CreatePed(6, GetHashKey("s_m_m_scientist_01"), v.x, v.y, v.z, v.heading, true, false)
		SetBlockingOfNonTemporaryEvents(worker, true)
		SetEntityInvincible(worker, true)
	end

	SetModelAsNoLongerNeeded(GetHashKey("s_m_m_scientist_01"))
end


local function LoadMocInt()
	if not HasModelLoaded(GetHashKey("gr_prop_gr_trailer_monitor_03")) then 
		RequestModel(GetHashKey("gr_prop_gr_trailer_monitor_03"))
		while not HasModelLoaded(GetHashKey("gr_prop_gr_trailer_monitor_03")) do
			Wait(0)
		end
	end

	if not HasModelLoaded(-2083549178) then
		RequestModel(-2083549178)
		while not HasModelLoaded(-2083549178) do
			Wait(0)
		end
	end

	if DoesEntityExist(GetClosestObjectOfType(1102.596, -3001.493,-40.00575, 2.0, -2083549178, 0, 0, 0)) then 
		mocIntCarMod = GetClosestObjectOfType(1102.596, -3001.493,-40.00575, 2.0, -2083549178, 0, 0, 0)
		SetObjectTextureVariant(mocIntCarMod, 7)
	end

	if not DoesEntityExist(mocIntCarMod) then
		mocIntCarMod = CreateObjectNoOffset(-2083549178, 1102.596, -3001.493,-40.00575, 0, 1, 0)
		SetEntityRotation(mocIntCarMod, -0, -0, -0.1030985)
		SetEntityHeading(mocIntCarMod, 359.89691162109)	   
		FreezeEntityPosition(mocIntCarMod, 1)
		SetEntityCollision(mocIntCarMod, true, true)
		SetObjectTextureVariant(mocIntCarMod, 7)
	else
		SetObjectTextureVariant(mocIntCarMod, 7)
	end

	if not HasModelLoaded(-2104782239) then
		RequestModel(-2104782239)
	end

	if DoesEntityExist(GetClosestObjectOfType(1102.572, -3009.447, -39.98857, 2.0, -2104782239, 0, 0, 0)) then 
		mocIntCommand = GetClosestObjectOfType(1102.572, -3009.447, -39.98857, 2.0, -2104782239, 0, 0, 0)
	end

	if not DoesEntityExist(mocIntCommand) then
		mocIntCommand = CreateObjectNoOffset(-2104782239, 1102.572, -3009.447, -39.98857, 0, 1, 0)
		SetEntityRotation(mocIntCommand, -0, -0, -0.2033111)
		SetEntityHeading(mocIntCommand, 359.79669189453)	   
		FreezeEntityPosition(mocIntCommand, 1)

		SetEntityCollision(mocIntCommand, true, true)
		SetObjectTextureVariant(mocIntCommand, 7)
	else 
		SetObjectTextureVariant(mocIntCommand, 7)
	end

	if DoesEntityExist(GetClosestObjectOfType(1102.189, -3009.409, -39.97825, 2.0, -901846631, 0, 0, 0)) then 
		mocIntClosedDoor = GetClosestObjectOfType(1102.189, -3009.409, -39.97825, 2.0, -901846631, 0, 0, 0)
	end

	if not DoesEntityExist(mocIntClosedDoor) then
		mocIntClosedDoor = CreateObjectNoOffset(-901846631, 1102.189, -3009.409, -39.97825, 0, 1, 0)
		SetEntityRotation(mocIntClosedDoor, -0, -0, -179.9231)
		SetEntityHeading(mocIntClosedDoor, 180.07693481445)	   
		FreezeEntityPosition(mocIntClosedDoor, 1)
		SetEntityCollision(mocIntClosedDoor, true, true)
		SetObjectTextureVariant(mocIntClosedDoor, 7)
	else 
		SetObjectTextureVariant(mocIntClosedDoor, 7)
	end

	if not DoesEntityExist(mocMonitor3) then
		mocMonitor3 = CreateObjectNoOffset(GetHashKey("gr_prop_gr_trailer_monitor_03"), 1106.366, -3008.03, -40.01062, 0, 1, 0)     	   
		SetEntityRotation(mocMonitor3, -0, -0, 97.5754)
		SetEntityHeading(mocMonitor3, 97.575401306152)
		FreezeEntityPosition(mocMonitor3, 1)
	end
end

local function LoadBunkerPed()
	RequestModel(GetHashKey("MP_M_WeapExp_01"))
	while not HasModelLoaded(GetHashKey("MP_M_WeapExp_01")) do
		Wait(0)
	end

	bunkerPed = CreatePed(26, GetHashKey("MP_M_WeapExp_01"), 834.137, -3244.638, -98.699, -18.0, true, false)	
	SetBlockingOfNonTemporaryEvents(bunkerPed, true)	
	SetAmbientVoiceName(bunkerPed, "MALE_GENERICWORKER_R2PVG")
	SetEntityInvincible(bunkerPed, true)

	SetModelAsNoLongerNeeded(GetHashKey("MP_M_WeapExp_01"))
end

local function LoadBunkerInterior()
	RequestIpl("grdlc_int_01_shell")
	RequestIpl("gr_grdlc_int_01")
	RequestIpl("gr_grdlc_int_02")

	RequestIpl("gr_entrance_placement")
	RequestIpl("gr_grdlc_interior_placement")
	RequestIpl("gr_grdlc_interior_placement_interior_0_grdlc_int_01_milo_")

	RequestIpl("gr_grdlc_interior_placement_interior_1_grdlc_int_02_milo_")

	EnableInteriorProp(258561, "bunker_style_b")
	EnableInteriorProp(258561, "upgrade_bunker_set")
	EnableInteriorProp(258561, "upgrade_bunker_set_more")

	EnableInteriorProp(258561, "security_upgrade")
	EnableInteriorProp(258561, "Office_Upgrade_set")

	EnableInteriorProp(258561, "gun_range_lights")
	EnableInteriorProp(258561, "gun_schematic_set")
	EnableInteriorProp(258561, "gun_locker_upgrade")
	RefreshInterior(258561)
end

local function LoadBunkerTruck()
	if DoesEntityExist(GetClosestVehicle(890.708, -3236.804, -98.8961, 30.0, GetHashKey("hauler2"), 131078)) and DoesEntityExist(GetClosestVehicle(834.2265, -3234.795, -98.4865, 30.0, 1502869817, 131078)) then
	 mocTruck = GetClosestVehicle(834.2265, -3234.795, -98.4865, 30.0, GetHashKey("hauler2"), 131078)	 
	 SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(mocTruck), 0)

	 NetworkSetEntityVisibleToNetwork(mocTruck, 0)
	 SetEntityCollision(mocTruck, true, false)
	 
	 mocTrailer = GetClosestVehicle(842.6267, -3239.217, -96.8499, 30.0, GetHashKey("trailerlarge"), 131078)
	 SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(mocTrailer), 0)
	 NetworkSetEntityVisibleToNetwork(mocTrailer, 0)
	 SetEntityCollision(mocTrailer, true, false)

	else
		RequestModel(GetHashKey("trailerlarge"))
		RequestModel(GetHashKey("hauler2"))

		if not DoesEntityExist(mocTruck) and not DoesEntityExist(mocTrailer) then
			while not HasModelLoaded(GetHashKey("trailerlarge"))do
				Wait(0)
			end

			while not HasModelLoaded(GetHashKey("hauler2"))do
				Wait(0)
			end

			if HasModelLoaded(GetHashKey("hauler2")) and HasModelLoaded(GetHashKey("trailerlarge")) then
				mocTruck = CreateVehicle(GetHashKey("hauler2"), 834.2265, -3234.795, -98.4865, 62.28, true, false)		
				SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(mocTruck), 0)
				NetworkSetEntityVisibleToNetwork(mocTruck, 0)

				SetVehicleOnGroundProperly(mocTruck)
				SetVehicleDoorsLocked(mocTruck, 2)
				SetEntityProofs(mocTruck, true, true, true, true, true, false, 0, false)

				mocTrailer = CreateVehicle(GetHashKey("trailerlarge"), 842.6267, -3239.217, -96.8499, 62.28, true, false)
				SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(mocTrailer), 0)
				NetworkSetEntityVisibleToNetwork(mocTrailer, 0)
				SetEntityCollision(mocTrailer, true, false)

				AttachVehicleToTrailer(mocTruck, mocTrailer, 1.0)
			end

			SetModelAsNoLongerNeeded(GetHashKey("hauler2"))
			SetModelAsNoLongerNeeded(GetHashKey("trailerlarge"))
		end
	end
end

local function LoadBunkerCars()
	if DoesEntityExist(GetClosestVehicle(890.708, -3236.804, -98.8961, 1.0, GetHashKey("caddy3"))) then
		buggyA = GetClosestVehicle(887.824, -3236.251, -98.8946, 1.0, GetHashKey("caddy3"))
		SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(buggyA), 0)
		NetworkSetEntityVisibleToNetwork(buggyA, 0)

		SetVehicleExtra(buggyA, 2, false)
		SetVehicleExtra(buggyA, 3, false)
		SetVehicleExtra(buggyA, 1, false)
		ForceRoomForEntity(buggyA, 258561, -1116396409)
	end

	if DoesEntityExist(GetClosestVehicle(890.708, -3236.804, -98.8961, 1.0, GetHashKey("caddy3"))) then
		buggyB = GetClosestVehicle(890.708, -3236.804, -98.8961, 1.0, GetHashKey("caddy3"))
		SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(buggyB), 0)
		NetworkSetEntityVisibleToNetwork(buggyB, 0)
		
		SetVehicleExtra(buggyB, 2, true)
		SetVehicleExtra(buggyB, 3, true)
	    SetVehicleExtra(buggyB, 1, true)

	    ForceRoomForEntity(buggyB, 258561, -1116396409)
	end
	
	if not DoesEntityExist(buggyA) and not DoesEntityExist(buggyB) then
		RequestModel(GetHashKey("caddy3"))
		while not HasModelLoaded(GetHashKey("caddy3")) do
			Wait(0)
		end
		
		buggyA = CreateVehicle(GetHashKey("caddy3"), 887.824, -3236.251, -98.8946, 0.0, true, false)
		SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(buggyA), 0)
		NetworkSetEntityVisibleToNetwork(buggyA, 0)

		SetVehicleExtra(buggyA, 1, false)
     	SetVehicleExtra(buggyA, 2, false)
     	SetVehicleExtra(buggyA, 3, false)

     	buggyB = CreateVehicle(GetHashKey("caddy3"), 890.708, -3236.804, -98.8961, 0.0, true, false)	   
     	SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(buggyB), 1)
     	NetworkSetEntityVisibleToNetwork(buggyB, 0)

     	SetVehicleExtra(buggyB, 2, true)
     	SetVehicleExtra(buggyB, 3, true)
     	SetVehicleExtra(buggyB, 1, true)
     	ForceRoomForEntity(buggyB, 258561, -1116396409)

     	SetModelAsNoLongerNeeded(GetHashKey("caddy3"))
     end
 end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		DrawMarker(1, 2107.249, 3324.453, 45.377-1.0001, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 0.25, 240, 200, 80, 150, 0, 0, 1, 0, 0, 0, 0)

		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 2107.249, 3324.453, 45.377, true) <= 3.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_bunker"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				LoadBunkerInterior()
				SetEntityCoords(GetPlayerPed(-1), 887.65, -3245.10, -98.27)

				ExitBlip = AddBlipForCoord(894.5, -3245.75, -98.27)
				SetBlipSprite(ExitBlip, 1)
				SetBlipColour(ExitBlip, 2)

				Citizen.Wait(1000)

				LoadBunkerCars()
				LoadBunkerPed()
				LoadBunkerWorkers()
				Wait(1000)
				DoScreenFadeIn(1000)
			end
			LoadBunkerTruck()
			LoadMocInt()
		end

		if GetInteriorFromEntity(GetPlayerPed()) == 258561 then
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
			
			DisableControlAction(0, 22)
			DisableControlAction(0, 24)
			DisableControlAction(0, 25)

			 --this draws the marker to enter the MOC
			DrawMarker(1, 848.4579, -3242.338, -99.69917, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.52, 0, 255, 255, 150, 0, 0, 2, 0, 0, 0, false)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), 848.4579, -3242.338, -99.69917) < 5.8 and IsControlPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)
				
				SetEntityCoords(GetPlayerPed(-1), 1103.5620, -3000.00, -40.00)

				Wait(1500)
				DoScreenFadeIn(1500)
			end
		end

		--this draws the marker to return to the bunker from "MOC"
		DrawMarker(1, 1102.645, -2986.465, -39.99833, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.52, 0, 255, 255, 150, 0, 0, 2, 0, 0, 0, false )
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), 1102.645, -2986.465, -38.99833) < 3.8 and IsControlPressed(0, 38) then
			DoScreenFadeOut(1000)
			Citizen.Wait(1500)			
			
			SetEntityCoords(GetPlayerPed(-1), 885.982, -3245.716, -98.278)

			Wait(1500)
			DoScreenFadeIn(1500)
		end

		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 894.5, -3245.75, -98.27, true) <= 5.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_bunker"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)
				
				RemoveBlip(ExitBlip)
				RemoveIpl("grdlc_int_01_shell")
				RemoveIpl("gr_grdlc_int_01")

				RemoveIpl("gr_grdlc_int_02")
				RemoveIpl("gr_entrance_placement")
				RemoveIpl("gr_grdlc_interior_placement")

				RemoveIpl("gr_grdlc_interior_placement_interior_0_grdlc_int_01_milo_")
				RemoveIpl("gr_grdlc_interior_placement_interior_1_grdlc_int_02_milo_")

				SetEntityCoords(GetPlayerPed(-1), 2123.116, 3320.529, 45.388)				
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

	end
end)
