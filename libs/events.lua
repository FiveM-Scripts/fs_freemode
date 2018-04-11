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

function DrawPopup(text)
	ClearPrints()
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0, 1)
end

RegisterNetEvent("fs_freemode:displayPopup")
AddEventHandler("fs_freemode:displayPopup", function(text)
	DrawPopup(text)
end)

RegisterNetEvent("fs_freemode:displaytext")
AddEventHandler("fs_freemode:displaytext", function(text, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentScaleform(text)
	DrawSubtitleTimed(time, 1)
end)

RegisterNetEvent("fs_freemode:displayHelp")
AddEventHandler("fs_freemode:displayHelp", function(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end)

RegisterNetEvent("fs_freemode:initStats")
AddEventHandler("fs_freemode:initStats", function(cash)
	StatSetInt("MP0_WALLET_BALANCE", cash, false)
end)

RegisterNetEvent("fs_freemode:DisplayWanted")
AddEventHandler("fs_freemode:DisplayWanted", function(netid)
	gamerTagId = CreateMpGamerTag(GetPlayerPed(netid), "", false, false, "", 0)
	SetMpGamerTagVisibility(gamerTagId, 4, true)
	SetMpGamerTagAlpha(gamerTagId, 4, 240)
end)

RegisterNetEvent("fs_freemode:notify")
AddEventHandler("fs_freemode:notify", function(icon, type, color, sender, title, text)
	Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	SetNotificationMessage(icon, icon, true, type, sender, title, text)
	DrawNotification(false, true)

	PlaySoundFrontend(GetSoundId(), "Text_Arrive_Tone", "Phone_SoundSet_Default", true)
end)

RegisterNetEvent("fs_freemode:UpdateNofity")
AddEventHandler("fs_freemode:UpdateNofity", function()
	Citizen.Wait(30000)
	PlaySoundFrontend(GetSoundId(), "Text_Arrive_Tone", "Phone_SoundSet_Default", true)
	TriggerEvent("fs_freemode:notify", "CHAR_LESTER", 1, 167, "FiveM-Scripts", false, i18n.translate('update_available'))
end)

RegisterNetEvent('fs_freemode:spawnWeapons')
AddEventHandler('fs_freemode:spawnWeapons', function(weapon)
	Wait(1000)
	if Setup.debug == true then
	Citizen.Trace("Adding weapon: " .. weapon .."\n")
	end
	
	GiveWeaponToPed(PlayerPedId(), GetHashKey(weapon), -1, false)
end)