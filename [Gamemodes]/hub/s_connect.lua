-- Variables
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

g_mapFolders = {
[1] = "hub"
}

g_roomID = -1
g_Files = {}

-- Functions | Events

addEvent("onRequestDownload",true)
addEventHandler("onRequestDownload", g_ResourceRoot,
	function(player,filename)
		local file = fileOpen(filename)
		local buffer = ""
		while not fileIsEOF(file) do
		    buffer = buffer..fileRead(file, 500)
		end
		triggerLatentClientEvent(player,"onClientDownloaded", 50*10^64,false,g_ResourceRoot,buffer,filename)
	end
)

addEventHandler("onResourceStart",g_ResourceRoot,
	function(res)
		g_roomID = exports.BB_Rooms:getRoomIDAssociatedWithGamemode(getResourceName(res))
		exports.BB_Rooms:setRoomLocked(g_roomID,false)
		
		exports.BB_Maps:loadRandomMap(g_roomID,g_mapFolders)
	end
)

addEventHandler("onResourceStop",g_ResourceRoot,
	function(res)
		exports.BB_Rooms:setRoomLocked(g_roomID,true)
		exports.BB_Rooms:removePlayersFromRoom(g_roomID)
		
		exports.BB_Maps:unloadMap(g_roomID)
	end
)

function onPlayerTableUpdate(prevcount,players)
	
end

function onPlayerLeaveRoom(player)
	if(getElementData(player,"state") == "alive") then
		--addDeathlist(player,getPlayerName(player))
		setElementData(player,"state","loading")
	end
	checkSurvivors(nil)
end

function setRoomID(roomID)
	g_roomID = roomID
end