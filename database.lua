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

-- Don't change this, read the documentation instead https://freemode.readme.io/docs/getting-started.
database = {
    driver = GetConvar('database_driver', 'couchdb'),
    host = GetConvar('es_couchdb_url', '127.0.0.1'),
    port = GetConvar('es_couchdb_port', '5984'),
    username = GetConvar('es_couchdb_password', 'admin:changeme')
}
