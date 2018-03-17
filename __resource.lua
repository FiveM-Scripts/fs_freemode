resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
resource_repository 'https://github.com/FiveM-Scripts/fs_freemode'
resource_type 'gametype' { name = 'fs_freemode'}
resource_version 'v1.3.4'

dependency 'essentialmode'

files { 'weapons.xml' }

weaponfile 'weapons.xml'

client_scripts {
  'libs/i18n.lua',
  'bin/System.Xml.net.dll',
  'bin/NativeUI.net.dll',
  'bin/ShopMenu.net.dll',
  'lang/en.lua',
  'libs/events.lua',
  'libs/scoreboard.lua',
  'libs/warmenu.lua',
  'config/vehicles.lua',
  'config/spawn.lua',
  'config.lua',
  'client.lua',
  'int/cinema.lua',
  'int/comedy.lua',
  'int/office.lua',
  'int/smoke.lua',
  'int/vehicles.lua',
  'int/weapons.lua',
  'int/warehouses.lua',
  'ext/locations.lua',
  'ext/pickups.lua',
 -- 'ext/trains.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'database.lua',
  'libs/db.lua',
  'server.lua',
}