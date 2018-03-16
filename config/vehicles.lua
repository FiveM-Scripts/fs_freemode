-- No need to change the CarGroups table.
carGroups = {
   {name="Compacts", type="compacts"},
   {name="Coupes", type="coupes"},
   {name="Muscle", type="muscle"},
   {name="Off-Road", type="offroad"},
   {name="Sedans", type="sedans"},
   {name="Sports", type="sports"}, 
   {name="Sport Classics", type="sportclassics"},
   {name="Super", type="super"},
   {name="SUVs", type="suvs"},
   {name="Vans", type="vans"}
}

-- Change vehicle prices below
compacts = {
   {name= "Blista", costs = 15000, model = "blista"},
   {name= "Brioso R/A", costs = 155000, model = "brioso"},
   {name= "Dilettante", costs = 25000, model = "Dilettante"},
   {name= "Issi", costs = 18000, model = "issi2"},
   {name= "Panto", costs = 85000, model = "panto"},
   {name= "Prairie", costs = 30000, model = "prairie"},
   {name= "Rhapsody", costs = 120000, model = "rhapsody"}
}

coupes = { 
  {name= "Albany Hermes", costs=9800, model="hermes"},
  {name= "Cognoscenti Cabrio", costs = 180000, model = "cogcabrio"},
  {name= "Exemplar", costs = 200000, model = "exemplar"},
  {name= "F620", costs = 80000, model= "f620"},
  {name= "Felon", costs = 90000, model= "felon"},
  {name= "Felon GT", costs = 95000, model= "felon2"},
  {name= "Jackal", costs = 60000, model= "jackal"},
  {name= "Oracle", costs = 80000, model= "oracle"},
  {name= "Oracle XS", costs = 82000, model= "oracle2"},
  {name= "Sentinel", costs = 90000, model= "sentinel"},
  {name= "Sentinel XS", costs = 60000, model= "sentinel2"},
  {name= "Windsor", costs = 800000, model= "windsor"},
  {name= "Windsor Drop", costs = 850000, model= "windsor2"},
  {name= "Zion", costs = 60000, model = "zion"},
  {name= "Zion Cabrio", costs = 65000, model = "zion2"}
}

sedans = {
        {name = "Asea", costs = 1000000, model = "asea"},
        {name = "Asterope", costs = 1000000, model = "asterope"},
        {name = "Cognoscenti", costs = 1000000, model = "cognoscenti"},
        {name = "Cognoscenti(Armored)", costs = 1000000, model = "cognoscenti2"},
        {name = "Cognoscenti 55", costs = 1000000, model = "cognoscenti3"},
        {name = "Cognoscenti 55(Armored", costs = 1500000, model = "ZENTORNO"},
        {name = "Fugitive", costs = 24000, model = "fugitive"},
        {name = "Glendale", costs = 200000, model = "glendale"},
        {name = "Ingot", costs = 9000, model = "ingot"},
        {name = "Intruder", costs = 16000, model = "intruder"},
        {name = "Premier", costs = 10000, model = "premier"},
        {name = "Primo", costs = 9000, model = "primo"},
        {name = "Primo Custom", costs = 9500, model = "primo2"},
        {name = "Regina", costs = 8000, model = "regina"},
        {name = "Schafter", costs = 65000, model = "schafter2"},
        {name = "Stanier", costs = 10000, model = "stanier"},
        {name = "Stratum", costs = 10000, model = "stratum"},
        {name = "Stretch", costs = 30000, model = "stretch"},
        {name = "Super Diamond", costs = 250000, model = "superd"},
        {name = "Surge", costs = 38000, model = "surge"},
        {name = "Tailgater", costs = 55000, model = "tailgater"},
        {name = "Warrener", costs = 120000, model = "warrener"},
        {name = "Washington", costs = 15000, model = "washington"}
}

sports = {
   {name= "9F", costs = 120000, model = "ninef"},
   {name= "9F Cabrio", costs = 130000, model = "ninef2"},
   {name= "Alpha", costs = 150000, model = "alpha"},
   {name= "Banshee", costs = 105000, model = "banshee"},
   {name= "Bestia GTS", costs = 610000, model = "bestiagts"},
   {name= "Blista Compact", costs = 42000, model = "blista"},
   {name= "Buffalo", costs = 35000, model = "buffalo"},
   {name= "Buffalo S", costs = 96000, model = "buffalo2"},
   {name= "Carbonizzare", costs = 195000, model = "carbonizzare"},
   {name= "Comet", costs = 100000, model = "comet2"},
   {name= "Comet Retro Custom", costs = 100000, model = "comet2"},   
   {name= "Coquette", costs = 138000, model = "coquette"},
   {name= "Drift Tampa", costs = 995000, model = "tampa2"},
   {name= "Feltzer", costs = 130000, model = "feltzer2"},
   {name= "Furore GT", costs = 448000, model = "furoregt"},
   {name= "Fusiladzae", costs = 36000, model = "fusilade"},
   {name= "Jester", costs = 240000, model = "jester"},
   {name= "Jester(Racecar)", costs = 350000, model = "jester2"},
   {name= "Kuruma", costs = 95000, model = "kuruma"},
   {name= "Lynx", costs = 1735000, model = "lynx"},
   {name= "Massacro", costs = 275000, model = "massacro"},
   {name= "Massacro(Racecar)", costs = 385000, model = "massacro2"},
   {name= "Omnis", costs = 701000, model = "omnis"},
   {name= "Ruiner 2000", costs=5745600, model= "ruiner2"},
   {name= "Penumbra", costs = 24000, model = "penumbra"},
   {name= "Coil Raiden", costs = 2400, model = "raiden"},
   {name= "Rapid GT", costs = 140000, model = "rapidgt"},
   {name= "Rapid GT Convertible", costs = 150000, model = "rapidgt2"},
   {name= "Ocelot Pariah", costs = 250000, model = "pariah"},
   {name= "Schafter V12", costs = 140000, model = "schafter3"},
   {name= "Sultan", costs = 12000, model = "sultan"},
   {name= "Surano", costs = 110000, model = "surano"},
   {name= "Tropos", costs = 816000, model = "tropos"},
   {name= "Verkierer", costs = 695000, model = "verlierer2"}  
}

sportclassics = {
  {name = "Casco", costs = 680000, model = "casco"},
  {name = "Coquette Classic", costs = 665000, model = "coquette2"},
  {name = "JB 700", costs = 350000, model = "jb700"},
  {name = "Lampadati Viseris", costs=450000, model= "viseris"},
  {name = "Pigalle", costs = 400000, model = "pigalle"},
  {name = "Stinger", costs = 850000, model = "stinger"},
  {name = "Stinger GT", costs = 875000, model = "stingergt"},
  {name = "Stirling GT", costs = 975000, model = "feltzer3"},
  {name = "Z-Type", costs = 950000, model = "ztype"}
}

super = {
   {name = "Adder", costs = 1000000, model = "adder"},
   {name = "Banshee 900R", costs = 565000, model = "banshee2"},
   {name = "Bullet", costs = 155000, model = "bullet"},
   {name = "Cheetah", costs = 650000, model = "cheetah"},
   {name = "Entity XF", costs = 795000, model = "entityxf"},
   {name = "ETR1", costs = 199500, model = "sheava"},
   {name = "FMJ", costs = 1750000, model = "fmj"},
   {name = "Infernus", costs = 440000, model = "infernus"},
   {name = "Osiris", costs = 1950000, model = "osiris"},
   {name = "Overflod Autarch", costs=2250000, model= "autarch"},
   {name = "RE-7B", costs = 2475000, model = "le7b"},
   {name = "Reaper", costs = 1595000, model = "reaper"},
   {name = "Sultan RS", costs = 795000, model = "sultanrs"},
   {name = "T20", costs = 2200000, model = "t20"},
   {name = "Turismo R", costs = 500000, model = "turismor"},
   {name = "Tyrus", costs = 2550000, model = "tyrus"},
   {name = "Ubermacht SC1", costs=2200000, model = "sc1"},
   {name = "Vacca", costs = 240000, model = "vacca"},
   {name = "Voltic", costs = 150000, model = "voltic"},
   {name = "X80 Proto", costs = 2700000, model = "prototipo"},
   {name = "Zentorno", costs = 725000, model = "zentorno"}
}

muscle = {
    {name = "Blade", costs = 160000, model = "blade"},
    {name = "Buccaneer", costs = 29000, model = "buccaneer"},
    {name = "Chino", costs = 225000, model = "chino"},
    {name = "Coquette BlackFin", costs = 695000, model = "coquette3"},
    {name = "Dominator", costs = 35000, model = "dominator"},
    {name = "Dukes", costs = 62000, model = "dukes"},
    {name = "Gauntlet", costs = 32000, model = "gauntlet"},
    {name = "Hotknife", costs = 90000, model = "hotknife"},
    {name = "Faction", costs = 36000, model = "faction"},
    {name = "Nightshade", costs = 585000, model = "nightshade"},
    {name = "Picador", costs = 9000, model = "picador"},
    {name = "Sabre Turbo", costs = 15000, model = "sabregt"},
    {name = "Tampa", costs = 375000, model = "tampa"},
    {name = "Virgo", costs = 195000, model = "virgo"},
    {name = "Vigero", costs = 21000, model = "vigero"},
  }

offroad = {
    {name = "Bifta", costs = 75000, model = "bifta"},
    {name = "Blazer", costs = 8000, model = "blazer"},
    {name = "Brawler", costs = 715000, model = "brawler"},
    {name = "Bubsta 6x6", costs = 249000, model = "dubsta3"},
    {name = "Canis Kamacho", costs = 35000, model="kamacho"},
    {name = "Dune Buggy", costs = 20000, model = "dune"},
    {name = "Rebel", costs = 22000, model = "rebel2"},
    {name = "Sandking", costs = 38000, model = "sandking"},
    {name = "The Liberator", costs = 550000, model = "monster"},
    {name = "Trophy Truck", costs = 550000, model = "trophytruck"},
    {name = "Vapid Riata", costs = 38000, model="riata"},
}

suvs = {
    {name = "Baller", costs = 90000, model = "baller"},
    {name = "Cavalcade", costs = 60000, model = "cavalcade"},
    {name = "Grabger", costs = 35000, model = "granger"},
    {name = "Huntley S", costs = 195000, model = "huntley"},
    {name = "Landstalker", costs = 58000, model = "landstalker"},
    {name = "Radius", costs = 32000, model = "radi"},
    {name = "Rocoto", costs = 85000, model = "rocoto"},
    {name = "Seminole", costs = 30000, model = "seminole"},
    {name = "XLS", costs = 253000, model = "xls"}
}

vans = {
    {name = "Bison", costs = 30000, model = "bison"},
    {name = "Bobcat XL", costs = 23000, model = "bobcatxl"},
    {name = "Gang Burrito", costs = 65000, model = "gburrito"},
    {name = "Journey", costs = 15000, model = "journey"},
    {name = "Minivan", costs = 30000, model = "minivan"},
    {name = "Paradise", costs = 25000, model = "paradise"},
    {name = "Rumpo", costs = 13000, model = "rumpo"},
    {name = "Surfer", costs = 11000, model = "surfer"},
    {name = "Youga", costs = 16000, model = "youga"}
}