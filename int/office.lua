local assistant = nil

local function CreateAssistantPed()
	if not DoesEntityExist(assistant) then

		RequestModel(GetHashKey("mp_f_execpa_01"))
		while not HasModelLoaded(GetHashKey("mp_f_execpa_01")) do
			Wait(0)
		end

		assistant = CreatePed(5, GetHashKey("mp_f_execpa_01"),-72.011, -814.007, 243.384-1.0001, false, false)
		SetEntityHeading(assistant, 153.236)
		
		SetPedComponentVariation(assistant, 3, 2, 0, 0)
		SetPedComponentVariation(assistant, 11, 1, 0, 0)
		SetPedComponentVariation(assistant, 8, 2, 0, 0)
		SetPedComponentVariation(assistant, 4, 2, 0, 0)

		SetBlockingOfNonTemporaryEvents(assistant, true)
		SetEntityInvincible(assistant, true)
	end
end

local function EnableOfficeInterior(interiorID)		

	EnableInteriorProp(interiorID, "office_chairs")
	EnableInteriorProp(interiorID, "office_booze")

	EnableInteriorProp(interiorID, "cash_set_01")
	EnableInteriorProp(interiorID, "cash_set_02")
	EnableInteriorProp(interiorID, "cash_set_03")

	EnableInteriorProp(interiorID, "cash_set_04")
	EnableInteriorProp(interiorID, "cash_set_05")
	EnableInteriorProp(interiorID, "cash_set_06")
	EnableInteriorProp(interiorID, "cash_set_07")

	EnableInteriorProp(interiorID, "cash_set_08")
	EnableInteriorProp(interiorID, "cash_set_09")
	EnableInteriorProp(interiorID, "cash_set_10")

	EnableInteriorProp(interiorID, "cash_set_11")
	EnableInteriorProp(interiorID, "cash_set_12")
	EnableInteriorProp(interiorID, "cash_set_13")

	EnableInteriorProp(interiorID, "cash_set_14")
	EnableInteriorProp(interiorID, "cash_set_15")
	EnableInteriorProp(interiorID, "cash_set_16")

	EnableInteriorProp(interiorID, "cash_set_17")
	EnableInteriorProp(interiorID, "cash_set_18")
	EnableInteriorProp(interiorID, "cash_set_19")

	EnableInteriorProp(interiorID, "cash_set_20")
	EnableInteriorProp(interiorID, "cash_set_21")
	EnableInteriorProp(interiorID, "cash_set_22")

	EnableInteriorProp(interiorID, "cash_set_23")
	EnableInteriorProp(interiorID, "cash_set_24")
	EnableInteriorProp(interiorID, "swag_silver")

	EnableInteriorProp(interiorID, "swag_silver2")
	EnableInteriorProp(interiorID, "swag_silver3")
	EnableInteriorProp(interiorID, "swag_drugbags")

	EnableInteriorProp(interiorID, "swag_drugbags2")
	EnableInteriorProp(interiorID, "swag_drugbag3")
	EnableInteriorProp(interiorID, "swag_booze_cigs")

	EnableInteriorProp(interiorID, "swag_booze_cigs2")
	EnableInteriorProp(interiorID, "swag_booze_cigs3")
	EnableInteriorProp(interiorID, "swag_electronic")

	EnableInteriorProp(interiorID, "swag_electronic2")
	EnableInteriorProp(interiorID, "swag_electronic3")
	EnableInteriorProp(interiorID, "swag_drugstatue")

	EnableInteriorProp(interiorID, "swag_drugstatue2")
	EnableInteriorProp(interiorID, "swag_drugstatue3")
	EnableInteriorProp(interiorID, "swag_ivory")

	EnableInteriorProp(interiorID, "swag_ivory2")
	EnableInteriorProp(interiorID, "swag_ivory3")

	EnableInteriorProp(interiorID, "swag_pills")
	EnableInteriorProp(interiorID, "swag_pills2")
	EnableInteriorProp(interiorID, "swag_pills3")

	EnableInteriorProp(interiorID, "swag_jewelwatch")
	EnableInteriorProp(interiorID, "swag_jewelwatch2")
	EnableInteriorProp(interiorID, "swag_jewelwatch3")

	EnableInteriorProp(interiorID, "swag_furcoats")
	EnableInteriorProp(interiorID, "swag_furcoats2")
	EnableInteriorProp(interiorID, "swag_furcoats3")
	EnableInteriorProp(interiorID, "swag_art")

	EnableInteriorProp(interiorID, "swag_art2")
	EnableInteriorProp(interiorID, "swag_art3")
	EnableInteriorProp(interiorID, "swag_guns")

	EnableInteriorProp(interiorID, "swag_guns2")
	EnableInteriorProp(interiorID, "swag_guns3")
	EnableInteriorProp(interiorID, "swag_med")

	EnableInteriorProp(interiorID, "swag_med2")
	EnableInteriorProp(interiorID, "swag_med3")
	EnableInteriorProp(interiorID, "swag_gems")

	EnableInteriorProp(interiorID, "swag_gems2")
	EnableInteriorProp(interiorID, "swag_gems3")

	EnableInteriorProp(interiorID, "swag_counterfeit")
	EnableInteriorProp(interiorID, "swag_counterfeit2")
	EnableInteriorProp(interiorID, "swag_counterfeit3")

	RefreshInterior(interiorID)
end

local function SetOrganisationName()
	local targetHash = -2082168399
	banner = RequestScaleformMovie("ORGANISATION_NAME")

	if HasScaleformMovieLoaded(banner) then
		playerID = PlayerId()
		playerName = GetPlayerName(playerID)

		PushScaleformMovieFunction(banner, "SET_ORGANISATION_NAME")
		PushScaleformMovieFunctionParameterString(tostring(playerName))

		PushScaleformMovieFunctionParameterInt(-1) -- scale
		PushScaleformMovieFunctionParameterInt(0) -- color
		PushScaleformMovieFunctionParameterInt(2) -- font
		PopScaleformMovieFunction()
	end

	if (not IsNamedRendertargetRegistered("prop_ex_office_text")) then
	    RegisterNamedRendertarget("prop_ex_office_text", 0)
        LinkNamedRendertarget(targetHash)

        Wait(500)

        if (not IsNamedRendertargetLinked(targetHash)) then
            ReleaseNamedRendertarget(GetHashKey("prop_ex_office_text"))
        end
    end

	local renderID = GetNamedRendertargetRenderId("prop_ex_office_text")
	SetTextRenderId(renderID)
	DrawScaleformMovie(banner, 0.196*1.75, 0.345*1.5, 0.46*2.5, 0.66*2.5, 255, 255, 255, 255, 1)
	SetTextRenderId(GetDefaultScriptRendertargetRenderId())
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId(), true)
		local interiorCode = GetInteriorFromEntity(PlayerPedId())
		local intCoords = GetInteriorAtCoords(-72.021, -814.392, 243.386)

		DrawMarker(1, -50.148, -791.495, 44.225-1.0001, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)

		if GetDistanceBetweenCoords(playerCoords, -50.148, -791.495, 44.225-1.0001, true) <= 2.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_office"))
			if IsControlJustPressed(0, 38) then
				SetEntityCoords(PlayerPedId(), -75.8466, -826.9893, 243.3859)
				if not DoesEntityExist(assistant) then
					CreateAssistantPed()
				end

				EnableOfficeInterior(intCoords)
				PlayerInsideOffice = true
			end
		end

		if PlayerInsideOffice then
			DrawMarker(1, -78.087, -832.295, 243.386-1.0001, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			SetOrganisationName()
		else
			SetScaleformMovieAsNoLongerNeeded(banner)
		end

		if GetDistanceBetweenCoords(playerCoords, -78.087, -832.295, 243.386, true) <= 3.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_office"))
			if IsControlJustPressed(0, 38) then
				SetEntityCoords(PlayerPedId(), -40.487, -775.333, 44.227, 90.790, false)
				SetEntityAsNoLongerNeeded(assistant)
				PlayerInsideOffice = false
			end
		end

	end
end)