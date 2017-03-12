-- Variables
g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

files = {"c_utils.lua","c_basedef.lua"}
		
local filesReady = 0

g_EventHandlers = {}
g_CommandHandlers = {}
g_Timers = {}
g_BindKeys = {}

_addEventHandler = addEventHandler
_removeEventHandler = removeEventHandler
_addCommandHandler = addCommandHandler
_setTimer = setTimer
_bindKey = bindKey

modeName = "base defense"

-- Functions | Events

function addEventHandler(eventName,attachedTo,handlerFunction)
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

function bindKey(key,state,func)
	table.insert(g_BindKeys, {key = key, state = state, func = func})
	return _bindKey(key,state,func)
end

function getModeName()
	return modeName
end

function loadGamemode()
	filesReady = 0
	downloadFiles()
	setElementData(localPlayer,"state","loading")
end

function unloadGamemode()
	triggerEvent("onScriptUnload", g_ResourceRoot)
	for _,v in ipairs(g_EventHandlers) do
		_removeEventHandler(v.eventName,v.attachedTo,v.handlerFunction)
	end
	for _,v in ipairs(g_CommandHandlers) do
		removeCommandHandler(v.command,v.handler)
	end
	for _,v in ipairs(g_Timers) do
		killTimer(v)
	end
	for _,v in ipairs(g_BindKeys) do
		unbindKey(v.key,v.state,v.func)
	end
	g_EventHandlers = {}
	g_Timers = {}
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