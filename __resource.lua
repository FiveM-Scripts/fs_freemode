resource_type 'gametype' { name = 'fs_freemode'}

resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

dependency 'essentialmode'

files {
  'weapons.xml'
}

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
  'config.lua',
  'client.lua',
  'int/comedy.lua',
  'int/office.lua',
  'int/weapons.lua',
  'int/warehouses.lua',
  'ext/locations.lua',
  'ext/pickups.lua',
  'ext/trains.lua'
}

server_script '@mysql-async/lib/MySQL.lua'
server_scripts {
  'config.lua',
  'database.lua',
  'libs/db.lua',
  'server.lua',
  'int/weapons_s.lua'
}
