-- Variables
g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

local screenX, screenY = guiGetScreenSize()
mapEnv = {}

g_EventHandlers = {}
g_CommandHandlers = {}
g_Timers = {}
g_Objects = {}
g_Markers = {}
g_Vehicles = {}
g_Sounds = {}
g_BindKeys = {}
g_LoadingFiles = {}
g_ModelElements = {}
g_ModelChanges = {}
g_Textures = {}
g_Shaders = {}

_addEventHandler = addEventHandler
_removeEventHandler = removeEventHandler
_addCommandHandler = addCommandHandler
_setTimer = setTimer
_createMarker = createMarker
_createObject = createObject
_createVehicle = createVehicle
_playSound = playSound
_bindKey = bindKey
_engineLoadTXD = engineLoadTXD
_engineLoadDFF = engineLoadDFF
_engineReplaceModel = engineReplaceModel
_engineImportTXD = engineImportTXD
_engineApplyShaderToWorldTexture = engineApplyShaderToWorldTexture

local g_Time = 0
local cMapName = nil
local cMapFolder = nil
local cMapInfo = {}
local cMap = nil

local filesReady = 0

local fileSend = false
local fileSendExtended = false
local fileProgress = 0
local totalProgress = 0
local fileCount = 0
local fileTimer = -1

local mapFiles = {}
local gMapInfo = {
["currentText"] = nil,
["currentLines"] = 0,
["currentPos"] = 0,
["currentAlpha"] = 0,
["currentMovement"] = 0,
["currentScale"] = 1.5,
["currentTimer"] = nil
}

function addEventHandler(eventName,attachedTo,handlerFunction,...)
	if(handlerFunction == nil or handlerFunction == false) then return end
	table.insert(g_EventHandlers, { eventName=eventName, attachedTo=attachedTo,handlerFunction=handlerFunction })
	return _addEventHandler(eventName,attachedTo,handlerFunction)
end

function removeEventHandler(...)
	return _removeEventHandler(...)
end

function addCommandHandler(command,handler,...)
	if(handler == nil or handler== false) then return end
	table.insert(g_CommandHandlers, { command=command, handler=handler })
	return _addCommandHandler(command,handler,...)
end

function setTimer(func, interval, ticks, ...)
	local timer = _setTimer(func, interval, ticks, ...)
	if not (ticks == 1) then table.insert(g_Timers, timer) end
	return timer
end

function createObject(...)
	local object = _createObject(...)
	setElementDimension(object,getElementData(localPlayer,"bb.room"))
	table.insert(g_Objects, object)
	return object
end

function createMarker(...)
	local marker = _createMarker(...)
	setElementDimension(marker,getElementData(localPlayer,"bb.room"))
	table.insert(g_Markers, marker)
	return marker
end

function createVehicle(...)
	local vehicle = _createVehicle(...)
	setElementDimension(vehicle,getElementData(localPlayer,"bb.room"))
	table.insert(g_Vehicles, vehicle)
	return vehicle
end

function playSound(path,...)
	filename = split(path,"/")
	url = "http://ultimateairgamers.com/uag/maps/songs/"..cMap.."/"..filename[#filename]
	sound = _playSound(url,...)
	table.insert(g_Sounds, sound)
	return sound
end

function bindKey(key,state,func,...)
	table.insert(g_BindKeys, {key = key, state = state, func = func})
	return _bindKey(key,state,func)
end

function engineReplaceModel(path,modelID)
	if(modelID >= 400 and modelID <= 600) then
		return false
	end
	
	table.insert(g_ModelChanges,modelID)
	return _engineReplaceModel(path,modelID)
end

function engineLoadTXD(path,filtering)
	local TXD = _engineLoadTXD(path,false)
	table.insert(g_ModelElements,TXD)
	return TXD
end

function engineLoadDFF(path,modelID)
	if(modelID >= 500 and modelID <= 600) then
		return false
	end
	
	local DFF = _engineLoadDFF(path,modelID)
	table.insert(g_ModelElements,DFF)
	return DFF
end

function engineImportTXD(path,modelID)
	if(modelID >= 500 and modelID <= 600) then
		return false
	end
	
	table.insert(g_Textures,{ texture = path, model = modelID })
	table.insert(g_ModelChanges,modelID)
	return _engineImportTXD(path,modelID)
end

function engineApplyShaderToWorldTexture(shader,texture,...)
	table.insert(g_Shaders,{ shader = shader, texture = texture })
	return _engineApplyShaderToWorldTexture(shader,texture,...)
end

function mapStopping(roomInfo)
	_removeEventHandler("onClientRender",getRootElement(),downloadIndicator)

	if(cMap == nil) then return end
	cMap = nil
	cMapName = nil
	cMapFolder = nil

	exports[roomInfo.gamemode]:onClientMapStop()
	triggerEvent("onClientMapStopping",g_ResourceRoot)
	triggerEvent("onClientResourceStop", g_ResourceRoot)
	
	for _,v in ipairs(g_BindKeys) do
		unbindKey(v.key,v.state,v.func)
	end
	for _,v in ipairs(g_EventHandlers) do
		_removeEventHandler(v.eventName,v.attachedTo,v.handlerFunction)
	end
	for _,v in ipairs(g_CommandHandlers) do
		removeCommandHandler(v.command,v.handler)
	end
	for _,v in ipairs(g_Timers) do
		if(isTimer(v)) then
			killTimer(v)
		end
	end
	for _,v in ipairs(g_Objects) do
		if(isElement(v)) then
			destroyElement(v)
		end
	end
	for _,v in ipairs(g_Markers) do
		if(isElement(v)) then
			destroyElement(v)
		end
	end
	for _,v in ipairs(g_Vehicles) do
		if(isElement(v)) then
			destroyElement(v)
		end
	end
	for _,v in ipairs(g_Sounds) do
		stopSound(v)
	end
	
	for _,v in ipairs(g_Textures) do
		if(isElement(v)) then
			destroyElement(v.texture)
		end
	end
	
	for _,v in ipairs(g_ModelChanges) do
		engineRestoreModel(v)
	end
	
	for _,v in ipairs(g_ModelElements) do
		if(isElement(v)) then
			destroyElement(v)
		end
	end
	
	for _,v in ipairs(g_ModelChanges) do
		engineRestoreModel(v)
	end
	
	for _,v in ipairs(g_Shaders) do
		engineRemoveShaderFromWorldTexture(v.shader,v.texture)
	end
	
	for _,v in ipairs(getElementsByType("object")) do
		if(isElement(v)) then
			destroyElement(v)
		end
	end
	
	for _,v in ipairs(getElementsByType("vehicle")) do
		if(isElement(v)) then
			destroyElement(v)
		end
	end
	
	for _,v in ipairs(getElementsByType("pickup")) do
		if(isElement(v)) then
			destroyElement(v)
		end
	end
	
	for _,v in ipairs(getElementsByType("marker")) do
		if(isElement(v)) then
			destroyElement(v)
		end
	end
	
	for _,v in ipairs(getElementsByType("sound")) do
		stopSound(v)
	end
	
	if(isTimer(gMapInfo["currentTimer"])) then
		killTimer(gMapInfo["currentTimer"])
	end
	_removeEventHandler("onClientRender",getRootElement(),mapInformation)
	
	g_EventHandlers = {}
	g_Timers = {}
	g_Objects = {}
	g_Markers = {}
	g_Vehicles = {}
	g_Sounds = {}
	g_BindKeys = {}
	g_Shaders = {}
	
	resetWaterColor()
	resetWaterLevel()
	resetHeatHaze()
	resetSkyGradient()
	resetWindVelocity()
	resetAmbientSounds()
	resetWorldSounds()
	resetRainLevel()
	resetSunSize()
	resetSunColor()
	resetFogDistance()
	setGameSpeed(1)
	setGravity(0.008)
	
	_removeEventHandler('onClientRender', getRootElement(),freezeTime)
	filesReady = 0
	
	mapEnv = {}
end
addEvent("onMapStopping",true)
_addEventHandler("onMapStopping",getRootElement(),mapStopping)

function mapStarting(map,mapInfo)	
	cMap = map
	check = nil -- Shooter fix
	cMapName = mapInfo["mapName"]
	cMapFolder = mapInfo["mapFolder"]
	cMapInfo = mapInfo
	setWeather(mapInfo["weather"])

	g_Time = split(mapInfo["mapTime"],":")
	setTime(g_Time[1],g_Time[2])
	
	resetWaterColor()
	resetWaterLevel()
	resetHeatHaze()
	resetSkyGradient()
	resetWindVelocity()
	resetAmbientSounds()
	resetWorldSounds()
	resetRainLevel()
	resetSunSize()
	resetSunColor()
	resetFogDistance()
	setGameSpeed(1)
	setGravity(0.008)
	setElementData(localPlayer,"state","loading")
	
	for _,v in ipairs(g_Textures) do
		destroyElement(v.texture)
	end
	
	for _,v in ipairs(g_ModelChanges) do
		engineRestoreModel(v)
	end
	
	for _,v in ipairs(g_ModelElements) do
		destroyElement(v)
	end
	
	for _,v in ipairs(g_ModelChanges) do
		engineRestoreModel(v)
	end
	g_ModelElements = {}
	g_ModelChanges = {}
	g_Textures = {}
	
	g_LoadingFiles = {}
	
	fileSend = false
	fileSendExtended = false
	fileCount = 0
	if (fileTimer ~= -1) then 
		killTimer(fileTimer) 
		fileTimer = -1
	end
	
	_removeEventHandler("onClientRender",getRootElement(),downloadIndicator)
	_addEventHandler("onClientRender",getRootElement(),downloadIndicator)
	
	_removeEventHandler("onClientRender",getRootElement(),mapInformation)
	if(isTimer(gMapInfo["currentTimer"])) then
		killTimer(gMapInfo["currentTimer"])
	end
	
	if(mapInfo["locked_time"]) then
		setMinuteDuration((60000*10000))
	else
		setMinuteDuration(1000)
	end
	
	for _,v in ipairs(g_LoadingFiles) do
		v.gainInfo = false
	end
end
addEvent("onMapStarting",true)
_addEventHandler("onMapStarting",getRootElement(),mapStarting)

addEvent("onFileStarts", true)
_addEventHandler("onFileStarts", g_ResourceRoot,
	function(handler,filename)			
		if (fileTimer == -1) then 
			fileTimer = _setTimer(requestFileReport, 50, 0)
		end
		
		table.insert(g_LoadingFiles,{handler = handler, filename = filename, filetype = fileType, progress = 0, gainInfo = true})
		fileCount = fileCount + 1
	end
)

function requestFileReport()	
	triggerServerEvent("onFileReportRequest",localPlayer,g_LoadingFiles)
end

addEvent("onFileReport", true)
_addEventHandler("onFileReport", g_ResourceRoot,
	function(infoTable)	
		g_LoadingFiles = infoTable
		for _,v in ipairs(g_LoadingFiles) do
			if( v.gainInfo == true) then
				if(v.handler == handler) then
					if(v.progress ~= false) then
						v.progress = 100
					else
						v.progress = progress
					end
				end
			end
		end
		
		totalProgress = 0
		if(#g_LoadingFiles < fileCount) then
			totalProgress = totalProgress + (100*(fileCount-#g_LoadingFiles))
		end
		for i,v in ipairs(g_LoadingFiles) do
			if(v.gainInfo == true) then
				if(v.progress >= 100) then
					table.remove(g_LoadingFiles,i)
					if v.filetype == "map" then 
						fileCount = fileCount - 1
					end
				else
					v.progress = v.progress + 3
				end
			end
	
			totalProgress = totalProgress + v.progress
		end
	
		if fileSendExtended and (progress == 100) then
			_setTimer (function()
				if (fileTimer ~= -1) then 
					killTimer(fileTimer) 
					fileTimer = -1
				end
				_removeEventHandler("onClientRender",getRootElement(),downloadIndicator)
			end, 50, 1)
		end
	end
)

function downloadIndicator()
	dxDrawImage(((screenX/2)-(conv(150)/2)), screenY-conv(230), conv(150), conv(150), 'images/loading.png', 0)
	
	local progress = 0
	if (fileCount > 0) then
		fileSend = true
		progress = math.round((totalProgress/(100*fileCount))*100,0,"round")
		if(progress > 100) then
			progress = 100
		end
	elseif(fileSend == true) then
		progress = 100
	end
	fileProgress = totalProgress
	
	local length = dxGetTextWidth(progress.."%",conv(2),"default-bold")
	local height = dxGetFontHeight(conv(2),"default-bold")
	
	for i = 0, (progress*3.6) do
		dxDrawImage(((screenX/2)-(conv(150)/2)), screenY-conv(230), conv(150), conv(150), "images/loadingborder.png", i, 0, 0, tocolor(27,161,226,255), true)
	end
	dxDrawText(progress.."%", ((screenX/2)-(length/2)), ((screenY-conv((230))+conv(75))-(height/2)), (((screenX/2)-(length/2))+50), screenY-conv(150), tocolor(128,128,128,255), conv(2), "default-bold" )
end

function setMapInformation()
	if(gMapInfo["currentPos"] == 0) then
		gMapInfo["currentText"] = cMapName.."\nAuthor(s): "..cMapInfo["author"]
		gMapInfo["currentLines"] = 2
		
		gMapInfo["currentTimer"] = setTimer(setMapInformation,2000,0)
		
		gMapInfo["currentMovement"] = 1
		gMapInfo["currentScale"] = 1.5
	end
	
	if(gMapInfo["currentPos"] == 2) then
		gMapInfo["currentText"] = "Played "..cMapInfo["playtimes"].." times"
		gMapInfo["currentLines"] = 1
	end
	
	if(gMapInfo["currentPos"] == 4) then
		gMapInfo["currentText"] = "Uploaded: "..cMapInfo["uploaddate"]
		gMapInfo["currentLines"] = 1
	end
	
	if(gMapInfo["currentPos"] == 6) then
		gMapInfo["currentText"] = "Likes: #00FF00"..cMapInfo["likes"].."\n#FFFFFFDislikes: #FF0000"..cMapInfo["dislikes"]
		gMapInfo["currentLines"] = 2
	end
	
	if(gMapInfo["currentPos"] >= 8) then
	
		_removeEventHandler("onClientRender",getRootElement(),mapInformation)
		killTimer(gMapInfo["currentTimer"])
		return
	end
	
	if(gMapInfo["currentMovement"] == 0) then
		gMapInfo["currentAlpha"] = 255
		gMapInfo["currentMovement"] = 1
	else
		gMapInfo["currentAlpha"] = 0
		gMapInfo["currentMovement"] = 0
	end
	
	gMapInfo["currentPos"] = gMapInfo["currentPos"] + 1
end

function mapInformation()
	local width = dxGetTextWidth(removeColorCoding(gMapInfo["currentText"]),conv(gMapInfo["currentScale"]),"default-bold")
	local height = (dxGetFontHeight(conv(gMapInfo["currentScale"]),"default-bold")*gMapInfo["currentLines"])
	dxDrawImage(((screenX/2)-(width/2))-conv(33), (screenY-conv(75)), conv(33), conv(75), 'images/bar-lside.png', 0, 0, 0, tocolor(0,0,0,(gMapInfo["currentAlpha"]/2.55)))
	dxDrawImage(((screenX/2)-(width/2)),(screenY-conv(75)), width, conv(75), 'images/bar-mside.png', 0, 0, 0, tocolor(0,0,0,(gMapInfo["currentAlpha"]/2.55)))
	dxDrawImage(((screenX/2)+(width/2)), (screenY-conv(75)), conv(33), conv(75), 'images/bar-rside.png', 0, 0, 0, tocolor(0,0,0,(gMapInfo["currentAlpha"]/2.55)))
	dxDrawText(gMapInfo["currentText"], ((screenX/2)-(width/2)), ((screenY-conv(75))+((conv(75)/2)-(height/2))), ((screenX/2)-(width/2)), conv(38), tocolor(255,255,255,gMapInfo["currentAlpha"]), conv(gMapInfo["currentScale"]), "default-bold","left","top",false,false,false,true)

	if(gMapInfo["currentMovement"] == 0) then
		if(gMapInfo["currentAlpha"] < 255) then
			gMapInfo["currentAlpha"] = gMapInfo["currentAlpha"] + 4
		end
		
		if(gMapInfo["currentAlpha"] > 255) then
			gMapInfo["currentAlpha"] = 255
		end
	end
	
	if(gMapInfo["currentMovement"] == 1) then
		if(gMapInfo["currentAlpha"] > 0) then
			gMapInfo["currentAlpha"] = gMapInfo["currentAlpha"] - 4
		end
		
		if(gMapInfo["currentAlpha"] < 0) then
			gMapInfo["currentAlpha"] = 0
		end
	end
end

addEvent("onClientMapDownloaded", true)
_addEventHandler("onClientMapDownloaded", g_ResourceRoot,
	function(mapTable, map, gamemode, files)
		mapFiles = files
		loadClientMap(mapTable,map,gamemode)
		
		if(getElementData(localPlayer,"bb.room") ~= 1) then
			gMapInfo["currentPos"] = 0
			setMapInformation()
			_addEventHandler("onClientRender",getRootElement(),mapInformation)
		end
	end
)

function loadClientMap(mapTable,map,gamemode)
	if not (cMap == map) then return end

	roomID = getElementData(localPlayer,"bb.room")
	for i,element in ipairs(mapTable) do	
		if not (cMap == map) then return end
		if (element[1] == 0) then -- object
			model = element[2]
			posX = element[3]
			posY = element[4]
			posZ = element[5]
			rotX = (element[6] or 0.0)
			rotY = (element[7] or 0.0)
			rotZ = (element[8] or 0.0)
			interior = (element[9] or 0)
			collisions = (element[10] or true)
			doublesided = (element[11] or false)
			scale = (element[12] or 1.0)
			alpha = (element[13] or 255)
			
			local object = _createObject(model,posX,posY,posZ,rotX,rotY,rotZ)
			setElementInterior(object,interior)
			
			if(collisions == "false" or collisions == false) then
				setElementCollisionsEnabled(object,false)
			else
				setElementCollisionsEnabled(object,true)
			end
			if(doublesided == "true" or doublesided == true) then
				setElementDoubleSided(object,true)
			else
				setElementDoubleSided(object,false)
			end
			
			setObjectScale(object,scale)
			setElementAlpha(object,alpha)
			
			setElementDimension(object,roomID)
			table.insert(g_Objects, object)
		elseif (element[1] == 1) then -- marker
			markerType = (element[2] or "arrow")
			size = element[3]
			r,g,b = (element[4] or 0),(element[5] or 0),(element[6] or 0)
			posX = element[7]
			posY = element[8]
			posZ = element[9]
			interior = (element[10] or 0)
			
			local marker = _createMarker(posX, posY, posZ, markerType, size, r, g, b, 255)
			setElementDimension(marker,roomID)
			table.insert(g_Markers, marker)
		elseif (element[1] == 2) then -- vehicle
			model = element[2]
			posX = element[3]
			posY = element[4]
			posZ = element[5]
			rotX = (element[6] or 0.0)
			rotY = (element[7] or 0.0)
			rotZ = (element[8] or 0.0)
			colors = (element[9] or false)
			plate = (element[10] or "VEHICLE")
			interior = (element[11] or 0)
			
			local cSplit = {}
			if(colors ~= false) then
				cSplit = split(colors,",")
			end
			
			local vehicle = _createVehicle(model, posX, posY, posZ, rotX, rotY, rotZ, plate)
			setElementDimension(vehicle,roomID)
			setElementInterior(vehicle,interior)
			
			if(cSplit ~= false and cSplit ~= nil) then
				setVehicleColor(vehicle,
				tonumber(cSplit[1] or 0),tonumber(cSplit[2] or 0),tonumber(cSplit[3] or 0),
				tonumber(cSplit[4] or 0),tonumber(cSplit[5] or 0),tonumber(cSplit[6] or 0),
				tonumber(cSplit[7] or 0),tonumber(cSplit[8] or 0),tonumber(cSplit[9] or 0),
				tonumber(cSplit[10] or 0),tonumber(cSplit[11] or 0),tonumber(cSplit[12] or 0))
			end
			setElementFrozen(vehicle,true)
			table.insert(g_Vehicles, vehicle)
		else
			exports[gamemode]:sendMapElement(element[2],element[3])
		end
	end
	
	for i,v in ipairs(g_LoadingFiles) do
		v.gainInfo = false
		fileCount = fileCount - 1
		table.remove(g_LoadingFiles,i)
	end
	
	setFarClipDistance(3000)
	engineSetAsynchronousLoading(true,true)
	exports.BB_GUI:stopRender()
	
	setTimer (function()
		exports[gamemode]:onMapLoaded()
		setTimer (function()
			downloadFiles()
		end, 500, 1)
	end, 50, 1)
end

function closeLoader()
	fileSend = false
	fileSendExtended = false
	fileCount = 0
	
	_removeEventHandler("onClientRender",getRootElement(),downloadIndicator)
	if (fileTimer ~= -1) then 
		killTimer(fileTimer) 
		fileTimer = -1
	end
	
	for _,v in ipairs(g_LoadingFiles) do
		v.gainInfo = false
	end
	
	g_LoadingFiles = {}
	
	if(filesReady ~= true) then
		outputChatBox("[LOADER]: #91FFFFYou are still downloading files. You'll notice when they are loaded.",27,161,226,true)
		outputChatBox("[LOADER]: #91FFFFWe shut down the download indicator to prevent lag.",27,161,226,true)
	end
end

function downloadFiles()
	if(mapFiles == nil) then return end
	if(cMap == nil) then return end
	if (#mapFiles == 0) then
		sendNotification()
	end
	
	mapEnv = {}
	
	for _,file in pairs(mapFiles) do
		triggerServerEvent("onRequestDownload", g_ResourceRoot, localPlayer, file.name, file.map, file.folder, cMap)
	end
end

addEvent("onClientDownloaded", true)
_addEventHandler("onClientDownloaded", g_ResourceRoot,
	function(buffer, filename)
		if string.sub(filename, -4) == ".lua" then
			local lcall = assert(loadstring(buffer))
			setmetatable(mapEnv, {__index = _G})
			setfenv(lcall,mapEnv)
			pcall(lcall)
		else
			if not fileExists(filename) then
				file = fileCreate(filename)
			else
				fileDelete(filename)
				file = fileCreate(filename)
			end
			fileWrite(file, buffer)
			fileClose(file)
		end
		
		for i,v in ipairs(g_LoadingFiles) do
			v.gainInfo = false
			table.remove(g_LoadingFiles,i)
		end

		sendNotification()
	end
)

function sendNotification()
	filesReady = filesReady+1
	if (filesReady == #mapFiles) or (#mapFiles == 0) then
		triggerEvent("onClientFilesAreAllDownloaded", g_ResourceRoot)
		triggerEvent("onClientResourceStart", g_ResourceRoot)
		triggerEvent("onClientMapStarting",g_ResourceRoot)
		triggerEvent("onClientPlayerSpawn",g_ResourceRoot)
		for _,v in ipairs(g_LoadingFiles) do
			v.gainInfo = false
		end
		g_LoadingFiles = {}
		if (fileProgress < 100) and (#mapFiles > 0) then
			fileSendExtended = true
		else
			_setTimer (function()
				_removeEventHandler("onClientRender",getRootElement(),downloadIndicator)
				if (fileTimer ~= -1) then 
					killTimer(fileTimer) 
					fileTimer = -1
				end
			end, 50, 1)
		end
		filesReady = true
	end
end

function hex2rgb(hex)
  hex = hex:gsub("#","")
  return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

function string:split(separator)
	if separator == '.' then
		separator = '%.'
	end
	local result = {}
	for part in self:gmatch('(.-)' .. separator) do
		result[#result+1] = part
	end
	result[#result+1] = self:match('.*' .. separator .. '(.*)$') or self
	return result
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function conv(size)
	local newSize = size*(screenX/1366)
	
	if(screenX >= 1600) then
		return (newSize*0.8)
	elseif(screenX <= 1000) then
		return (newSize*1.4)
	else
		return (newSize*1)
	end
end

function setCloudEnabled(bool)
	setCloudsEnabled(false)
end

function removeColorCoding(name)
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end

fileDelete("c_maps.lua")