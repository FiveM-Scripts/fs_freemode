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
