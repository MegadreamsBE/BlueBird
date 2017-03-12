---------------------------------<
-- Login System
-- c_load.lua
---------------------------------<

g_ResourceRoot = getResourceRootElement(getThisResource())

addEvent("onClientWantApplications",true)
addEventHandler("onClientWantApplications", g_ResourceRoot,
	function(list)
		for _,app in ipairs(list) do
			exports[app]:loadApplication()
		end
	end
)

addEvent("onClientInitializeQuickAccesNeeded",true)
addEventHandler("onClientInitializeQuickAccesNeeded",g_ResourceRoot,
	function(layout)
		exports.BB_Menu:initializeQuickAcces(layout)
	end
)

addEvent("onClientInitializeAppsListNeeded",true)
addEventHandler("onClientInitializeAppsListNeeded",g_ResourceRoot,
	function(list)
		exports.BB_Menu:initializeAppsList(list)
	end
)

addEvent("onClientInitializeRoomsNeeded",true)
addEventHandler("onClientInitializeRoomsNeeded",g_ResourceRoot,
	function()
		exports.BB_Menu:initializeRoomsList(list)
	end
)

fileDelete("c_load.lua")