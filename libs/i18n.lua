Translator = setmetatable({}, Translator)
Translator.__index = Translator

local store = {}
local lang = {}
avalLangs = {}

function Translator.setup(l)
	
	if(l ~= nil)then
		lang = l
	end
	
end

function Translator.exportData()
	local result = store
	return result
end

function Translator.importData(l,s)
	table.insert( avalLangs, l)
	store[l] = s
end

function Translator.setLang(l)
	lang = l
end

function Translator.translate(key)
	local result = ""
	if(store == nil) then
		result = "Error 502 : no translation available!"
	else
		result = store[lang][key]
		if(result == nil) then
			result = "Error 404 : key not found!"
		end
	end
	
	return result
end
