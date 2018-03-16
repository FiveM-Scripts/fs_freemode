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

local locations = {
  {name="Altruist Cult Camp", id=269, c=4, x=-1042.29, y=4910.17, z=94.92},
  {name="Ammu-Nation", id=110, c=4, x=1701.292, y=3750.450, z=34.365},
  {name="Ammu-Nation", id=110, c=4, x=237.428, y=-43.655, z=69.698},
  {name="Ammu-Nation", id=110, c=4, x=843.604, y=-1017.784, z=27.546},
  {name="Ammu-Nation", id=110, c=4, x=-321.524, y=6072.479, z=31.299},
  {name="Ammu-Nation", id=110, c=4, x=-664.218, y=-950.097, z=21.509},
  {name="Ammu-Nation", id=110, c=4, x=-1320.983, y=-389.260, z=36.483},
  {name="Ammu-Nation", id=110, c=4, x=-1109.053, y=2686.300, z=18.775},
  {name="Ammu-Nation", id=110, c=4, x=2568.379, y=309.629, z=108.461},
  {name="Ammu-Nation", id=110, c=4, x=-3157.450, y=1079.633, z=20.692},
  {name="Ammu-Nation", id=110, c=4, x=16.393, y=-1117.448, z=29.791},
  {name="Barber", id=71, c=4, x=-827.333, y=-190.916, z=37.599},
  {name="Barber", id=71, c=4, x=130.512, y=-1715.535, z=29.226},
  {name="Barber", id=71, c=4, x=-1291.472, y=-1117.230, z=6.641},
  {name="Barber", id=71, c=4, x=1936.451, y=3720.533, z=32.638},
  {name="Barber", id=71, c=4, x=1200.214, y=-468.822, z=66.268},
  {name="Barber", id=71, c=4, x=-30.109, y=-141.693, z=57.041},
  {name="Barber", id=71, c=4, x=-285.238, y=6236.365, z=31.455},
  {name="Carwash", id=100, c=4, x=55.7, y=-1391.3, z=30.5},
  {name="Carwash", id=100, c=4, x=-699.320, y=-941.078, z=19.077},
  {name="Comedy Club", id=102, c=4, x=-420.087, y=264.681, z=83.1927},
  {name="Facility", id=590, c=8, x=1837.92, y=220.767, z=176.917},
  {name="Movie Theater", id=135, c=4, x=298.278, y=195.984, z=104.313},
  {name="Masks store", id=362, c=4, x= -1166.284, y= -1586.368, z=4.377},
  {name="Strip club", id=121, c=4, x=134.476, y=-1307.887, z=28.983},
  {name="Tequil-La La", id=93, c=4, x=-565.171, y=276.625, z=83.286},
  {name="Gang", id=437, c=9, x=298.68, y=-2010.10, z=20.07},
  {name="Gang", id=437, c=9, x=86.64, y=-1924.60, z=20.79},
  {name="Gang", id=437, c=9, x=-183.52, y=-1632.62, z=33.34},
  {name="Gang", id=437, c=9, x=989.37, y=-1777.56, z=31.32},
  {name="Gang", id=437, c=9, x=960.24, y=-140.31, z=74.50},
  {name="Gang", id=437, c=9, x=29.4838, y=3735.593, z=38.688},
  {name="Gang", id=437, c=9, x=-455.752, y=-1711.884, z=18.642},
  {name="FIB", id=106, c=4, x=105.455, y=-745.483, z=44.754},
  {name="Premium Deluxe MotorSport", id=326, c=4, x=-67.264, y=-1091.146, z=26.632},
  {name="Prison", id=285, c=4, x=1679.049, y=2513.711, z=45.565},
  {name="Yacht", id=410, c=4, x=-2045.800, y=-1031.200, z=11.900},
  {name="Warehouse", id=473, c=4, x=958.50, y=-1586.30, z=30.0},
  {name="Warehouse", id=473, c=4, x=758.90, y=-909.15, z=30.0}, 
  {name="Warehouse", id=473, c=4, x=714.05, y=-716.50, z=30.0},  
  {name="Weed Production", id=496, c=4, x=1308.95, y=4362.15, z=30.0},
  {name="Cocaine Production ", id=497, c=4, x=387.40, y=3583.45, z=30.0},
  {name="Meth Production", id=499, c=4, x=1179.732, y=-3114.203, z=6.028},
  {name="Money Production", id=500, c=4, x=639.35, y=2769.65, z=30},
  {name="Fake ID Production", id=498, c=4, x=378.646, y=-834.4833, z=29.292},
  {name="Office", id=475, c=4, x=-43.954, y=-796.541, z=44.225},
  {name="Humane Labs", id=80, c=4, x=3624.632, y=3756.963, z=28.516},
  {name="Smoke on The water", id=140, c=2, x=-1174.073, y=-1573.562, z=4.372}
}

Citizen.CreateThread(function()
 if (Setup.blips == true) then
    for _, item in pairs(locations) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, item.c)

      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)

      SetBlipAsShortRange(item.blip, true)
    end
  end

  RequestIpl("facelobby") 
  RequestIpl("FIBlobby")
  RequestIpl("v_tunnel_hole")
  RequestIpl("v_tunnel_hole_lod")
  RequestIpl("v_tunnel_hole_swap")
  RequestIpl("v_tunnel_hole_swap_lod")
  RequestIpl("TrevorsTrailerTrash")
  RequestIpl("v_rockclub")
  RequestIpl("refit_unload")
  RequestIpl("post_hiest_unload")
  RequestIpl("FINBANK")
  RequestIpl("shr_int")
  RequestIpl("v_carshowroom")
  RequestIpl("Carwash_with_spinners")
  RequestIpl("KT_CarWash")
  RequestIpl("CS1_02_cf_onmission1")
  RequestIpl("CS1_02_cf_onmission2")
  RequestIpl("CS1_02_cf_onmission3")
  RequestIpl("CS1_02_cf_onmission4")
  RequestIpl("ferris_finale_Anim")
  RequestIpl("ufo")
  RequestIpl("ufo_lod")
  RequestIpl("ufo_eye")
  RequestIpl("v_comedy")
  RequestIpl("Plane_crash_trench")
  RemoveIpl("sp1_10_fake_interior")
  RemoveIpl("sp1_10_fake_interior_lod")
  RequestIpl("sp1_10_real_interior")
  RequestIpl("sp1_10_real_interior_lod") 
  RequestIpl("hei_yacht_heist")
  RequestIpl("hei_yacht_heist_Bar")
  RequestIpl("hei_yacht_heist_Bedrm")
  RequestIpl("hei_yacht_heist_Bridge")
  RequestIpl("hei_yacht_heist_DistantLights")
  RequestIpl("hei_yacht_heist_enginrm")
  RequestIpl("hei_yacht_heist_LODLights")
  RequestIpl("hei_yacht_heist_Lounge")
  RequestIpl("gr_case0_bunkerclosed")
  RequestIpl("gr_case1_bunkerclosed")
  RequestIpl("gr_case2_bunkerclosed")
  RequestIpl("gr_case3_bunkerclosed")
  RequestIpl("gr_case4_bunkerclosed")
  RequestIpl("gr_case5_bunkerclosed")
  RequestIpl("gr_case6_bunkerclosed")
  RequestIpl("gr_case7_bunkerclosed")
  RequestIpl("gr_case9_bunkerclosed")
  RequestIpl("gr_case10_bunkerclosed")
  RequestIpl("gr_case11_bunkerclosed")
  RequestIpl("lr_cs6_08_grave_closed") 
  RequestIpl("bkr_bi_id1_23_door")
  RequestIpl("bkr_bi_hw1_13_int")
  RequestIpl("bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo")
  RequestIpl("bkr_biker_interior_placement_interior_1_biker_dlc_int_02_milo")
  RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo")
  RequestIpl("bkr_biker_interior_placement_interior_3_biker_dlc_int_ware02_milo")
  RequestIpl("bkr_biker_interior_placement_interior_4_biker_dlc_int_ware03_milo") 
  RequestIpl("bkr_biker_interior_placement_interior_5_biker_dlc_int_ware04_milo")
  RequestIpl("bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo")
  RequestIpl("ex_exec_warehouse_placement_interior_1_int_warehouse_s_dlc_milo")
  RequestIpl("ex_exec_warehouse_placement_interior_0_int_warehouse_m_dlc_milo")  
  RequestIpl("ex_exec_warehouse_placement_interior_2_int_warehouse_l_dlc_milo")
  RequestIpl("ex_dt1_11_office_02c")
  RequestIpl("id2_14_during_door")
  RequestIpl("id2_14_during1")
  RequestIpl("apa_v_mp_h_04_b")
  RequestIpl("rc12b_default")
end)
