-- Variables
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

g_mapFolders = { }

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
		fileClose(file)
		triggerLatentClientEvent(player,"onClientDownloaded", 50*10^64,false,g_ResourceRoot,buffer,filename)
	end
)

addEventHandler("onResourceStart",g_ResourceRoot,
	function(res)
		g_roomID = exports.BB_Rooms:getRoomIDAssociatedWithGamemode(getResourceName(res))
		exports.BB_Rooms:setRoomLocked(g_roomID,false)
		
		local roomInfo = exports.BB_Rooms:getRoomInformation(g_roomID)
		g_mapFolders = roomInfo.mapFolders
	end
)

addEventHandler("onResourceStop",g_ResourceRoot,
	function(res)
		exports.BB_Rooms:setRoomLocked(g_roomID,true)
		exports.BB_Rooms:removePlayersFromRoom(g_roomID)
	end
)

function onPlayerTableUpdate(prevcount,players)
	if(prevcount == 0 and #players >= 1) then
		g_currentMap = exports.BB_Maps:loadRandomMap(g_roomID,g_mapFolders)
		mapState = "loading"
		mapStarts()
		return
	else
		if(#players == 0) then 
			mapState = "loading"
			mapStops()
			exports.BB_Maps:unloadMap(g_roomID)
			
			killTimer(cdTimeOutTimer)
			killTimer(cdTimer)
			return
		end
	end
end

function onPlayerLeaveRoom(player)
	if(getElementData(player,"state") == "alive" and getElementData(getElementByID("room_"..tostring(g_roomID)),"room.state") == "playing") then
		setElementData(player,"state","loading")
		addDeathlist(player,getPlayerName(player))
		checkSurvivors(nil)
	end
	
	if(getElementChildrenCount(getElementByID("room_"..tostring(g_roomID))) == 0) then
		killTimer(cdTimeOutTimer)
		killTimer(cdTimer)
	end
end


function setRoomID(roomID)
	g_roomID = roomID
end