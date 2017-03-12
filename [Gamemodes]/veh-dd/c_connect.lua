-- Variables
g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

files = {"c_utils.lua","c_race.lua"}
		
local filesReady = 0

g_EventHandlers = {}
g_CommandHandlers = {}
g_Timers = {}
g_Objects = {}
g_Markers = {}
g_Vehicles = {}
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
_bindKey = bindKey
_engineLoadTXD = engineLoadTXD
_engineLoadDFF = engineLoadDFF
_engineReplaceModel = engineReplaceModel
_engineImportTXD = engineImportTXD
_engineApplyShaderToWorldTexture = engineApplyShaderToWorldTexture

-- Functions | Events

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

function loadGamemode()
	filesReady = 0
	downloadFiles()
	setElementData(localPlayer,"state","loading")
end

function unloadGamemode()
	triggerEvent("onScriptUnload", g_ResourceRoot)
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
		killTimer(v)
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
	
	for _,v in ipairs(g_Shaders) do
		engineRemoveShaderFromWorldTexture(v.shader,v.texture)
	end
	
	for _,v in ipairs(getElementsByType("object")) do
		destroyElement(v)
	end
	
	for _,v in ipairs(getElementsByType("vehicle")) do
		destroyElement(v)
	end
	
	for _,v in ipairs(getElementsByType("pickup")) do
		destroyElement(v)
	end
	
	for _,v in ipairs(getElementsByType("marker")) do
		destroyElement(v)
	end
	
	for _,v in ipairs(getElementsByType("sound")) do
		stopSound(v)
	end
	g_EventHandlers = {}
	g_Timers = {}
	g_Objects = {}
	g_Markers = {}
	g_Vehicles = {}
	g_BindKeys = {}
	g_Shaders = {}
	g_ModelElements = {}
	g_ModelChanges = {}
	g_Textures = {}
	filesReady = 0
end

function onClientMapStop()
	triggerEvent("onMapStopping", g_ResourceRoot)
end

function downloadFiles()
	for _,file in pairs(files) do
		triggerServerEvent("onRequestDownload", g_ResourceRoot, localPlayer, file)
	end
end

addEvent("onClientDownloaded", true)
_addEventHandler("onClientDownloaded", g_ResourceRoot,
	function(buffer, filename)
		if(buffer == false) then
			sendNotification()
			return
		end
		if string.sub(filename, -4) == ".lua" then
			local lcall,err = loadstring(buffer)
			if(lcall == nil) then
				outputDebugString(err,1)
			else
				lcall()
			end
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
		sendNotification()
	end
)

function sendNotification()
	filesReady = filesReady+1
	if filesReady == #files then
		triggerEvent("onClientFilesAreAllDownloaded", g_ResourceRoot)
		filesReady = true
	end
end

function sendMapElement(name,element)
	triggerEvent("onMapElement",localPlayer,name,element)
end

function onMapLoaded()
	triggerEvent("onMapIsLoaded",g_ResourceRoot)
end

-- Event handlings

addEvent("onClientFilesAreAllDownloaded",false)