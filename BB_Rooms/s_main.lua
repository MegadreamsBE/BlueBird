-- Variables
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

g_Rooms = {
[1] = { name="HUB", modename="HUB", gamemode="hub", maxPlayers=-1, map=-1, mapFolder=-1,mapName="None", prev=-1, carfade=false, lastsurvivor=false, mapghostmode=false, default=true, visible=true, locked=true, mapFolders = {
[1] = "hub"
} },

[2] = { name="Deathmatch", modename="Deathmatch", gamemode="veh-dm", maxPlayers=-1, map=-1, mapFolder=-1,mapName="None", prev=-1, carfade=true, lastsurvivor=true, mapghostmode=false, default=true, visible=true, locked=false, mapFolders = {
[1] = "race-dm"
} },

[3] = { name="Destruction Derby", modename="Destruction Derby", gamemode="veh-dd", maxPlayers=32, map=-1, mapFolder=-1,mapName="None", prev=-1, lastsurvivor=false, carfade=false, mapghostmode=false, default=true, visible=true, locked=false, mapFolders = {
[1] = "race-dd"
} },

[4] = { name="Hunter", modename="Hunter", gamemode="veh-hunter", maxPlayers=20, map=-1, mapFolder=-1,mapName="None", prev=-1, lastsurvivor=false, carfade=false, mapghostmode=false, default=true, visible=true, locked=false, mapFolders = {
[1] = "race-hunter"
} },

[5] = { name="Shooter", modename="Shooter", gamemode="veh-shooter", maxPlayers=15, map=-1, mapFolder=-1,mapName="None", prev=-1, lastsurvivor=false, carfade=false, mapghostmode=false, default=true, visible=true, locked=false, mapFolders = {
[1] = "race-shooter"
} },

[6] = { name="TRON", modename="TRON", gamemode="veh-tron", maxPlayers=20, map=-1, mapFolder=-1,mapName="None", prev=-1, lastsurvivor=false, carfade=false, mapghostmode=false, default=true, visible=true, locked=true, mapFolders = {
[1] = "race-tron"
} },

[7] = { name="Race", modename="Race", gamemode="veh-race", maxPlayers=32, map=-1, mapFolder=-1,mapName="None", prev=-1, lastsurvivor=false, carfade=true, mapghostmode=true, default=true, visible=true, locked=true, mapFolders = {
[1] = "race"
} },

[8] = { name="FUN", modename="FUN", gamemode="veh-race", maxPlayers=32, map=-1, mapFolder=-1,mapName="None", prev=-1, lastsurvivor=false, carfade=false, mapghostmode=false, default=true, visible=true, locked=true, mapFolders = {
[1] = "race-fun"
} },

[9] = { name="Busted", modename="Busted", gamemode="veh-race", maxPlayers=75, map=-1, mapFolder=-1,mapName="None", prev=-1, lastsurvivor=false, carfade=false, mapghostmode=false, default=true, visible=true, locked=true, mapFolders = {
[1] = "busted"
} }
}

-- Map Ghostmode defines if the map itself defines the ghostmode.

Gamemodes = {
[1] = "veh-dm",
[2] = "veh-dd",
[3] = "veh-hunter",
[4] = "veh-shooter",
[5] = "veh-tron",
[6] = "hub"
}

-- Events

addEventHandler ( "onResourceStart", g_ResourceRoot,
	function(res)
		for num, gm in ipairs(Gamemodes) do
			startResource(getResourceFromName(gm))
		end
		
		for num, rm in ipairs(g_Rooms) do
			if (getResourceFromName(rm.gamemode)) then
				exports[rm.gamemode]:setRoomID(num)
			end
			attachRoomElement(num)
		end
		
		for _,v in ipairs(getElementsByType("player")) do
			setElementParent(v,getElementByID("room_1"))
			setElementData(v,"bb.room",1)
		end
		
		setTimer(calculatePlayers,5000,0)
	end
)

addEventHandler ( "onResourceStop", g_ResourceRoot,
	function(res)
		for num, gm in ipairs(Gamemodes) do
			stopResource(getResourceFromName(gm))
			destroyElement(getElementByID("room_"..tostring(num)))
		end
		
		for _,plr in ipairs(getElementsByType("player")) do
			fadeCamera(plr,false)
			triggerEvent("onPlayerLeaveRoom",plr)
			setElementData(plr,"bb.room",-1)
		end
	end
)

addEventHandler ( "onPlayerQuit", g_Root,
	function(reason)
		triggerEvent("onPlayerLeaveRoom",source)
	end
)

function onRoomStop(roomID)
	local aliveTable = getPlayersInRoom(roomID)
	for _,v in ipairs(aliveTable) do
		destroyElement(getElementByID("room_"..tostring(roomID)))
		triggerEvent("onPlayerLeaveRoom",v)
	end
end

function calculatePlayers()
	for i,v in ipairs(g_Rooms) do
		g_Rooms[i].players = #getPlayersInRoom(i)
	end
end

function attachRoomElement(roomID)
	destroyElement(getElementByID("room_"..tostring(roomID)))
	createElement("room", "room_"..tostring(roomID))
	
	setElementData(getElementByID("room_"..tostring(roomID)),"room.lastsurvivor",g_Rooms[roomID].lastsurvivor)
	setElementData(getElementByID("room_"..tostring(roomID)),"room.maxplayers",g_Rooms[roomID].maxPlayers)
	setElementData(getElementByID("room_"..tostring(roomID)),"room.locked",g_Rooms[roomID].locked)
	
	if(g_Rooms[roomID].mapghostmode == false) then
		setElementData(getElementByID("room_"..tostring(roomID)),"room.ghostmode",g_Rooms[roomID].carfade)
		setElementData(getElementByID("room_"..tostring(roomID)),"room.mapghostmode",false)
	else
		setElementData(getElementByID("room_"..tostring(roomID)),"room.mapghostmode",true)
	end
end

addEventHandler("onPlayerJoin", g_Root,
	function()
		setElementParent(source,getElementByID("room_1"))
		setElementData(source,"bb.room",1)
	end
)

function addPlayer(room)
	if (not (getElementData(source,"bb.room") == room) or ((getElementData(source,"bb.forcejoin") or false) == true)) then
		if ((getElementChildrenCount(getElementByID("room_"..tostring(room))) >= g_Rooms[room].maxPlayers) and (g_Rooms[room].maxPlayers > -1)) then
			triggerClientEvent(source,"onFullRoom",getRootElement())
			return
		end
		
		setElementData(source,"bb.forcejoin",false)
		
		if(g_Rooms[room].locked) then
			triggerClientEvent(source,"onLockedRoom",getRootElement())
			return
		end
		
		toggleControl(source,"accelerate", true)
		toggleControl(source,"brake_reverse", true)
		toggleControl(source,"enter_exit", true)
		setCloudsEnabled(false)
		
		setPedStat(source, 160, 1000)
        setPedStat(source, 229, 1000)
        setPedStat(source, 230, 1000)
		
		setElementParent(source,getElementByID("room_"..tostring(room)))
		setElementData(source,"bb.room",room)
		
		if(g_Rooms[room].carfade == true) then
			setElementData(source,"BB.Fade",true)
		else
			setElementData(source,"BB.Fade",false)
		end
		
		triggerClientEvent(source,"onRoomJoin",getRootElement(),room,g_Rooms[room])
		
		local playerList = {}
		for i,v in ipairs(getElementChildren(getElementByID("room_"..tostring(room)),"player")) do
			table.insert(playerList,v)
			setElementData(v,"UAG.pIDroom",i)
		end
		exports[g_Rooms[room].gamemode]:onPlayerTableUpdate(((#playerList or 0)-1),playerList)
		--exports.BB_Maps:loadMapForPlayer(source,room,g_Rooms[room].mapFolder,g_Rooms[room].map)
	end
end
addEvent("onPlayerJoinRoom",true)
addEventHandler("onPlayerJoinRoom",getRootElement(), addPlayer)

function removePlayer(player)
	if(player ~= nil) then
		source = player
	end

	setElementData(source,"BB.Fade",false)
			
	local plrRoom = getElementData(source,"bb.room")
			
	exports[g_Rooms[plrRoom].gamemode]:onPlayerLeaveRoom(source)
	setElementParent(source,-1)		
			
	setElementData(source,"bb.room",getElementByID("room_1"))
			
	exports.BB_Maps:unloadMapForPlayer(source,plrRoom)
			
	local playerList = getElementChildren(getElementByID("room_"..tostring(plrRoom)),"player")
		
	exports[g_Rooms[plrRoom].gamemode]:onPlayerTableUpdate(((#playerList or 0)+1),playerList)
			
	destroyElement(getElementData(source,"UAG.vehicle"))
end
addEvent("onPlayerLeaveRoom",true)
addEventHandler("onPlayerLeaveRoom",getRootElement(), removePlayer)

function getRooms()
	triggerClientEvent(source,"onReceiveRooms",getRootElement(),g_Rooms)
end
addEvent("requestServerRooms",true)
addEventHandler("requestServerRooms",getRootElement(), getRooms)

function getPlayersInRoom(room)
	return getElementChildren(getElementByID("room_"..tostring(room)))
end

function getRoomInformation(roomID)
	return (g_Rooms[roomID] or false)
end

function getDefaultRooms()
	local roomList = {}
	for i,v in ipairs(g_Rooms) do
		if(v.default == true) then
			table.insert(roomList,{roomID = i, roomName = v.name, maxPlayers = v.maxPlayers, players = v.players})
		end
	end
	return roomList
end

function getRoomIDAssociatedWithGamemode(gamemode)
	for i,v in ipairs(g_Rooms) do
		if(v.gamemode == gamemode) then
			attachRoomElement(i)
			return i
		end
	end
	return false
end

function setRoomLocked(roomID,locked)
	for i,v in ipairs(g_Rooms) do
		if(i == roomID) then
			v.locked = locked
		end
		break
	end
end

function removePlayersFromRoom(roomID)
	for i,v in ipairs(getPlayersInRoom(roomID)) do
		fadeCamera(v,false)
		setElementParent(v,-1)
		setElementData(v,"bb.room",-1)
		
		exports.BB_Maps:unloadMapForPlayer(v,roomID)
		break
	end
end

function setRoomPrevMap(roomID)
	g_Rooms[roomID].prev = g_Rooms[roomID].map
end

function setRoomMap(roomID,folder,cmap,mapname)
	g_Rooms[roomID].map = cmap
	g_Rooms[roomID].mapFolder = folder
	g_Rooms[roomID].mapName = mapname
end

function mapRequest(roomID)
	exports.BB_Maps:loadMapForPlayer(source,roomID,g_Rooms[roomID].mapFolder,g_Rooms[roomID].map)
end
addEvent("onMapRequest",true)
addEventHandler("onMapRequest",getRootElement(), mapRequest)