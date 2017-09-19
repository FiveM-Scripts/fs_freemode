local locations = {
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
  {name="Carwash", id=100, x=55.7, y=-1391.3, z=30.5},
  {name="Carwash", id=100, x=-699.320, y=-941.078, z=19.077},
  {name="Comedy Club", id=102, x=-420.087, y=264.681, z=83.1927},
  {name="Strip club", id=121, x=134.476, y=-1307.887, z=28.983},
  {name="Tequil-La La", id=93, x=-565.171, y=276.625, z=83.286},
  {name="Gang", id=437, x=298.68, y=-2010.10, z=20.07},
  {name="Gang", id=437, x=86.64, y=-1924.60, z=20.79},
  {name="Gang", id=437, x=-183.52, y=-1632.62, z=33.34},
  {name="Gang", id=437, x=989.37, y=-1777.56, z=31.32},
  {name="Gang", id=437, x=960.24, y=-140.31, z=74.50},
  {name="Gang", id=437, x=-1042.29, y=4910.17, z=94.92},
  {name="Gang", id=437, x=29.4838, y=3735.593, z=38.688},
  {name="Gang", id=437, x=-455.752, y=-1711.884, z=18.642},
  {name="FIB", id=106, x=105.455, y=-745.483, z=44.754},
  {name="Police station", id=60, x=425.130, y=-979.558, z=30.711},
  {name="Police station", id=60, x=1859.234, y= 3678.742, z=33.690},
  {name="Police station", id=60, x=-438.862, y=6020.768, z=31.490},
  {name="Police station", id=60, x=818.221, y=-1289.883, z=26.300},
  {name="Prison", id=285, x=1679.049, y=2513.711, z=45.565},
  {name="Yacht", id=410, x=-2045.800, y=-1031.200, z=11.900},
}

Citizen.CreateThread(function()
 if (Setup.blips == true) then
    for _, item in pairs(locations) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
  end

  -- Load needed IPLS
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
  RequestIpl("bkr_bi_id1_23_door")
  RequestIpl("bkr_bi_hw1_13_int")
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
end)
