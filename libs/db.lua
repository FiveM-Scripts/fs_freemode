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

-- character table string
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
-- base64 encoding http://lua-users.org/wiki/BaseSixtyFour
function toBase64Enc(data)
	return ((data:gsub('.', function(x)
		local r,b='',x:byte()
		for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
		return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
    if (#x < 6) then return '' end
    local c=0
    for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end 
      return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

db = {}
pbytes =''

 for p, c in utf8.codes(database['username']) do
	  pbytes = pbytes .. utf8.char(c)
 end

local auth = toBase64Enc(pbytes)

if(database.driver == "couchdb") then
	TriggerEvent('es:exposeDBFunctions', function(DB)
		db.createDocument = DB.createDocument
		DB.createDatabase('fs_freemode', function() end)
		DB.createDatabase('es_vehshop', function() end)
		end)
else
	MySQL.ready(function()
		MySQL.Async.execute("CREATE TABLE IF NOT EXISTS fs_freemode (identifier varchar(255), vehicles text, weapons text)") 
		end)
end

function db.getUser(identifier, callback)
	if(database.driver == "couchdb") then
		local qu = {selector = {["identifier"] = identifier}}
		PerformHttpRequest("http://" .. database['host'] .. ":" .. database['port']  .. "/fs_freemode/_find", function(err, rText, headers)
			local t = json.decode(rText)
			if(t.docs[1])then
				callback(t.docs[1])
			else
				callback(false)
			end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})

		elseif(database.driver == "mysql-async") then
			MySQL.Async.fetchAll("SELECT * FROM fs_freemode WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier}, function (result)
				if (result) then
					local user = {
					  identifier = result[1].identifier,
					  weapons = json.decode(result[1].weapons)
					}
					callback(user)				
				else
					callback(false)
				end
		end)
	else
		print("Error: database driver is not recognized!")
	end
end

local created = {}
AddEventHandler('es:newPlayerLoaded', function(source, user)
	local src = source
	if(database.driver == "couchdb") then
		TriggerEvent('es:exposeDBFunctions', function(db)
			db.createDocument('fs_freemode', {identifier = user.get("identifier"), weapons = {"WEAPON_PISTOL", "WEAPON_KNIFE"}}, function() end)
			db.createDocument('es_vehshop', {identifier = user.get("identifier"), personalvehicles = {}}, function() end)			
		end)
		created[source] = true
	elseif(database.driver == "mysql-async") then
		local identifier = tostring(user.get("identifier"))
		MySQL.Async.fetchScalar("SELECT identifier FROM fs_freemode WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier}, function (userIdentifier)
			if(userIdentifier == nil) then
				MySQL.Async.execute("INSERT INTO fs_freemode (`identifier`, `vehicles`, `weapons`) VALUES (@identifier, @vehicles, @weapons)", { ['@identifier'] = identifier, ['@vehicles'] = json.encode({}), ['@weapons'] = json.encode({"WEAPON_PISTOL", "WEAPON_KNIFE"})})
			end
		end)
		created[source] = true
	else
		print("Error : database driver is not recognized!")
	end
end)
