----------------------------------<
-- Bluebird GUI
-- c_util.lua
----------------------------------<
-- Util functions
---------------------------------<

-- Rotations

function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end
	return t
end

-- fromcolor

function fromcolor(col)
	local colorHex = string.format("%08X", col)
	local colorRGB = string.sub(colorHex,3,8)
	local colorAlpha = string.sub(colorHex,1,2)
	local colorHex = "#"..colorRGB..colorAlpha
	return getColorFromString(colorHex)
end

-- String functions

function string.purge(text)
	local t = {}
	for num = 1 , string.len(text) do
		table.insert(t, num, string.sub(text, 1,num))
	end
	return t -- "Hai" => {[1] = "H", [2] = "Ha", [3] = "Hai"}
end

-- Table functions

function table.find(tableToSearch, index, value)
	if not value then
		value = index
		index = false
	elseif value == '[nil]' then
		value = nil
	end
	for k,v in pairs(tableToSearch) do
		if index then
			if v[index] == value then
				return k
			end
		elseif v == value then
			return k
		end
	end
	return false
end

function table.copy(tab)
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") then ret[key] = table.copy(value)
        else ret[key] = value end
    end
    return ret
end

function table.reverse ( tab )
    local size = #tab+1
    local newTable = {}
 
    for i,v in ipairs ( tab ) do
        newTable[size-i] = v
    end
 
    return newTable
end

function table.compare(tabA,tabB) 
	for k, v in pairs(tabA) do 
		if type(tabB[k]) == "table" then 
			if not table.compare(tabA[k],tabB[k]) then 
				return false
			end
		elseif tabB[k] ~= v then
			return false
		end
	end

	for k, v in pairs(tabB) do
		if type(tabA[k]) == "table" then
			if not table.compare(tabA[k],tabB[k]) then
				return false
			end
		elseif tabA[k] ~= v then
			return false
		end
	end

	return true
end

function table.removevalue(t, val)
	for i,v in ipairs(t) do
		if v == val then
			table.remove(t, i)
			return i
		end
	end
	return false
end

fileDelete("c_util.lua")