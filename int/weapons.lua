local weaponPed = {}
local weaponsLoaded = false
local WeaponPurchased = false

local weapon_peds = {
  {model="s_m_m_ammucountry", voice="S_M_M_AMMUCOUNTRY_WHITE_MINI_01", x=1692.733, y=3761.895, z=34.705, a=218.535},
  {model="s_m_m_ammucountry", voice="S_M_M_AMMUCOUNTRY_WHITE_MINI_01", x=-330.933, y=6085.677, z=31.455, a=207.323},
  {model="s_m_y_ammucity_01", voice="S_M_Y_AMMUCITY_01_WHITE_MINI_01", x=253.629, y=-51.305, z=69.941, a=59.656},
  {model="s_m_y_ammucity_01", voice="S_M_Y_AMMUCITY_01_WHITE_MINI_01", x=841.363, y=-1035.350, z=28.195, a=328.528},
  {model="s_m_y_ammucity_01", voice="S_M_Y_AMMUCITY_01_WHITE_MINI_01", x=-661.317, y=-933.515, z=21.829, a=152.798},
  {model="s_m_y_ammucity_01", voice="S_M_Y_AMMUCITY_01_WHITE_MINI_01", x=-1304.413, y=-395.902, z=36.696, a=44.440},
  {model="s_m_y_ammucity_01", voice="S_M_Y_AMMUCITY_01_WHITE_MINI_01", x=-1118.037, y=2700.568, z=18.554, a=196.070},
  {model="s_m_y_ammucity_01", voice="S_M_Y_AMMUCITY_01_WHITE_MINI_01", x=2566.596, y=292.286, z=108.735, a=337.291},
  {model="s_m_y_ammucity_01", voice="S_M_Y_AMMUCITY_01_WHITE_MINI_01", x=-3173.182, y=1089.176, z=20.839, a=223.930},
  {model="s_m_y_ammucity_01", voice="S_M_Y_AMMUCITY_01_WHITE_MINI_01", x=23.394, y=-1105.455, z=29.797, a=147.921}
}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    playerPed = GetPlayerPed(-1)
    playerCoords = GetEntityCoords(playerPed, 0)

    if not weaponsLoaded then
      for k,v in pairs(weapon_peds) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
          Wait(1)
        end

        RequestAnimDict("random@shop_gunstore")
        while not HasAnimDictLoaded("random@shop_gunstore") do
          Wait(0)
        end

        weaponPed = CreatePed(4, GetHashKey(v.model), v.x, v.y, v.z, v.a, false, false)
        SetBlockingOfNonTemporaryEvents(weaponPed, true)
        SetPedFleeAttributes(weaponPed, 0, 0)
        SetEntityInvincible(weaponPed, true)
        -- Annimations
        SetAmbientVoiceName(weaponPed, v.voice)
        TaskPlayAnim(weaponPed,"random@shop_gunstore","_idle", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
      end
      weaponsLoaded = true
    end

    for k,v in pairs(weapon_peds) do
      local doordist = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, v.x, v.y, v.z)
      if doordist < 11 then
        SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
      end

      if doordist < 4 then
        TriggerEvent("fs_freemode:displayHelp", "Press ~INPUT_CONTEXT~ to browse weapons")
        if IsControlJustPressed(1, 46) then
          TriggerEvent("fivem-stores:weapon-menu:show", true)
        end
      end
    end

  end
end)


RegisterNetEvent("fivem-stores:SpawnWeapon")
AddEventHandler("fivem-stores:SpawnWeapon", function(weapon)
  Citizen.CreateThread(function()
  Citizen.Trace("i just bought a weapon\n")
  GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapon), 2000, false)
  PlaySoundFrontend(-1, "WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET", 1)
  end)
end)

RegisterNetEvent("fivem-stores:giveWeapon")
AddEventHandler("fivem-stores:giveWeapon", function(weapon, WeaponName)
  Citizen.CreateThread(function()
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapon), 2000, false)
    PlaySoundFrontend(-1, "WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET", 1)

    WeaponPurchased = true
    WeaponNamePurchased = WeaponName
  end)
end)

Citizen.CreateThread(function()
  local function WeaponMessage()
    if not HasScaleformMovieLoaded("MP_BIG_MESSAGE_FREEMODE") then
      purchase = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
      while not HasScaleformMovieLoaded(purchase) do
        Wait(0)
      end
    end

    PushScaleformMovieFunction(purchase, "SHOW_WEAPON_PURCHASED")
    PushScaleformMovieFunctionParameterString(i18n.translate("weapons_purchased"))
    PushScaleformMovieFunctionParameterString(tostring(WeaponNamePurchased))

    PopScaleformMovieFunctionVoid()
    DrawScaleformMovieFullscreen(purchase, 255, 255, 255, 255)
  end

  while true do
    Wait(0)
    if WeaponPurchased then
      WeaponMessage()
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(3885)
    if WeaponPurchased then
     SetScaleformMovieAsNoLongerNeeded(purchase)
     WeaponPurchased = false
    end
  end
end)
