RegisterNetEvent("fs_core:displaytext")
AddEventHandler("fs_core:displaytext", function(text, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentScaleform(text)
	DrawSubtitleTimed(time, 1)
end)

RegisterNetEvent("fs_core:displayHelp")
AddEventHandler("fs_core:displayHelp", function(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end)

RegisterNetEvent("fs_core:notify")
AddEventHandler("fs_core:notify", function(icon, type, color, sender, title, text)
	Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
	SetNotificationTextEntry("STRING");
	AddTextComponentString(text);
	SetNotificationMessage(icon, icon, true, type, sender, title, text);
	DrawNotification(false, true);
end)
