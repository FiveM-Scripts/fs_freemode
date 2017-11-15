local function loadOffice()
	RequestModel(GetHashKey("mp_f_execpa_01"))
	while not HasModelLoaded(GetHashKey("mp_f_execpa_01")) do
		Wait(0)
	end

	local assistant = CreatePed(5, GetHashKey("mp_f_execpa_01"), -72.021, -814.392, 243.386, 153.236, false, false)
	SetBlockingOfNonTemporaryEvents(assistant, true)
	SetEntityInvincible(assistant, true)
		
	EnableInteriorProp(239617, "office_chairs")
	EnableInteriorProp(239617, "office_booze")

	EnableInteriorProp(239617, "cash_set_01")
	EnableInteriorProp(239617, "cash_set_02")
	EnableInteriorProp(239617, "cash_set_03")

	EnableInteriorProp(239617, "cash_set_04")
	EnableInteriorProp(239617, "cash_set_05")
	EnableInteriorProp(239617, "cash_set_06")
	EnableInteriorProp(239617, "cash_set_07")

	EnableInteriorProp(239617, "cash_set_08")
	EnableInteriorProp(239617, "cash_set_09")
	EnableInteriorProp(239617, "cash_set_10")

	EnableInteriorProp(239617, "cash_set_11")
	EnableInteriorProp(239617, "cash_set_12")
	EnableInteriorProp(239617, "cash_set_13")

	EnableInteriorProp(239617, "cash_set_14")
	EnableInteriorProp(239617, "cash_set_15")
	EnableInteriorProp(239617, "cash_set_16")

	EnableInteriorProp(239617, "cash_set_17")
	EnableInteriorProp(239617, "cash_set_18")
	EnableInteriorProp(239617, "cash_set_19")

	EnableInteriorProp(239617, "cash_set_20")
	EnableInteriorProp(239617, "cash_set_21")
	EnableInteriorProp(239617, "cash_set_22")

	EnableInteriorProp(239617, "cash_set_23")
	EnableInteriorProp(239617, "cash_set_24")
	EnableInteriorProp(239617, "swag_silver")

	EnableInteriorProp(239617, "swag_silver2")
	EnableInteriorProp(239617, "swag_silver3")
	EnableInteriorProp(239617, "swag_drugbags")

	EnableInteriorProp(239617, "swag_drugbags2")
	EnableInteriorProp(239617, "swag_drugbag3")
	EnableInteriorProp(239617, "swag_booze_cigs")

	EnableInteriorProp(239617, "swag_booze_cigs2")
	EnableInteriorProp(239617, "swag_booze_cigs3")
	EnableInteriorProp(239617, "swag_electronic")

	EnableInteriorProp(239617, "swag_electronic2")
	EnableInteriorProp(239617, "swag_electronic3")
	EnableInteriorProp(239617, "swag_drugstatue")

	EnableInteriorProp(239617, "swag_drugstatue2")
	EnableInteriorProp(239617, "swag_drugstatue3")
	EnableInteriorProp(239617, "swag_ivory")

	EnableInteriorProp(239617, "swag_ivory2")
	EnableInteriorProp(239617, "swag_ivory3")

	EnableInteriorProp(239617, "swag_pills")
	EnableInteriorProp(239617, "swag_pills2")
	EnableInteriorProp(239617, "swag_pills3")

	EnableInteriorProp(239617, "swag_jewelwatch")
	EnableInteriorProp(239617, "swag_jewelwatch2")
	EnableInteriorProp(239617, "swag_jewelwatch3")

	EnableInteriorProp(239617, "swag_furcoats")
	EnableInteriorProp(239617, "swag_furcoats2")
	EnableInteriorProp(239617, "swag_furcoats3")
	EnableInteriorProp(239617, "swag_art")

	EnableInteriorProp(239617, "swag_art2")
	EnableInteriorProp(239617, "swag_art3")
	EnableInteriorProp(239617, "swag_guns")

	EnableInteriorProp(239617, "swag_guns2")
	EnableInteriorProp(239617, "swag_guns3")
	EnableInteriorProp(239617, "swag_med")

	EnableInteriorProp(239617, "swag_med2")
	EnableInteriorProp(239617, "swag_med3")
	EnableInteriorProp(239617, "swag_gems")

	EnableInteriorProp(239617, "swag_gems2")
	EnableInteriorProp(239617, "swag_gems3")
	EnableInteriorProp(239617, "swag_counterfeit")

	EnableInteriorProp(239617, "swag_counterfeit2")
	EnableInteriorProp(239617, "swag_counterfeit3")

	RefreshInterior(239617)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)

		DrawMarker(1, -150.982, -874.066, 29.602-1.0001, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		DrawMarker(1, -50.148, -791.495, 44.225-1.0001, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)

		if GetDistanceBetweenCoords(playerCoords, -150.982, -874.066, 29.602, true) <= 2.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_office"))
			if IsControlJustPressed(0, 38) then
				loadOffice()
				SetEntityCoords(GetPlayerPed(-1), -75.8466, -826.9893, 243.3859)
			end
		end


		if GetDistanceBetweenCoords(playerCoords, -50.148, -791.495, 44.225-1.0001, true) <= 2.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_office"))
			if IsControlJustPressed(0, 38) then
				loadOffice()
				SetEntityCoords(GetPlayerPed(-1), -75.8466, -826.9893, 243.3859)
			end
		end		

		DrawMarker(1, -78.087, -832.295, 243.386-1.0001, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(playerCoords, -78.087, -832.295, 243.386, true) <= 3.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_office"))
			if IsControlJustPressed(0, 38) then
				SetEntityCoords(GetPlayerPed(-1), -40.487, -775.333, 44.227, 90.790, false)
			end
		end

	end
end)