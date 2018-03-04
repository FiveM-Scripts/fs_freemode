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

local thisTrain
local trainCoords = {}
local storedTrains = {}

Citizen.CreateThread(function()
  if Setup.TrainsEnabled then
    if NetworkIsHost() then

      local trainModels = {"freight", "freightcar", "freightgrain", "freightcont1", "freightcont2","tankercar", "freighttrailer", "metrotrain"}
      local trains = {
        {type=0, x=-498.4123, y=4304.3, z=88.40305},
        {type=0, x=2324.3, y=2670.7, z=44.45},
        {type=0, x=1063.595, y=3227.571, z=39.3899},
        {type=7, x=2928.826, y=3572.775, z=54.0699},
        {type=15, x=217.616, y=-2215.75, z=11.6666},
        {type=22, x=1800.49, y=3504.19, z=37.9},
        {type=24, x=181.1, y=-1198.8, z=37.6},
      }

      for i= 1, 8 do
        RequestModel(GetHashKey(trainModels[i]))
        while not HasModelLoaded(GetHashKey(trainModels[i])) do
          Citizen.Wait(1)
        end
      end

      RequestModel(GetHashKey("s_m_m_lsmetro_01"))
      while not HasModelLoaded(GetHashKey("s_m_m_lsmetro_01")) do
        Citizen.Wait(1)
      end

      for i=1, 7, 1 do
        Citizen.Wait(5000)
        local trainCoords = trains[i]
        local thisTrain = CreateMissionTrain(trainCoords.type, trainCoords.x, trainCoords.y, trainCoords.z, true)
        NetworkRegisterEntityAsNetworked(thisTrain)
        SetNetworkIdCanMigrate(thisTrain, true)
        Wait(5000)

        SetEntityProofs(thisTrain, true, true, true, true, true, false, 0, false)
        SetEntityAsMissionEntity(thisTrain, true, true)
        CreatePedInsideVehicle(thisTrain, 26, GetHashKey("s_m_m_lsmetro_01"), -1, 1, true)

        if Setup.debug then
          blip = AddBlipForEntity(thisTrain)
          SetBlipColour(blip, 9)      
          table.insert(storedTrains, {train = thisTrain, blip = blip})
        else
          table.insert(storedTrains, {train = thisTrain})
        end
      end

      for i= 1, 8 do
        SetModelAsNoLongerNeeded(GetHashKey(trainModels[i]))
      end

      SetEntityAsNoLongerNeeded(GetHashKey("s_m_m_lsmetro_01"))
    end
  end
end)
