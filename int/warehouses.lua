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

CokePeds = {}
ForgeryPeds = {}
ipls = {"xm_bunkerentrance_door", "xm_hatch_terrain", "xm_hatches_terrain_lod", "xm_hatch_closed"}

local CokePedCoords = {
	{gender= "female", x= 1091.372, y= -3196.633, z= -38.993, heading= 1.891},
	{gender= "female", x= 1094.478, y= -3194.840, z= -38.993, heading= 181.500},
	{gender= "male",   x= 1099.576, y= -3194.175, z= -38.993, heading= 100.681}
}

local ForgeryCoords = {
	{gender="male", x= 1162.75, y= -3196.93, z= -38.2319, heading= 297.480}
}

local function CreateCokePed(gender, x, y, z, heading)
    if gender == "male" then
       model = GetHashKey("mp_m_cocaine_01")
    elseif gender == "female" then
       model = GetHashKey("mp_f_cocaine_01")
    end

    RequestModel(model)
    while not HasModelLoaded(model) do
    	Citizen.Wait(0)
    end

    ped = CreatePed(26, model, x, y, z-1.0001, heading, false, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetModelAsNoLongerNeeded(model)

    table.insert(CokePeds, {ped = ped})
end

local function DeleteCokePed(i, index)
	if DoesEntityExist(i.ped) then
		DeleteEntity(i.ped)
		CokePeds[index] = nil
	end
end

local function CreateDocumentPed(gender, x, y, z, heading)
    if gender == "male" then
       model = GetHashKey("mp_m_forgery_01")
    elseif gender == "female" then
       model = GetHashKey("mp_f_forgery_01")
    end

    RequestModel(model)
    while not HasModelLoaded(model) do
    	Citizen.Wait(0)
    end

    ped = CreatePed(26, model, x, y, z-1.0001, heading, false, false)

    SetBlockingOfNonTemporaryEvents(ped, true)
    table.insert(ForgeryPeds, {ped = ped})
    SetModelAsNoLongerNeeded(model)
end

local function DeleteDocumentPed(i, index)
	if DoesEntityExist(i.ped) then
		DeleteEntity(i.ped)
		ForgeryPeds[index] = nil
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId(), true)

		DrawMarker(1, 1312.100, 4362.241, 40.855-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 3.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1312.100, 4362.241, 40.855, true) <= 5.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)
				SetEntityCoords(PlayerPedId(), 1063.445, -3183.618, -39.164, 168.407)

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
				
				SetEntityCoords(PlayerPedId(), 1318.317, 4360.806, 41.170, 239.736)
				
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

		DrawMarker(1,387.636, 3585.846, 33.292-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 3.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 387.636, 3585.846, 33.292, true) <= 5.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				for k,v in pairs(CokePedCoords) do
					CreateCokePed(v.gender, v.x, v.y, v.z, v.heading)
				end

				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 1088.472, -3191.326, -38.993, 193.129)

				EnableInteriorProp(247553, "coke_cut_01")
				EnableInteriorProp(247553, "coke_cut_02")
				EnableInteriorProp(247553, "coke_cut_03")
				EnableInteriorProp(247553, "coke_cut_04")
				EnableInteriorProp(247553, "coke_cut_05")
				EnableInteriorProp(247553, "coke_press_upgrade")

				EnableInteriorProp(247553, "equipment_upgrade")
				EnableInteriorProp(247553, "production_upgrade")
				EnableInteriorProp(247553, "security_high")
				EnableInteriorProp(247553, "set_up")

				EnableInteriorProp(247553, "table_equipment_upgrade")
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

				for n, i in pairs(CokePeds) do
					DeleteCokePed(i, n)
				end

				SetEntityCoords(PlayerPedId(), 396.205, 3588.555, 33.292, 68.051)

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
				SetEntityCoords(PlayerPedId(), 998.629, -3199.545, -36.394)

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
				
				SetEntityCoords(PlayerPedId(), 1175.980, -3113.109, 6.028)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end		

	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 958.50, -1586.30, 30.0, true) <= 3.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 1094.988, -3101.776, -39.00363)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1087.442, -3099.381, -39.000, true) <= 3.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 963.946, -1585.238, 30.447)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end		

	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 758.885, -909.322, 25.433, true) <= 3.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 1056.486, -3105.724, -39.00439)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1048.121, -3097.397, -39.000, true) <= 2.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 764.240, -909.404, 25.249)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end

	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 713.872, -719.268, 26.073, true) <= 3.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 1006.967, -3102.079, -39.0035)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1026.813, -3101.653, -39.000, true) <= 2.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 716.450, -724.156, 25.971)
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
				SetEntityCoords(PlayerPedId(), 1121.897, -3195.338, -40.4025)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1118.683, -3193.319, -40.391, true) <= 2.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 642.178, 2784.369, 41.975, 125.059)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end

		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 378.646, -834.4833, 29.292, true) <= 3.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate("enter_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				for k,v in pairs(ForgeryCoords) do
					print(k,v)
					CreateDocumentPed(v.gender, v.x, v.y, v.z, v.heading)
				end

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
				SetEntityCoords(PlayerPedId(), 1171.920, -3195.916, -39.008, 206.511)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
	if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1173.700, -3196.799, -39.008, true) <= 2.0 then
		TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				for n, i in pairs(ForgeryCoords) do
					DeleteDocumentPed(i, n)
				end

				SetEntityCoords(PlayerPedId(), 366.980, -833.991, 29.292, 144.514)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)				
			end
		end
  
  end	
end)

local function LoadFacilityIpls()
	for k,v in pairs(ipls) do
		if not IsIplActive(tostring(v)) then
			RequestIpl(tostring(v))
		end
	end	
end

local function RemoveFacilityIpls()
	for k,v in pairs(ipls) do
		if IsIplActive(tostring(v)) then
			RemoveIpl(tostring(v))
		end
	end	
end

local function AddFacilityInterior()
	interiorID = GetInteriorAtCoordsWithType(345.0041, 4822.001, -59.9997, "xm_x17dlc_int_02")
	if IsValidInterior(interiorID) then
		EnableInteriorProp(interiorID, "set_int_02_decal_01")
		SetInteriorPropColor(interiorID, "set_int_02_decal_01", 1)

		EnableInteriorProp(interiorID, "set_int_02_lounge1")
		SetInteriorPropColor(interiorID, "set_int_02_lounge1", 1)

		EnableInteriorProp(interiorID, "set_int_02_cannon")
		SetInteriorPropColor(interiorID, "set_int_02_cannon", 1)

		EnableInteriorProp(interiorID, "set_int_02_clutter1")
		SetInteriorPropColor(interiorID, "set_int_02_clutter1", 1)

		EnableInteriorProp(interiorID, "set_int_02_crewemblem")
		
		EnableInteriorProp(interiorID,   "set_int_02_shell")
		SetInteriorPropColor(interiorID, "set_int_02_shell", 1)

		EnableInteriorProp(interiorID, "set_int_02_security")
		SetInteriorPropColor(interiorID, "set_int_02_security", 1)

		EnableInteriorProp(interiorID,   "set_int_02_sleep")
		SetInteriorPropColor(interiorID, "set_int_02_sleep", 1)

		EnableInteriorProp(interiorID, "set_int_02_trophy1")
		SetInteriorPropColor(interiorID, "set_int_02_trophy1", 1)

		EnableInteriorProp(interiorID, "set_int_02_paramedic_complete")
		SetInteriorPropColor(interiorID, "set_int_02_paramedic_complete", 1)

		EnableInteriorProp(interiorID, "Set_Int_02_outfit_paramedic")
		SetInteriorPropColor(interiorID, "Set_Int_02_outfit_paramedic", 1)

		EnableInteriorProp(interiorID, "Set_Int_02_outfit_serverfarm")
		SetInteriorPropColor(interiorID, "Set_Int_02_outfit_serverfarm", 1)

		RefreshInterior(interiorID)
	end	
end

local function RemoveFacilityInterior()
	DisableInteriorProp(interiorID,  "set_int_02_decal_01")
	DisableInteriorProp(interiorID,  "set_int_02_lounge1")
	DisableInteriorProp(interiorID,  "set_int_02_cannon")
	DisableInteriorProp(interiorID,  "set_int_02_clutter1")
	DisableInteriorProp(interiorID,  "set_int_02_crewemblem")
	DisableInteriorProp(interiorID,  "set_int_02_shell")
	DisableInteriorProp(interiorID,  "set_int_02_security")
	DisableInteriorProp(interiorID,  "set_int_02_sleep")
	DisableInteriorProp(interiorID,  "set_int_02_trophy1")
	DisableInteriorProp(interiorID,  "set_int_02_paramedic_complete")
	DisableInteriorProp(interiorID,  "Set_Int_02_outfit_paramedic")
	DisableInteriorProp(interiorID,  "Set_Int_02_outfit_serverfarm")
end

Citizen.CreateThread(function()
	LoadFacilityIpls()
	
	while true do
		Wait(1)
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 1840.16, 226.137, 166.291, true) < 30.0 then
			DrawMarker(1, 1840.16, 226.137, 166.291-1.000, 0, 0, 0, 0, 0, 0, 1.75, 1.75, 1.0, 198, 148, 21, 155, 0, 0, 2, 0, 0, 0, 0)
		end

		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 1840.16, 226.137, 166.291, true) < 2.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate('enter_facility'))
			if IsControlJustPressed(0, 38) then
				SetAmbientZoneState("dlc_xm_int02_player_facility_zones", 1, 0)
				AddFacilityInterior()
				Wait(1000)
				DoScreenFadeOut(800)
				Wait(850)
				SetEntityCoordsNoOffset(PlayerPedId(), 482.51, 4832.033, -57.0314, -10.0613)
				Wait(850)
				DoScreenFadeIn(800)

				RemoveFacilityIpls()
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 486.558, 4819.76, -58.3828, true) < 50 then
			DrawMarker(1, 486.558, 4819.76, -58.3828-1.000, 0, 0, 0, 0, 0, 0, 0.75, 0.75, 1.0, 198, 148, 21, 155, 0, 0, 2, 0, 0, 0, 0)
		end

		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 430.9214, 4819.802, -59.8999, true) < 3.0 then
			PlaySoundFromCoord(-1, "scanner_alarm_os", 430.9214, 4819.802, -59.8999, "dlc_xm_iaa_player_facility_sounds", 1, 100, 0)
		end
	
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 486.558, 4819.76, -58.3828, true) < 2.0 then
			TriggerEvent("fs_freemode:displayHelp", i18n.translate('leave_facility'))
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(500)
				Wait(500)

				RemoveFacilityInterior()
				LoadFacilityIpls()
				SetEntityCoordsNoOffset(PlayerPedId(), 1837.62, 192.348, 172.318)

				Wait(500)
				DoScreenFadeIn(500)
			end
		end
	end
end)