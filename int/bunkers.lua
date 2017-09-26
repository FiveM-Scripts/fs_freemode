Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)

		DrawMarker(1, 2107.249, 3324.453, 45.377-1.0001, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 0.25, 240, 200, 80, 150, 0, 0, 1, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 2107.249, 3324.453, 45.377, true) <= 3.0 then
			TriggerEvent("fs_freemode:displayHelp", "Press ~INPUT_CONTEXT~ to enter the bunker")
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

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
				
				SetEntityCoords(GetPlayerPed(-1), 887.65, -3245.10, -98.27)

				ExitBlip = AddBlipForCoord(894.5, -3245.75, -98.27)
				SetBlipSprite(ExitBlip, 1)
				SetBlipColour(ExitBlip, 2)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 894.5, -3245.75, -98.27, true) <= 5.0 then
			TriggerEvent("fs_freemode:displayHelp", "Press ~INPUT_CONTEXT~ to exit the bunker")
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
