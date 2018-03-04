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

local PickupCoords = {
    {x=1143.749, y=-978.367, z=46.318},
    {x=1142.027, y=-972.670, z=46.677},
    {x=-996.110, y=-2713.567, z=13.757},
    {x=-885.853, y=-2412.299, z=14.027},
    {x=15.969, y=-1037.577, z=29.227},
    {x=200.948, y=-994.595, z=30.092},
    {x=100.223, y=-755.834, z=45.755},
    {x=117.449, y=-750.921, z=45.752},
    {x=296.338, y=-784.338, z=29.312},
    {x=357.889, y=-612.280, z=28.869},
    {x=377.326, y=-573.213, z=28.833},
    {x=428.004, y=-974.924, z=30.710},
    {x=328.501, y=-1026.484, z=29.268},
    {x=-704.089, y=-933.703, z=19.212},
    {x=35.512, y=-1385.234, z=29.303},
    {x=33.403, y=-1343.712, z=29.497},
    {x=-570.576, y=272.442, z=82.948},
    {x=1848.365, y=2601.481, z=45.610},
    {x=2554.210, y=2641.352, z=38.247},
    {x=2687.311, y=3288.041, z=55.241},
    {x=-326.423, y=6070.209, z=31.230},
    {x=-302.960, y=6249.141, z=31.468},
    {x=-429.855, y=6029.012, z=31.490},
    {x=2147.467, y=4797.167, z=41.117},
    {x=1881.357, y=3690.446, z=33.299},
    {x=1819.470, y=3660.296, z=34.277},
    {x=1698.849, y=3748.714, z=34.384},
    {x=1702.903, y=3583.828, z=35.472},
    {x=1400.874, y=3600.110, z=35.033},
    {x=2749.731, y=3463.706, z=55.783},
    {x=1737.548, y=6406.425, z=34.951},
    {x=-115.789, y=6462.245, z=31.468},
    {x=-1080.784, y=4911.036, z=214.032},
    {x=-1698.612, y=-1132.911, z=13.153},
    {x=-1691.646, y=-1098.696, z=13.152},
    {x=-1651.891, y=-1027.900, z=13.152},
    {x=-1171.530, y=-1579.715, z=4.376},
    {x=283.551, y=183.093, z=104.456},
    {x=259.346, y=215.710, z=101.683},
    {x=245.356, y=83.715, z=92.775},
    {x=205.439, y=-3131.239, z=5.790},
    {x=178.288, y=-3307.095, z=6.029},
    {x=850.060, y=2374.763, z=54.251},
    {x=-1109.296, y=2690.767, z=18.609},
    {x=104.585, y=-1953.602, z=20.638},
    {x=2572.792, y=307.569, z=108.609}
}

Citizen.CreateThread(function() 
    if Setup.SpawnPickups then
        for k ,v in ipairs(PickupCoords) do
            local rPickup = PickupItems[GetRandomIntInRange(1, #PickupItems)]
            local pickup = CreatePickupRotate(GetHashKey(rPickup), v.x, v.y, v.z, 0, 0, 0, 512, 1, 1, 1, GetHashKey(rPickup))
            SetPickupRegenerationTime(pickup, 60)

            if Setup.debug then
                local pickupBlip = AddBlipForPickup(pickup)
                SetBlipAsShortRange(pickupBlip, true)
            end
        end
	end
end)