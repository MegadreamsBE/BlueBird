-- Variables
g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

g_Rooms = {}

-- Events

addEventHandler("onClientResourceStart",g_ResourceRoot,
	function()
		triggerServerEvent("requestServerRooms",localPlayer)
		setTimer(updateRooms,5000,0)
		
		bindKey("f1","down",joinHUB)
		
		if(getElementData(localPlayer, "UAG.Account.Logged") == true) then
			joinHUB()
		end
	end
)

addEventHandler("onClientResourceStop",g_ResourceRoot,
	function()
		unbindKey("f1","down")
	end
)

addEvent("onFullRoom",true)
addEventHandler("onFullRoom",getRootElement(),
	function()
		exports.BB_Notify:Notify("This room is full.\nPlease try another one or wait.", 2, "Error")
	end
)

addEvent("onLockedRoom",true)
addEventHandler("onLockedRoom",getRootElement(),
	function()
		exports.BB_Notify:Notify("This room is locked.\nPlease try another room.", 2, "Error")
	end
)

function joinHUB()
	joinRoom(1)
end

function joinRoom(roomID)
	if((tonumber(getElementData(localPlayer,"bb.room") or -1) == roomID) and ((getElementData(localPlayer,"bb.forcejoin") or false) == false)) then return end
	
	local idRoom = getElementByID("room_"..tostring(roomID))
	
	if(getElementData(idRoom,"room.locked") == true) then
		exports.BB_Notify:Notify("This room is locked.\nPlease try another room.", 2, "Error")
		return
	end
	
	if ((getElementChildrenCount(idRoom) >= getElementData(idRoom,"room.maxplayers")) and (getElementData(idRoom,"room.maxplayers") > -1)) then
		exports.BB_Notify:Notify("This room is full.\nPlease try another one or wait.", 2, "Error")
		return
	end
	fadeCamera(false) 

	if (tonumber(getElementData(localPlayer,"bb.room") or -1) > -1) then
		leaveRoom()
	end
	
	toggleAllControls(true, true,false)
	triggerServerEvent("onPlayerJoinRoom",localPlayer,roomID)
end

function leaveRoom()
	for _,v in ipairs(getElementsByType("vehicle")) do
		destroyElement(v)
	end
	
	local room = getElementData(localPlayer,"bb.room")
	exports[g_Rooms[room].gamemode]:unloadGamemode()
	triggerServerEvent("onPlayerLeaveRoom",localPlayer)
	setElementData(localPlayer,"bb.room",-1)
end

function clientJoinedRoom(roomID,roomInfo)
	exports.BB_Menu:ToggleMenu(false)
	
	showPlayerHudComponent("ammo", false)
	showPlayerHudComponent("area_name", false)
	showPlayerHudComponent("armour", false)
	showPlayerHudComponent("breath", false)
	showPlayerHudComponent("clock", false)
	showPlayerHudComponent("health", false)
	showPlayerHudComponent("money", false)
	showPlayerHudComponent("vehicle_name", false)
	showPlayerHudComponent("weapon", false)
	showPlayerHudComponent("wanted", false)
	
	exports[roomInfo.gamemode]:loadGamemode()
end
addEvent("onRoomJoin",true)
addEventHandler("onRoomJoin",getRootElement(),clientJoinedRoom)

--

function updateRooms()
	triggerServerEvent("requestServerRooms",localPlayer)
end

function requestRooms()
	return g_Rooms
end

function receivedRooms(rooms)
	g_Rooms = rooms
end
addEvent("onReceiveRooms",true)
addEventHandler("onReceiveRooms",getRootElement(),receivedRooms)

function loadRoomMap(player,roomID)
	setElementPosition(player,0,0,5)
	triggerServerEvent("onMapRequest",localPlayer,roomID)
end

function getClientPlayersInRoom()
	return getElementChildren(getElementByID("room_"..tostring(getElementData(localPlayer,"bb.room"))))
end


fileDelete("c_main.lua")
