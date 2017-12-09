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
		DB.createDatabase('fs_freemode', function()end)
		end)
else
	MySQL.ready(function()
		MySQL.Async.execute("CREATE TABLE IF NOT EXISTS fs_freemode (identifier varchar(255), weapons json DEFAULT NULL)") 
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
			print("Loading data from mysql-server for: " .. identifier)
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
		print("Error: database driver not recognized!")
	end
end

local created = {}
AddEventHandler('es:newPlayerLoaded', function(source, user)
	local src = source
	if(database.driver == "couchdb") then
		TriggerEvent('es:exposeDBFunctions', function(db)
			db.createDocument('fs_freemode', {identifier = user.get("identifier"), weapons = {}}, function()
			end)
		end)
		created[source] = true
	elseif(database.driver == "mysql-async") then
		local identifier = tostring(user.get("identifier"))
		print("Checking if player exists " ..identifier)

		MySQL.Async.fetchScalar("SELECT identifier FROM fs_freemode WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier}, function (userIdentifier)
			if(userIdentifier == nil) then
				print("Adding identifier " .. identifier)
				MySQL.Async.execute("INSERT INTO fs_freemode (`identifier`, `weapons`) VALUES (@identifier, @weapons)", { ['@identifier'] = identifier, ['@weapons'] = json.encode({"WEAPON_PISTOL", "WEAPON_KNIFE"}), })
			end
		end)
		created[source] = true
	else
		print("Error : driver not recognize !")
	end
end)
