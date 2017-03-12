---------------------------------<
-- Application API
-- c_api.lua
---------------------------------<

g_EventHandlers = {}
g_AppWindows = {}

_addEventHandler = addEventHandler
_removeEventHandler = removeEventHandler

function addEventHandler(eventName,attachedTo,handlerFunction,...)
	if(handlerFunction == nil or handlerFunction == false) then return end
	if(eventName == "onClientDXClick") then
		table.insert(g_EventHandlers, { eventName=eventName, attachedTo=attachedTo,handlerFunction=handlerFunction })
	end
	return _addEventHandler(eventName,attachedTo,handlerFunction)
end

function removeEventHandler(...)
	return _removeEventHandler(...)
end

function createAppWindow(...)
	local element = exports.BB_Menu:createAppWindow(...)
	table.insert(g_AppWindows,element)
	return element
end

function dxCreateText(...)
	return exports.BB_GUI:dxCreateText(...)
end

function dxCreateEdit(...)
	return exports.BB_GUI:dxCreateEdit(...)
end

function dxCreateButton(...)
	return exports.BB_GUI:dxCreateButton(...)
end

function dxCreateRectangle(...)
	return exports.BB_GUI:dxCreateRectangle(...)
end

function dxCreateImage(...)
	return exports.BB_GUI:dxCreateImage(...)
end

function dxCreateAnimation(...)
	return exports.BB_GUI:dxCreateAnimation(...)
end

function dxSetProperty(...)
	return exports.BB_GUI:dxSetProperty(...)
end

function dxGetProperty(...)
	return exports.BB_GUI:dxGetProperty(...)
end

function dxGetColor(...)
	return exports.BB_GUI:dxGetColor(...)
end

function dxGetFont(...)
	return exports.BB_GUI:dxGetFont(...)
end

function sendNotify(...)
	return exports.BB_Notify:Notify(...)
end

function dxDestroyChildren(...)
	return exports.BB_GUI:dxDestroyChildren(...)
end

function closeAPP()
	exports.BB_GUI:dxCreateAnimation(g_AppWindows[1], "RotateBackLeft", false, "InQuad", 400, false)
	
	setTimer(
	function()
		for _,v in ipairs(g_AppWindows) do
			destroyElement(v)
		end
	end,600,1)
	
	g_AppWindows = {}
	
	for _,v in ipairs(g_EventHandlers) do
		_removeEventHandler(v.eventName,v.attachedTo,v.handlerFunction)
	end
end