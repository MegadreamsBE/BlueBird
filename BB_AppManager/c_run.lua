---------------------------------<
-- Bluebird Application Manager
-- c_run.lua
---------------------------------<
-- *~ Variables ~*
---------------------------------<

g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

RunningApp = false
Closing = false

---------------------------------<
-- *~ Functions ~* 
---------------------------------<

function LoadApp(name) -- Name = Resource name of that app.
	if RunningApp then return else RunningApp = name end
	exports.BB_Menu:FadeOutMenu()
	setTimer(
		function()
			exports[RunningApp]:openApplication()
		end
	, 400, 1)
end

function CloseApp()
	if not RunningApp then return end
	if Closing then return end
	Closing = true
	local bool = exports[RunningApp]:closeApplication()
	if bool == false then Closing = false return end -- To lock an app, simply return false.

	setTimer(
		function()
			exports.BB_Menu:FadeInMenu()
			RunningApp = false
			Closing = false
		end
	, 400, 1)
end

function IsRunningApp()
	return RunningApp
end

---------------------------------<
-- *~ Events/Handlings ~*
---------------------------------<