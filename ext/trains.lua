local thisTrain
local trainCoords = {}
local storedTrains = {}

Citizen.CreateThread(function()
  -- Define the train models
  local trainModels = {"freight", "freightcar", "freightgrain", "freightcont1", "freightcont2","tankercar", "freighttrailer", "metrotrain"}

  -- Define the train coordinates
  local trains = {
    {type=0, x=-498.4123, y=4304.3, z=88.40305},
    {type=0, x=2324.3, y=2670.7, z=44.45},
    {type=0, x=1063.595, y=3227.571, z=39.3899},
    {type=7, x=2928.826, y=3572.775, z=54.0699},
    {type=15, x=217.616, y=-2215.75, z=11.6666},
    {type=22, x=1800.49, y=3504.19, z=37.9},
    {type=24, x=181.1, y=-1198.8, z=37.6},
  }

  -- Load the train models
  for i= 1, 8 do
    RequestModel(GetHashKey(trainModels[i]))
    while not HasModelLoaded(GetHashKey(trainModels[i])) do
      Citizen.Wait(1)
    end
  end

 -- Load the traindriver
  RequestModel(GetHashKey("s_m_m_lsmetro_01"))
  while not HasModelLoaded(GetHashKey("s_m_m_lsmetro_01")) do
    Citizen.Wait(1)
  end

  -- Start the trains
  for i=1, 7, 1 do
    local trainCoords = trains[i]
    local thisTrain = CreateMissionTrain(trainCoords.type, trainCoords.x, trainCoords.y, trainCoords.z, true)
    SetEntityProofs(thisTrain, true, true, true, true, true, false, 0, false)
    SetEntityAsMissionEntity(thisTrain, true, true)
    CreatePedInsideVehicle(thisTrain, 26, GetHashKey("s_m_m_lsmetro_01"), -1, 1, true)
    table.insert(storedTrains, {train = thisTrain})
  end
end)
