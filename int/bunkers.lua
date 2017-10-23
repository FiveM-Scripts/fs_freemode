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
		if not DoesEntityExist(mocTruck) and not DoesEntityExist(mocTrailer) then
		RequestModel(GetHashKey("trailerlarge"))
		RequestModel(GetHashKey("hauler2"))
				
		while not HasModelLoaded(GetHashKey("trailerlarge"))do
			Wait(1)
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

			SetModelAsNoLongerNeeded(GetHashKey("hauler2"))
			SetModelAsNoLongerNeeded(GetHashKey("trailerlarge"))
		end
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

				LoadBunkerTruck()
				LoadBunkerCars()
				Wait(1000)		
				DoScreenFadeIn(1000)
			end
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
