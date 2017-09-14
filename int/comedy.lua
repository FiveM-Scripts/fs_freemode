Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    local player = GetPlayerPed(-1)
    local position = GetEntityCoords(player)

    DrawMarker(1, -420.087, 264.681, 83.1946-1.0001, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)

    if GetDistanceBetweenCoords(position.x, position.y, position.z, -420.087, 264.681, 83.1946) < 1.0 then
       SetEntityCoords(player, -454.825, 281.996, 78.5215-1.0001)
    end

    DrawMarker(1, -458.376, 282.69, 78.5215-1.0001, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(position.x, position.y, position.z, -458.376, 282.69, 78.5215) < 1.0 then
       SetEntityCoords(player, -431.807, 258.512, 82.9879-1.0001)
    end

  end
end)
