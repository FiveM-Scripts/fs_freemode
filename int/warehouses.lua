Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)

		DrawMarker(1, 1312.100, 4362.241, 40.855-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 3.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1312.100, 4362.241, 40.855, true) <= 5.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)
				SetEntityCoords(GetPlayerPed(-1), 1063.445, -3183.618, -39.164, 168.407)

				EnableInteriorProp(247297, "weed_upgrade_equip")
				EnableInteriorProp(247297, "weed_drying")
				EnableInteriorProp(247297, "weed_security_upgrade")

				EnableInteriorProp(247297, "weed_production")
				EnableInteriorProp(247297, "weed_set_up")
				EnableInteriorProp(247297, "weed_chairs")

				EnableInteriorProp(247297, "weed_growtha_stage3")
				EnableInteriorProp(247297, "weed_growthb_stage3")
				EnableInteriorProp(247297, "weed_growthc_stage3")

				EnableInteriorProp(247297, "weed_growthd_stage3")
				EnableInteriorProp(247297, "weed_growthe_stage3")
				EnableInteriorProp(247297, "weed_growthf_stage3")

				EnableInteriorProp(247297, "weed_growthg_stage3")
				EnableInteriorProp(247297, "weed_growthh_stage3")
				EnableInteriorProp(247297, "weed_growthi_stage3")

				EnableInteriorProp(247297, "weed_hosea")
				EnableInteriorProp(247297, "weed_hoseb")
				EnableInteriorProp(247297, "weed_hosec")

				EnableInteriorProp(247297, "weed_hosed")
				EnableInteriorProp(247297, "weed_hosee")
				EnableInteriorProp(247297, "weed_hosef")

				EnableInteriorProp(247297, "weed_hoseg")
				EnableInteriorProp(247297, "weed_hoseh")
				EnableInteriorProp(247297, "weed_hosei")

				EnableInteriorProp(247297, "light_growtha_stage23_upgrade")
				EnableInteriorProp(247297, "light_growthb_stage23_upgrade")
				EnableInteriorProp(247297, "light_growthc_stage23_upgrade")

				EnableInteriorProp(247297, "light_growthd_stage23_upgrade")
				EnableInteriorProp(247297, "light_growthe_stage23_upgrade")
				EnableInteriorProp(247297, "light_growthf_stage23_upgrade")

				EnableInteriorProp(247297, "light_growthg_stage23_upgrade")
				EnableInteriorProp(247297, "light_growthh_stage23_upgrade")
				EnableInteriorProp(247297, "light_growthi_stage23_upgrade")

				RefreshInterior(247297)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1065.430, -3182.969, -39.163, true) <= 5.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)
				
				SetEntityCoords(GetPlayerPed(-1), 1318.317, 4360.806, 41.170, 239.736)
				
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

		DrawMarker(1,387.636, 3585.846, 33.292-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 3.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 387.636, 3585.846, 33.292, true) <= 5.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(GetPlayerPed(-1), 1088.472, -3191.326, -38.993, 193.129)
				EnableInteriorProp(247553, "coke_cut_01")
				EnableInteriorProp(247553, "coke_cut_02")
				EnableInteriorProp(247553, "coke_cut_03")
				
				EnableInteriorProp(247553, "security_high")
				EnableInteriorProp(247553, "production_upgrade")
				EnableInteriorProp(247553, "equipment_upgrade")

				EnableInteriorProp(247553, "coke_cut_04")
				EnableInteriorProp(247553, "coke_cut_05")
				EnableInteriorProp(247553, "set_up")

				EnableInteriorProp(247553, "table_equipment_upgrade")
				EnableInteriorProp(247553, "coke_press_upgrade")
				RefreshInterior(247553)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end
	

		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1088.803, -3188.257, -38.993, true) <= 1.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(GetPlayerPed(-1), 396.205, 3588.555, 33.292, 68.051)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

		DrawMarker(1, 1180.180, -3113.763, 6.028-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 3.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1181.720, -3114.252, 6.028, true) <= 2.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)
				SetEntityCoords(GetPlayerPed(-1), 998.629, -3199.545, -36.394)

				EnableInteriorProp(247041, "meth_lab_upgrade")
				EnableInteriorProp(247041, "meth_lab_production")
				EnableInteriorProp(247041, "meth_lab_security_high")
				
				EnableInteriorProp(247041, "meth_lab_setup")
				RefreshInterior(247041)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end
		
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 996.933, -3200.605, -36.394, true) <= 1.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)
				
				SetEntityCoords(GetPlayerPed(-1), 1175.980, -3113.109, 6.028)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end		

	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 958.50, -1586.30, 30.0, true) <= 3.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(GetPlayerPed(-1), 1094.988, -3101.776, -39.00363)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1087.442, -3099.381, -39.000, true) <= 3.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(GetPlayerPed(-1), 963.946, -1585.238, 30.447)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end		

	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 758.885, -909.322, 25.433, true) <= 3.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(GetPlayerPed(-1), 1056.486, -3105.724, -39.00439)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1048.121, -3097.397, -39.000, true) <= 2.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(GetPlayerPed(-1), 764.240, -909.404, 25.249)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end

	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 713.872, -719.268, 26.073, true) <= 3.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(GetPlayerPed(-1), 1006.967, -3102.079, -39.0035)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1026.813, -3101.653, -39.000, true) <= 2.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(GetPlayerPed(-1), 716.450, -724.156, 25.971)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end

		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 639.965, 2773.929, 42.013, true) <= 5.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				EnableInteriorProp(247809, "counterfeit_security")
				EnableInteriorProp(247809, "counterfeit_cashpile100a")
				EnableInteriorProp(247809, "counterfeit_cashpile20a")

				EnableInteriorProp(247809, "counterfeit_cashpile10a")
				EnableInteriorProp(247809, "counterfeit_cashpile100b")
				EnableInteriorProp(247809, "counterfeit_cashpile100c")

				EnableInteriorProp(247809, "counterfeit_cashpile100d")
				EnableInteriorProp(247809, "counterfeit_cashpile20b")
				EnableInteriorProp(247809, "counterfeit_cashpile20c")

				EnableInteriorProp(247809, "counterfeit_cashpile20d")
				EnableInteriorProp(247809, "counterfeit_cashpile10b")
				EnableInteriorProp(247809, "counterfeit_cashpile10c")

				EnableInteriorProp(247809, "counterfeit_cashpile10d")
				EnableInteriorProp(247809, "counterfeit_setup")
				EnableInteriorProp(247809, "counterfeit_upgrade_equip")

				EnableInteriorProp(247809, "dryera_on")
				EnableInteriorProp(247809, "dryerb_on")
				EnableInteriorProp(247809, "dryerc_on")

				EnableInteriorProp(247809, "dryerd_on")
				EnableInteriorProp(247809, "money_cutter")
				EnableInteriorProp(247809, "special_chairs")

				RefreshInterior(247809)
				SetEntityCoords(GetPlayerPed(-1), 1121.897, -3195.338, -40.4025)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1118.683, -3193.319, -40.391, true) <= 2.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(GetPlayerPed(-1), 642.178, 2784.369, 41.975, 125.059)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end

		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 378.646, -834.4833, 29.292, true) <= 3.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				EnableInteriorProp(246785, "equipment_upgrade")
				EnableInteriorProp(246785, "production")
				EnableInteriorProp(246785, "security_high")

				EnableInteriorProp(246785, "set_up")
				EnableInteriorProp(246785, "clutter")
				EnableInteriorProp(246785, "interior_upgrade")

				EnableInteriorProp(246785, "chair01")
				EnableInteriorProp(246785, "chair02")
				EnableInteriorProp(246785, "chair03")

				EnableInteriorProp(246785, "chair04")
				EnableInteriorProp(246785, "chair05")
				EnableInteriorProp(246785, "chair06")
				EnableInteriorProp(246785, "chair07")

				RefreshInterior(246785) 
				SetEntityCoords(GetPlayerPed(-1), 1171.920, -3195.916, -39.008, 206.511)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1173.700, -3196.799, -39.008, true) <= 2.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(GetPlayerPed(-1), 366.980, -833.991, 29.292, 144.514)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
  
  end	
end)