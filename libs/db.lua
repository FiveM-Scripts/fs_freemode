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


function db.getUser(identifier, callback)
	local qu = {selector = {["identifier"] = identifier}}
	PerformHttpRequest("http://" .. database['host'] .. ":" .. database['port']  .. "/fs_freemode/_find", function(err, rText, headers)
		local t = json.decode(rText)
		if(t.docs[1])then
			callback(t.docs[1])
		else
			callback(false)
		end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function db.updateUser(identifier, update, callback)
	db.getUser(identifier, function(user)
		for i in pairs(update)do
			user[i] = update[i]
		end

		PerformHttpRequest("http://" .. database['host'] .. ":" .. database['port'] .. "/fs_freemode/" .. user._id, function(err, rText, headers)
			callback((err or true))
		end, "PUT", json.encode(user), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
	end)
end

TriggerEvent('es:exposeDBFunctions', function(DB)
	db.createDocument = DB.createDocument
	DB.createDatabase('fs_freemode', function()end)
end)

local created = {}
AddEventHandler('es:newPlayerLoaded', function(source, user)
	TriggerEvent('es:exposeDBFunctions', function(db)
		db.createDocument('fs_freemode', {identifier = user.get("identifier"), weapons = {}}, function()
			end)
		end)
	created[source] = true
end)
