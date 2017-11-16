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
	StatSetInt("MP0_WALLET_BALANCE", cash, true)
end)

RegisterNetEvent("fs_freemode:notify")
AddEventHandler("fs_freemode:notify", function(icon, type, color, sender, title, text)
	Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
	SetNotificationTextEntry("STRING");
	AddTextComponentString(text);
	SetNotificationMessage(icon, icon, true, type, sender, title, text);
	DrawNotification(false, true);
end)

RegisterNetEvent('fs_freemode:spawnWeapons')
AddEventHandler('fs_freemode:spawnWeapons', function(weapon)
	Wait(1000)
	if Setup.debug == true then
		Citizen.Trace("Adding weapon: " .. weapon .."\n")
	end
	
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapon), 1000, false)
end)
