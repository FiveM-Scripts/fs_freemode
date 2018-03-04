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

-- Configure the weed products
local weedItems = {
    {text="Amnesia Haze", price=12},
    {text="Blue Cheese", price=15},
    {text="Bubblegum", price=9},
    {text="Cheeze Haze", price=9},
    {text="Dr.Grinspoon", price=18},
    {text="G13 Haze", price=15},
    {text="Liberty Haze", price=17},
    {text="Mexican Haze", price=12},
    {text="N.L.X", price=6},
    {text="Silver", price=12},
    {text="Smoke mix", price=5},
    {text="Utopia Kush", price=17},
    {text="Vanilla Kush", price=15},
    {text="White Widow", price=9},
}

local toxicated = false

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if toxicated then
			Wait(120000)
			if HasClipSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") then
				ClearTimecycleModifier()
				SetPedMotionBlur(PlayerPedId(), false)

				ResetPedMovementClipset(PlayerPedId(), 0.0)
				ResetScenarioTypesEnabled()
				StopGameplayCamShaking(true)

				RemoveClipSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
			end
			toxicated = false
		end
	end
end)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('smokeMenu', 'default', i18n.translate("weedshop_title"))
    WarMenu.SetTitleColor('smokeMenu', 255, 255, 255)
    WarMenu.SetTitleBackgroundColor('smokeMenu', 255, 255, 255)
    WarMenu.SetSubTitle('smokeMenu', i18n.translate("items"))

    while true do
    	DrawMarker(1, -1172.406, -1572.292, 4.664-1.0001, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 107, 218, 16, 155, 0, 0, 2, 0, 0, 0, 0)
		
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
		if GetDistanceBetweenCoords(x, y, z, -1172.406, -1572.292, 4.664, true) < 0.5 then
			if not WarMenu.IsMenuOpened('smokeMenu') then
				TriggerEvent("fs_freemode:displayHelp", i18n.translate("weed_help"))
			end

			if WarMenu.IsMenuOpened('smokeMenu') then
            	TaskLookAtCoord(PlayerPedId(), -1170.822, -1571.044, 4.664, 1, 0, 2)
            	FreezeEntityPosition(PlayerPedId(), true)

				for k,v in pairs(weedItems) do
					if WarMenu.Button(v.text, Setup.Currency .. tonumber(v.price)) then
						WarMenu.CloseMenu('smokeMenu')
						TriggerServerEvent('fs_freemode:CheckMoneyForWeed', tonumber(v.price))
					end
				end
				
				if WarMenu.Button("Exit") then
					WarMenu.CloseMenu('smokeMenu')
					FreezeEntityPosition(PlayerPedId(), false)
				end

            WarMenu.Display()
            elseif IsControlJustReleased(0, 38) then           	
                WarMenu.OpenMenu('smokeMenu')
            end
		end

		if not WarMenu.IsMenuOpened("smokeMenu") then
			FreezeEntityPosition(PlayerPedId(), false)
		end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("fs_freemode:buyweed")
AddEventHandler("fs_freemode:buyweed", function()
	RequestClipSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")	
	while not HasClipSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Wait(0)
	end

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_DRUG_DEALER", 0, -1)	
	buyweed = true

	while buyweed do
		Wait(10000)
		ClearPedTasks(PlayerPedId())
		FreezeEntityPosition(PlayerPedId(), false)
		buyweed = false
	end

	ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.5)
	SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@SLIGHTLYDRUNK", 1048576000)
	SetPedMotionBlur(PlayerPedId(), true)

	SetTimecycleModifier("Drug_deadman_blend")
	toxicated = true
end)