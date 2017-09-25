resource_type 'gametype' { name = 'fs_freemode'}

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency 'essentialmode'

files {
  'weapons.xml'
}

weaponfile 'weapons.xml'

client_scripts {
  'bin/System.Xml.net.dll',
  'bin/NativeUI.net.dll',
  'bin/ShopMenu.net.dll',
  'libs/events.lua',
  'libs/scoreboard.lua',
  'config.lua',
  'client.lua',
  'int/comedy.lua',
  'int/weapons.lua',
  'int/warehouses',
  'ext/locations.lua',
  'ext/pickups.lua',
  'ext/trains.lua'
}

server_scripts {
  'config.lua',
  'database.lua',
  'libs/db.lua',
  'server.lua',
  'int/weapons_s.lua'
}
