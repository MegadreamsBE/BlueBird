-- Variables
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

mapsPath = "maps/"
g_Maps = {}
g_Handlers = {}

g_RoomFiles = {}
g_mapFolders = {
[1] = "hub"
}

-- Events

addEventHandler ( "onResourceStart", g_ResourceRoot,
	function ()
		outputDebugString("Requesting maps...")
	
		local qh = dbQuery(exports.BB_Login:SQL(), "SELECT * FROM maps")
		local maps = dbPoll(qh, -1) -- We are freezing the server on purpose. Nobody wants to play without maps, do you?
	
		outputDebugString("Loading maps...")
		
		for _,map in ipairs(maps) do
			local isFound = false
			for i,v in ipairs(g_mapFolders) do
				if(v == map["category"]) then
					isFound = true
					break
				end
			end
			
			if(isFound == false) then
				table.insert(g_mapFolders,map["category"])
			end
			
			local mapInfo = requestMapInformation(map["category"],map["foldername"])
			
			mapInfo["uploaddate"] = map["uploaddate"]
			mapInfo["playtimes"] = map["playtimes"]
			mapInfo["likes"] = map["likes"]
			mapInfo["dislikes"] = map["dislikes"]
			
			table.insert(g_Maps,{mapID=map["id"], mode=map["category"], map=map["foldername"], name = map["mapname"], author = map["author"],mapInfo = mapInfo})
			outputDebugString("Added map: "..map["mapname"])
		end	
		
		dbFree(qh)
		outputDebugString("Maps loaded")
	end
)

function loadXMLMaps()
	for _,v in ipairs(g_mapFolders) do
		mapX = xmlLoadFile(mapsPath..v.."/maps.xml")
		nodes = xmlNodeGetChildren(mapX)  
		
		for i,node in ipairs(nodes) do
			if (xmlNodeGetName(node) == "map") then
				map = xmlNodeGetValue(node)
					
				local mapInfo = getMapInformation(v,map)
				table.insert(g_Maps,{ mode=v, map=map, name = mapInfo["mapName"] })
				outputDebugString("Added map: "..map)
			end
		end	
		
		xmlUnloadFile(mapX)
	end
end

function getRandomMap(roomID,folders)
	local folderSeed = math.random(1,#folders)
	
	local roomInfo = exports.BB_Rooms:getRoomInformation(roomID)
	local sortList = {}
	for i,v in ipairs(g_Maps) do
		if (v.mode == folders[folderSeed]) then
			if(v.map ~= roomInfo.map) then
				table.insert(sortList,v.map)
			end
		end
	end
	
	local mapSeed = math.random(1,#sortList)
	
	local mapInfo = getMapInformation(folders[folderSeed],sortList[mapSeed])
	return sortList[mapSeed], mapInfo
end

function onMapLoadTimeOut(roomID,folders)
	for _,plr in ipairs(exports.BB_Rooms:getPlayersInRoom(roomID)) do
		outputChatBox("[MAP]: #FF0000Map failed to load. Loading another map.",plr,27,161,226,true)
	end
	
	if(isTimer(getElementData(getElementByID("room_"..tostring(roomID)),"bb.timeout"))) then
		killTimer(getElementData(getElementByID("room_"..tostring(roomID)),"bb.timeout"))
	end
	setElementData(getElementByID("room_"..tostring(roomID)),"bb.timeout",-1)
	
	loadRandomMap(roomID,folders,"None",true)
end

function loadRandomMap(roomID,folders,mapName,loadForPlayers)
	if(mapName == nil or mapName == "None") then
		mapName = -1
	end
	
	if(isTimer(getElementData(getElementByID("room_"..tostring(roomID)),"bb.timeout"))) then
		killTimer(getElementData(getElementByID("room_"..tostring(roomID)),"bb.timeout"))
	end
	setElementData(getElementByID("room_"..tostring(roomID)),"bb.timeout",setTimer(onMapLoadTimeOut,10000,1,roomID,folders))
	
	exports.BB_Rooms:setRoomPrevMap(roomID)
	
	if(#folders == 0) then
		return
	end
	
	local folderSeed = 1
	if(#folders == 1) then
		folderSeed = 1
	else
		folderSeed = math.random(1,#folders)
	end
	
	local mSeed = 0
	local roomInfo = exports.BB_Rooms:getRoomInformation(roomID)
	
	if(roomInfo == nil or roomInfo == false or roomInfo == {}) then
		onMapLoadTimeOut(roomID,folders)
		return
	end
	
	local sortList = {}
	for i,v in ipairs(g_Maps) do
		if ((v.mode == folders[folderSeed]) or (mapName ~= -1)) then
			if(v.map ~= roomInfo.prev or mapName ~= -1) then
				table.insert(sortList,v.map)
			end
			if(mapName ~= -1 and v.map == mapName) then
				mSeed = i
				break
			end
		end
	end
	
	if(#sortList == 0) then
		for i,v in ipairs(g_Maps) do
			if ((v.mode == folders[folderSeed]) or (mapName ~= -1)) then
				if(mapName ~= -1) then
					table.insert(sortList,v.map)
				end
			end
		end
	end
	
	local mapSeed = 0
	if(mapName ~= -1) then
		mapSeed = mSeed
	else
		mapSeed = math.random(1,#sortList)
	end
	
	if(#sortList == 1) then
		mapSeed = 1
	end
	
	outputDebugString("Loading map: "..sortList[mapSeed].." for room: "..roomID)
	
	local mapInfo = getMapInformation(folders[folderSeed],sortList[mapSeed])
	
	if(mapInfo == nil or mapInfo == false or mapInfo == {}) then
		onMapLoadTimeOut(roomID,folders)
		return
	end
	
	local mapFiles = getMapFiles(folders[folderSeed],sortList[mapSeed])
	
	if(getElementData(getElementByID("room_"..tostring(roomID)),"room.mapghostmode") == true) then
		setElementData(getElementByID("room_"..tostring(roomID)),mapInfo["ghostmode"])
	end
	
	unloadMap(roomID)
	exports.BB_Rooms:setRoomMap(roomID,folders[folderSeed],sortList[mapSeed],mapInfo.mapName)
			
	local fTable = {}		
	
	if(mapFiles ~= false and mapFiles ~= nil and mapFiles ~= {}) then
		for _,v in ipairs(mapFiles) do
			local filename = mapsPath..folders[folderSeed].."/"..sortList[mapSeed].."/"..v.name
			local file = fileOpen(filename)
			
			if(file ~= false and file ~= nil) then
				local buffer = ""
				while not fileIsEOF(file) do
					buffer = buffer..fileRead(file, 500)
				end
			
				fileClose(file)
				if(#buffer > 50) then
					table.insert(fTable,{ name = v.name, fileBuffer = buffer })
				end
			end
		end
	end
	
	local contentTable = {}
	for i,v in ipairs(g_Maps) do
		if(v.map == sortList[mapSeed] and v.mode == folders[folderSeed]) then
			local mapInfo = getMapInformation(v.mode,v.map)
			contentTable = readMapFile(folders[folderSeed],v.map,mapInfo["mapURL"])
			g_Maps[i].mapInfo["playtimes"] = g_Maps[i].mapInfo["playtimes"] + 1
			dbQuery(exports.BB_Login:SQL(),"UPDATE maps SET playtimes = ? WHERE id = ?",v.playtimes,v.mapID)
			break
		end
	end			
	
	table.insert(g_RoomFiles,roomID,{ mapContents = contentTable, mapFiles = mapFiles; fileTable = fTable })
	
	killTimer(getElementData(getElementByID("room_"..tostring(roomID)),"bb.timeout"))
	setElementData(getElementByID("room_"..tostring(roomID)),"bb.timeout",-1)
	
	if(loadForPlayers) then
		for _,plr in ipairs(exports.BB_Rooms:getPlayersInRoom(roomID)) do
			loadMapForPlayer(plr,roomID,folders[folderSeed],sortList[mapSeed])
		end
	end
	return sortList[mapSeed]
end

function unloadMap(roomID)
	g_RoomFiles[roomID] = {}
	exports.BB_Rooms:setRoomMap(roomID,-1,-1,"None")
	table.remove(g_RoomFiles,roomID)
	
	for i,v in ipairs(getElementsByType("vehicle")) do
		if(getElementDimension(v) == roomID and ((getElementData(v,"UAG.WonVehicle") or false)) == false) then
			destroyElement(v)
		end
	end
end

function readMapFile(folder,map,mapURL)
	local mapTable = {}
	mapFile = xmlLoadFile(mapsPath..folder.."/"..map.."/"..mapURL)
	
	mapElements = xmlNodeGetChildren(mapFile)

	for i,element in ipairs(mapElements) do
		if (xmlNodeGetName(element) == "object") then
			model = (xmlNodeGetAttribute(element, "model") or 100)
			posX = (xmlNodeGetAttribute(element, "posX") or 0.0)
			posY = (xmlNodeGetAttribute(element, "posY") or 0.0)
			posZ = (xmlNodeGetAttribute(element, "posZ") or 0.0)
			rotX = (xmlNodeGetAttribute(element, "rotX") or 0.0)
			rotY = (xmlNodeGetAttribute(element, "rotY") or 0.0)
			rotZ = (xmlNodeGetAttribute(element, "rotZ") or 0.0)
			interior = (xmlNodeGetAttribute(element, "interior") or 0)
			collisions = (xmlNodeGetAttribute(element, "collisions") or "true")
			doublesided = (xmlNodeGetAttribute(element, "doublesided") or "false")
			scale = (xmlNodeGetAttribute(element, "scale") or 1.0)
			alpha = (xmlNodeGetAttribute(element, "alpha") or 255)
			
			table.insert(mapTable,{ [1] = 0, [2] = model, 
			[3] = posX, [4] = posY, [5] = posZ})
			
			local maxn = table.maxn(mapTable)
			if(rotX ~= 0.0) then mapTable[maxn][6] = rotX end
			if(rotY ~= 0.0) then mapTable[maxn][7] = rotY end
			if(rotZ ~= 0.0) then mapTable[maxn][8] = rotZ end
			if(tonumber(interior) > 0) then mapTable[maxn][9] = interior end
			if(collisions == "false") then mapTable[maxn][10] = collisions end
			if(doublesided == "true") then mapTable[maxn][11] = doublesided end
			if(tonumber(scale) ~= 1) then mapTable[maxn][12] = scale end
			if(tonumber(alpha) < 255) then mapTable[maxn][13] = alpha end
			
		elseif (xmlNodeGetName(element) == "marker") then
			markerType = (xmlNodeGetAttribute(element, "type") or "corona")
			size = (xmlNodeGetAttribute(element, "size") or 1.0)
			r,g,b = hex2rgb((xmlNodeGetAttribute(element, "color") or "#FF0000"))
			posX = (xmlNodeGetAttribute(element, "posX") or 0.0)
			posY = (xmlNodeGetAttribute(element, "posY") or 0.0)
			posZ = (xmlNodeGetAttribute(element, "posZ") or 0.0)
			interior = (xmlNodeGetAttribute(element, "interior") or 0)
			
			table.insert(mapTable,{ [1] = 1, [3] = size, [7] = posX, [8] = posY, [9] = posZ })
			
			local maxn = table.maxn(mapTable)
			if(markerType ~= "arrow") then mapTable[maxn][2] = markerType end
			if(tonumber(r) ~= 0) then mapTable[maxn][4] = r end
			if(tonumber(g) ~= 0) then mapTable[maxn][5] = g end
			if(tonumber(b) ~= 0) then mapTable[maxn][6] = b end
			if(tonumber(interior) ~= 0) then mapTable[maxn][10] = interior end
			
		elseif (xmlNodeGetName(element) == "vehicle") then
			model = (xmlNodeGetAttribute(element, "model") or 0)
			--r,g,b = hex2rgb((xmlNodeGetAttribute(element, "color") or "#FF0000"))
			posX = (xmlNodeGetAttribute(element, "posX") or 0.0)
			posY = (xmlNodeGetAttribute(element, "posY") or 0.0)
			posZ = (xmlNodeGetAttribute(element, "posZ") or 0.0)
			rotX = (xmlNodeGetAttribute(element, "rotX") or 0.0)
			rotY = (xmlNodeGetAttribute(element, "rotY") or 0.0)
			rotZ = (xmlNodeGetAttribute(element, "rotZ") or 0.0)
			colors = (xmlNodeGetAttribute(element, "color") or false)
			plate = (xmlNodeGetAttribute(element, "plate") or "VEHICLE")
			interior = (xmlNodeGetAttribute(element, "interior") or 0)
			
			table.insert(mapTable,{ [1] = 2, [2] = model, 
			[3] = posX, [4] = posY, [5] = posZ,[9] = colors })
			
			local maxn = table.maxn(mapTable)
			if(rotX ~= 0.0) then mapTable[maxn][6] = rotX end
			if(rotY ~= 0.0) then mapTable[maxn][7] = rotY end
			if(rotZ ~= 0.0) then mapTable[maxn][8] = rotZ end
			if(plate ~= "VEHICLE") then mapTable[maxn][10] = plate end
			if(tonumber(interior) ~= 0) then mapTable[maxn][11] = interior end
			
		else
			table.insert(mapTable,{ [1] = -1, [2] = xmlNodeGetName(element), 
			[3] = xmlNodeGetAttributes(element) })
		end
	end
	
	return mapTable
end

function requestMapInformation(folder,map)
	local mapInfo = {
		["mapName"] = nil,
		["mapFolder"] = nil,
		["author"] = nil,
		["mapURL"] = nil,
		["locked_time"] = true,
		["mapTime"] = "00:00",
		["weather"] = 15,
		["ghostmode"] = false,
		["uploaddate"] = "",
		["playtimes"] = 0,
		["likes"] = 0,
		["dislikes"] = 0
	}
	
	local isFound = false
	for _,v in ipairs(g_mapFolders) do
		if(v == folder) then
			isFound = true
			break
		end
	end
	if not isFound then return mapInfo end
	
	meta = xmlLoadFile(mapsPath..folder.."/"..map.."/meta.xml")
	
	if(meta == nil or meta == false) then return mapInfo end
	
	info = xmlFindChild(meta, "info", 0)	
	mapInfo["mapName"] = xmlNodeGetAttribute(info, "name")	
	mapInfo["author"]= xmlNodeGetAttribute(info, "author")	
	mapInfo["mapFolder"] = folder
		
	map = xmlFindChild(meta, "map", 0)	
	mapInfo["mapURL"] = xmlNodeGetAttribute(map, "src")	
		
	settings = xmlFindChild(meta, "settings", 0)
	nodes = xmlNodeGetChildren(settings)  
	
	if(nodes == nil or nodes == false) then return mapInfo end
	for i,setting in ipairs(nodes) do
		if (xmlNodeGetName(setting) == "setting") then
			setName = xmlNodeGetAttribute(setting, "name")
			value = xmlNodeGetAttribute(setting, "value")
			value = string.gsub(value, "%[", "")
			value = string.gsub(value, "%]", "")
			value = string.gsub(value, " ", "")
			value = string.gsub(value, "%&quot;", "")
			
			if(setName == "#locked_time" or setName == "locked_time") then
				if(value == "true") then
					mapInfo["locked_time"] = true
				else
					mapInfo["locked_time"] = true
				end
			end
			
			if(setName == "#time" or setName == "time") then
				mapInfo["mapTime"] = value
			end
			
			if(setName == "#weather" or setName == "weather") then
				mapInfo["weather"] = value
			end
			
			if(setName == "#ghostmode" or setName == "ghostmode") then
				mapInfo["ghostmode"] = value
			end
		end
	end
		
	xmlUnloadFile(meta)
	return mapInfo
end

function getMapInformation(folder,map)
	for _,v in ipairs(g_Maps) do
		if(v.mode == folder and v.map == map) then
			return v.mapInfo
		end
	end
	return false
end

function getMapFiles(folder,map)
	if(map == nil) then return end
	local mapFiles = {}
	
	local isFound = false
	for _,v in ipairs(g_mapFolders) do
		if(v == folder) then
			isFound = true
			break
		end
	end
	if not isFound then return false end
	meta = xmlLoadFile(mapsPath..folder.."/"..map.."/meta.xml")
	if(meta == nil or meta == false) then return false end	
		
	files = xmlNodeGetChildren(meta)  
	
	for i,file in ipairs(files) do
		if (xmlNodeGetName(file) == "file") then
			local filename = xmlNodeGetAttribute(file, "src")
			if (string.lower(string.sub(filename, -4)) ~= ".mp3" and 
				string.lower(string.sub(filename, -4)) ~= ".wav" and 
				string.lower(string.sub(filename, -4)) ~= ".ogg" and 
				string.lower(string.sub(filename, -4)) ~= ".wav" and 
				string.lower(string.sub(filename, -4)) ~= ".riff" and 
				string.lower(string.sub(filename, -4)) ~= ".mod" and 
				string.lower(string.sub(filename, -4)) ~= ".xm" and 
				string.lower(string.sub(filename, -4)) ~= ".it" and 
				string.lower(string.sub(filename, -4)) ~= ".s3m") then
			
				table.insert(mapFiles,{
				name = filename,
				folder = folder,
				map = map
				} )
			end
		end
	end
	for i,file in ipairs(files) do
		if (xmlNodeGetName(file) == "script") then
			local filename = xmlNodeGetAttribute(file, "src")
			local fileType = xmlNodeGetAttribute(file, "type")
			if(string.lower(fileType) == "client") then
				table.insert(mapFiles,{
				name = filename,
				folder = folder,
				map = map
				} )
			end
		end
	end
		
	xmlUnloadFile(meta)
	return mapFiles
end

function loadMapForPlayer(player,roomID,folder,map)
	fadeCamera(player, false) 
		
	setTimer (function(player,map,folder,roomID)
		unloadMapForPlayer(player,roomID)
		local mapInfo = getMapInformation(folder,map)
		
		setTimer (function(player,map,folder,roomID,mapInfo)
			triggerClientEvent(player,"onMapStarting",getRootElement(), map, mapInfo)
			
			local roomInfo = exports.BB_Rooms:getRoomInformation(roomID)
			triggerLatentClientEvent(player,"onClientMapDownloaded", 2097152 ,false,g_ResourceRoot,g_RoomFiles[roomID].mapContents,map,roomInfo.gamemode,g_RoomFiles[roomID].mapFiles) 
			g_Handler = getLatentEventHandles(player)[#getLatentEventHandles(player)]  
				
			triggerClientEvent(player,"onFileStarts",getRootElement(),g_Handler,mapInfo["mapURL"])
		end, 50, 1, player,map,folder,roomID,mapInfo)
	end, 50, 1, player,map,folder,roomID)
end

function getMapByPartOfName(folders,map)
	-- table.insert(g_Maps,{ mode=v, map=map })
	
	local mapTable = {}
	for _,v in ipairs(g_Maps) do
		if(v.name ~= false) then
			if string.find(string.lower(v.name), string.lower(map), 1, true) then
				for _,folder in ipairs(folders) do
					if(folder == v.mode) then
						table.insert(mapTable,{ map = v.map, name = v.name })
					end
				end
			end
		end
	end
	
	return (mapTable or false)
end

addEvent("onFileReportRequest",true)
addEventHandler("onFileReportRequest", getRootElement(),
	function(fileTable)
		local infoTable = {}
		for _,v in ipairs(fileTable) do
			if(v.gainInfo == true) then
				g_Status = getLatentEventStatus(source,v.handler)
				if(g_Status == false) then
					progress = false
				else
					progress = g_Status.percentComplete
				end
				v.progress = progress
			end
		end
		triggerClientEvent(source,"onFileReport",getRootElement(),infoTable)
	end
)

function unloadMapForPlayer(player,roomID)
	setTimer (function(player)
		--for _,v in ipairs(getLatentEventHandles(player)) do
			--cancelLatentEvent(player,v)
		--end
		
		destroyElement(getElementData(player,"UAG.vehicle"))
		
		roomInfo = exports.BB_Rooms:getRoomInformation(roomID)
		triggerClientEvent(player,"onMapStopping",getRootElement(),roomInfo)
	end, 50, 1, player)
end

addEvent("onRequestDownload",true)
addEventHandler("onRequestDownload", g_ResourceRoot,
	function(player,mapFile,map,folder,check)
		if(check == nil) then return end
		
		for _,v in ipairs(g_RoomFiles[getElementData(player,"bb.room")].fileTable) do
			if(v.name == mapFile) then
				triggerLatentClientEvent(player,"onClientDownloaded", 2097152 ,false,g_ResourceRoot,v.fileBuffer,mapFile) -- 0.1MB/s
				g_Handler = getLatentEventHandles(player)[#getLatentEventHandles(player)]  
				triggerClientEvent(player,"onFileStarts",getRootElement(),g_Handler,mapFile)
				break
			end
		end
	end
)

function hex2rgb(hex)
  hex = hex:gsub("#","")
  return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end
