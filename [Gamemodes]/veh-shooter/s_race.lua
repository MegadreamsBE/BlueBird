-- Variables
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

cdTimer = nil
cdTimeOutTimer = nil
mapState = "loading"
g_currentMap = -1
g_forcedMap = -1
g_nextMapName = "Random"

lastSurvivor = false

g_Vehicles = {}
g_Deathlist = {}
lastDeathPos = -1

local endTime = 0

addEvent("onResourceStart",true)
addEventHandler("onResourceStart",g_ResourceRoot,
	function(res)
		setTimer(performChecks,2500,0)
	end
)

function performChecks()
	for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
		if(getElementData(v,"state") == "spectating") then
			if(((getCameraTarget(v) or v) == v) or (getCameraTarget(v) == false)) then
				goSpectating(v)
			else
				if((getElementData(getCameraTarget(v),"state") ~= "alive") or (getElementData(getCameraTarget(v),"bb.room") ~= getElementData(v,"bb.room"))) then
					goSpectating(v)
				end
			end
		end
		
		local plrVehicle = getElementData(v,"UAG.vehicle")
		if ((getElementData(plrVehicle,"UAG.WonVehicle") or false)) then
			setElementDimension(plrVehicle,getElementData(v,"bb.room"))
			setElementDimension(v,getElementData(v,"bb.room"))
			warpPedIntoVehicle(v,plrVehicle)
			setElementPosition(plrVehicle,getElementData(v,"UAG.spawnPosX"),getElementData(v,"UAG.spawnPosY"),getElementData(v,"UAG.spawnPosZ"))
			setElementRotation(plrVehicle,getElementData(v,"UAG.spawnRotX"),getElementData(v,"UAG.spawnRotY"),getElementData(v,"UAG.spawnRotZ"))
		end
		
		if((getPedOccupiedVehicle(v) ~= false) and ((getElementData(plrVehicle,"UAG.WonVehicle") or false) == false)) then
			if(getElementHealth(v) <= 0) then
				killPed(v)
			end
		end
		
		if(plrVehicle ~= false) then
			if(getElementModel(plrVehicle) == 425) then
				toggleControl(v,'vehicle_secondary_fire', false)
			else
				toggleControl(v,'vehicle_secondary_fire', true)
			end
		end
		
		if((endTime-(getTickCount()) <= 0) and (getElementData(getElementByID("room_"..tostring(g_roomID)),"room.state") == "playing")) then
			randomMap(false)
		end
		
		if(getElementData(getElementByID("room_"..tostring(g_roomID)),"room.state") == "playing") then
			triggerClientEvent(v,"setTimeLeft",getRootElement(),(endTime-getTickCount()))
		end
	end
end

addEvent("onMapSpawn",true)
addEventHandler("onMapSpawn",g_Root,
	function(spawn)
		if(getElementData(source,"bb.room") ~= g_roomID) then return end
		spawnPlayer(source, spawn.posX, spawn.posY,spawn.posZ, 0.0, 0, 0, getElementData(source,"bb.room"))
		setElementAlpha(source,255)
		setCameraTarget(source,source)
		
		local roomInfo = exports.BB_Rooms:getRoomInformation(g_roomID)
		triggerClientEvent(source,"setCurrentMap",getRootElement(),roomInfo.mapName)
		triggerClientEvent(source,"setNextMap",getRootElement(),g_nextMapName)
		triggerClientEvent(source,"updateDeathList",getRootElement(),g_Deathlist)
		
		if(mapState == "running") then
			setElementData(source,"state","spectating")
			setTimer (function(player)
				goSpectating(player)
				triggerClientEvent(player,"setTimeLeft",getRootElement(),(endTime-getTickCount()))
			end, 100, 1, source)
			return
		end
		
		setElementDimension(source,getElementData(source,"bb.room"))
		
		if(isElement(getElementData(source,"UAG.vehicle"))) then
			destroyElement(getElementData(source,"UAG.vehicle"))
		end
		
		plrVehicle = createVehicle(spawn.vehicle, spawn.posX, spawn.posY,spawn.posZ,
		spawn.rotX, spawn.rotY, spawn.rotZ)
		fixVehicle(plrVehicle)
		setElementFrozen(plrVehicle, true)
		setElementFrozen(source,false)
		setVehicleDamageProof(plrVehicle, true)
		setElementDimension(plrVehicle,getElementData(source,"bb.room"))
		setCameraTarget(source,source)
	
		setElementData(source,"UAG.spawnPosX",spawn.posX)
		setElementData(source,"UAG.spawnPosY",spawn.posY)
		setElementData(source,"UAG.spawnPosZ",spawn.posZ)
		setElementData(source,"UAG.spawnRotX",spawn.rotX)
		setElementData(source,"UAG.spawnRotY",spawn.rotY)
		setElementData(source,"UAG.spawnRotZ",spawn.rotZ)
	
		setElementSyncer(plrVehicle,false)
	
		setElementData(source,"UAG.vehicle",plrVehicle)
		table.insert(g_Vehicles, { plr = source, vehicle = plrVehicle} )
		
		removePedFromVehicle(source)
		
		setTimer (function(player, plrVehicle)
			setElementDimension(player,getElementData(player,"bb.room"))
			warpPedIntoVehicle(player,plrVehicle,0)
			
			toggleControl(player,"accelerate", false)
			toggleControl(player,"brake_reverse", false)
			toggleControl(player,"enter_exit", false)
			setTimer (function(player)
				fadeCamera(player,true)
				setElementData(player,"state","alive")
				for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
					triggerClientEvent(v,"setGhostMode",getRootElement(),getAlivePlayers(),getElementData(getElementByID("room_"..tostring(g_roomID)),"room.ghostmode"))
				end
			end, 50, 1, player)
		end, 50, 1, source, plrVehicle)
	end
)

addEvent("destroyPlayerVehicle",true)
addEventHandler("destroyPlayerVehicle",g_Root,
	function()
		for i,v in ipairs(g_Vehicles) do
			if(isElement(v.vehicle) and v.plr == source) then
				destroyElement(v.vehicle)
				table.remove(g_Vehicles,i)
			end
		end
		setElementData(source,"UAG.vehicle",-1)
	end
)

addEventHandler ( "onPlayerQuit", g_Root,
	function(reason)
		for i,v in ipairs(g_Vehicles) do
			if(isElement(v.vehicle) and v.plr == source) then
				destroyElement(v.vehicle)
				table.remove(g_Vehicles,i)
			end
		end
		
		local plrTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
		for _,v in ipairs(plrTable) do
			if(getElementData(v,"spectating") == source) then
				goSpectating(v)
			end
		end
	end
)


addEvent("onRacePickupTrigger",true)
addEventHandler("onRacePickupTrigger",g_Root,
	function(pickup)
		if(getElementData(source,"bb.room") ~= g_roomID) then
			return
		end
		
		local plrVehicle = getPedOccupiedVehicle(source)
		if(pickup.pType == "nitro") then
			playSoundFrontEnd(source,46)
			addVehicleUpgrade(plrVehicle, 1010)
		end
		if(pickup.pType == "repair") then
			playSoundFrontEnd(source,46)
			fixVehicle(plrVehicle)
			setVehicleWheelStates(plrVehicle,0,0,0,0)
			for i=0,5 do
				setVehicleDoorOpenRatio(plrVehicle, i, 0)
			end
		end
		if(pickup.pType == "vehiclechange") then
			if (tonumber(getElementModel(plrVehicle)) ~= tonumber(pickup.vehicle)) then
				playSoundFrontEnd(source,46)
				setElementModel(plrVehicle,pickup.vehicle)
				
				triggerClientEvent(source,"alignVehicleWithUp",getRootElement())
			end
		end
	end
)

addEvent("onKillPlayer",true)
addEventHandler("onKillPlayer",g_Root,
	function()
		if(getElementData(source,"bb.room") ~= g_roomID) then
			return
		end
		
		--fadeCamera(source,true)
		killPed(source)
	end
)

function goSpectating(player)
	if (getElementData(player, "bb.room") ~= g_roomID) then return end
	local aliveTable = getAlivePlayers()
	
	local aliveSeed = 0
	if(#aliveTable > 0) then
		aliveSeed = math.random(1,#aliveTable)
		fadeCamera(player,true)
	end
	
	setElementData(player,"state","spectating")
	
	setElementAlpha(player,0)
	if(#aliveTable <= 0) then 
		setElementData(player,"spectating",-1)
		triggerClientEvent(player,"setCurrentMatrix",g_Root)
	else
		if(#aliveTable == 1) then
			setElementData(player,"spectating",aliveTable[1])
			setCameraTarget(player,aliveTable[1])
		else
			setElementData(player,"spectating",aliveTable[aliveSeed])
			setCameraTarget(player,aliveTable[aliveSeed])
		end
	end
	setElementDimension(player,getElementData(player,"bb.room"))
	
	triggerClientEvent(player,"setGhostMode",getRootElement(),aliveTable,getElementData(getElementByID("room_"..tostring(g_roomID)),"room.ghostmode"))
end

addEvent("onSpectateTrigger",true)
addEventHandler("onSpectateTrigger",g_Root,
	function()
		goSpectating(source)
	end
)

addEvent("onSpectatePrevious",true)
addEventHandler("onSpectatePrevious",g_Root,
	function()
		if(getElementData(source,"bb.room") ~= g_roomID) then
			return
		end
		
		local aliveTable = getAlivePlayers()
		
		if(#aliveTable <= 1) then return end
		
		local lastFound = nil
		for i,v in ipairs(aliveTable) do
			if(getElementData(source,"spectating") == v) then
				if(i == 1) then
					setElementData(source,"spectating",aliveTable[#aliveTable])
					setElementDimension(source,getElementData(source,"bb.room"))
					setCameraTarget(source,aliveTable[#aliveTable])
					return
				else
					setElementData(source,"spectating",aliveTable[lastFound])
					setElementDimension(source,getElementData(source,"bb.room"))
					setCameraTarget(source,aliveTable[lastFound])
				end
			else
				lastFound = i
			end
		end
	end
)

addEvent("onSpectateNext",true)
addEventHandler("onSpectateNext",g_Root,
	function()
		if(getElementData(source,"bb.room") ~= g_roomID) then
			return
		end
		
		local aliveTable = getAlivePlayers()
		
		if(#aliveTable <= 1) then return end
		
		local isFound = false
		for i,v in ipairs(aliveTable) do
			if ((isFound == true) and v ~= getElementData(source,"spectating")) then
				setElementData(source,"spectating",aliveTable[i])
				setElementDimension(source,getElementData(source,"bb.room"))
				setCameraTarget(source,aliveTable[i])
				return
			end
			if(getElementData(source,"spectating") == v) then
				isFound = true
			end
		end
		
		if(isFound == true) then
			setElementData(source,"spectating",aliveTable[1])
			setElementDimension(source,getElementData(source,"bb.room"))
			setCameraTarget(source,aliveTable[1])
		end
	end
)


addEventHandler( "onVehicleExplode", getRootElement(),
	function()
		if(getElementData(getElementByID("room_"..tostring(g_roomID)),"room.state") == "playing") then
			return
		end
		if(getElementData(source,"state") ~= "alive") then
			goSpectating(source)
			return
		end
		killPed(getVehicleOccupant(source))
		setElementHealth(getVehicleOccupant(source),0)
	end
)

addEventHandler ( "onPlayerWasted", getRootElement(),
	function()
		if(getElementData(source,"bb.room") ~= g_roomID) then return end
		if (mapState ~= "running") then return end
		if (getElementData(source,"state") ~= "alive") then return end	
		
		triggerEvent("onPlayerRaceWasted",source,getElementData(source,"UAG.vehicle"))
		
		setElementData(source,"state","dead")
		triggerClientEvent(source,"setCurrentMatrix",g_Root)
		
		local pX,pY,pZ = getElementPosition(source)
		
		setElementAlpha(source,0)
		setElementHealth(source,100)
		--setElementPosition(source,0,0,3)
		--setElementPosition(getElementData(source,"UAG.vehicle"),0,0,3)
		
		removePedFromVehicle(source)
		setElementDimension(source,getElementData(source,"bb.room"))
		
		setTimer(function(player)
			if(getElementData(getElementByID("room_"..tostring(g_roomID)),"room.state") ~= "winning") then
				goSpectating(player)
				setElementAlpha(getElementData(player,"UAG.vehicle"),0)
				setElementDimension(getElementData(player,"UAG.vehicle"),(g_roomID*53))
			end
		end,1500,1,source)
		addDeathlist(source,getPlayerName(source))
		
		local aliveTable = getAlivePlayers()
		if(#aliveTable >= 1) then
			exports.BB_Statistics:onPlayerDieStatistics(source,lastDeathPos,#exports.BB_Rooms:getPlayersInRoom(g_roomID))
		end

		if(checkSurvivors(source)) then
			return
		end
		
		local plrTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
		for _,v in ipairs(plrTable) do
			if((getElementData(v,"state") ~= "alive") and getElementData(v,"spectating") == source) then
				goSpectating(v)
			end
		end
	end
)

function addDeathlist(player,playerName,left)
	local aliveTable = getAlivePlayers()
	
	if(lastDeathPos == -1) then
		if(#aliveTable > 0) then
			lastDeathPos = (#aliveTable+1)
		else
			lastDeathPos = 1
		end
	else
		lastDeathPos = lastDeathPos - 1
	end
	
	for _,v in ipairs(g_Deathlist) do
		if(v.player == player) then
			return
		end
	end
	
	table.insert(g_Deathlist,{ pos = lastDeathPos, player=player, name=playerName })
	if(#aliveTable == 1) then
		for _,v in ipairs(aliveTable) do
			lastDeathPos = 1
			table.insert(g_Deathlist,{ pos = lastDeathPos, player=v, name=getPlayerName(v) })
		end
	end
	
	for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
		triggerClientEvent(v,"updateDeathList",getRootElement(),g_Deathlist)
	end
end

function checkSurvivors(player)
	local aliveTable = getAlivePlayers()
	
	if(#aliveTable == 1 and mapState == "running" and getElementData(getElementByID("room_"..tostring(g_roomID)),"room.lastsurvivor") == true) then
		for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
			if(lastSurvivor == false) then
				triggerClientEvent(v,"onLastSurvivor",getRootElement())
			end
		end
		
		for _,v in ipairs(getAlivePlayers()) do
			exports.BB_Statistics:onPlayerDieStatistics(v,1,#exports.BB_Rooms:getPlayersInRoom(g_roomID))
		end
		
		lastSurvivor = true
		return true
	end

	local checkAmount = 1
	
	if(getElementData(getElementByID("room_"..tostring(g_roomID)),"room.lastsurvivor") == true) then
		checkAmount = 0
	else
		checkAmount = 1
	end
	
	if(getElementData(getElementByID("room_"..tostring(g_roomID)),"room.lastsurvivor") == false) then
		for _,v in ipairs(getAlivePlayers()) do
			player = v
			exports.BB_Statistics:onPlayerDieStatistics(v,1,#exports.BB_Rooms:getPlayersInRoom(g_roomID))
		end
	end
	
	if(#aliveTable <= checkAmount and mapState == "running") then		
		for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
			fadeCamera(v,false)
			setElementData(v,"state","dead")
			removePedFromVehicle(v)
			triggerClientEvent(v,"setCurrentMatrix",g_Root)
		end
		
		setTimer(function(player)
			for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
				setElementData(getElementByID("room_"..tostring(g_roomID)),"room.state","winning")
				
				local pX,pY,pZ = getElementPosition(player)
				spawnPlayer(player,pX,pY,pZ,0,getElementModel(player),0,getElementData(player,"bb.room"))
				
				local plrVehicle = getElementData(player,"UAG.vehicle")
				setElementPosition(plrVehicle,getElementData(player,"UAG.spawnPosX"),getElementData(player,"UAG.spawnPosY"),getElementData(player,"UAG.spawnPosZ"))
				setElementRotation(plrVehicle,getElementData(player,"UAG.spawnRotX"),getElementData(player,"UAG.spawnRotY"),getElementData(player,"UAG.spawnRotZ"))
				setElementFrozen(plrVehicle,true)
				fixVehicle(plrVehicle)
		
				setVehicleWheelStates(plrVehicle,0,0,0,0)
				for i=0,5 do
					setVehicleDoorOpenRatio(plrVehicle, i, 0)
				end
				
				warpPedIntoVehicle(player,plrVehicle)
				setElementData(plrVehicle,"UAG.WonVehicle",true)
				setElementAlpha(plrVehicle,255)
				setElementDimension(plrVehicle,g_roomID)
				setElementAlpha(player,255)
				triggerClientEvent(v,"onWonScreen",getRootElement(),getPlayerName(player),getElementData(player,"UAG.spawnPosX"),getElementData(player,"UAG.spawnPosY"),getElementData(player,"UAG.spawnPosZ"))
			
				setTimer(function()
					mapStops()
					g_currentMap = exports.BB_Maps:loadRandomMap(g_roomID,g_mapFolders,g_forcedMap)
				end,500,1)
			end
		end,1200,1,player)
		
		setTimer(doNextMap,8000,1)
		return false
	end
	return true
end

function getAlivePlayers()
	playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
	local aliveTable = {}
	
	for _,v in ipairs(playerTable) do
		if(getElementData(v,"state") == "alive") then
			table.insert(aliveTable,v)
		end
	end
	return aliveTable
end

function doCountdown()
	playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
	setElementData(getElementByID("room_"..tostring(g_roomID)),"room.state","countdown")
	
	for _,plr in ipairs(playerTable) do
		triggerClientEvent(plr,"doCountdown",getRootElement(),3)
	end
end

function unfreezeCars()	
	local date = getRealTime()
	playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
	mapState = "running"
	
	endTime = getTickCount() + 600000
	
	setTimer(function()
		setElementData(getElementByID("room_"..tostring(g_roomID)),"room.state","playing")
	end, 1000, 1)
	
	for _,plr in ipairs(playerTable) do
		local plrVehicle = getPedOccupiedVehicle(plr)
		setElementFrozen(plrVehicle, false)
		setVehicleDamageProof(plrVehicle, false)
		toggleControl(plr,"accelerate", true)
		toggleControl(plr,"brake_reverse", true)
	end
end

function checkCountdown(timeout)
	playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
	plrReady = 0
	
	for _,v in ipairs(playerTable) do
		if(getElementData(v,"state") == "alive") then
			plrReady = plrReady + 1
		end
	end
	
	if (plrReady == #playerTable) or (timeout == true) then
		killTimer(cdTimeOutTimer)
		killTimer(cdTimer)
		setTimer(doCountdown, 3000, 1)
		setTimer(unfreezeCars, 6000, 1)
	end
end

function mapStops()
	g_currentMap = -1

	for _,v in ipairs(getElementsByType("vehicle")) do
		if(getElementDimension(v) == roomID and ((getElementData(v,"UAG.WonVehicle") or false)) == false) then
			destroyElement(v)
		end
	end
		
	g_Vehicles = {}
	if isTimer(cdTimer) then
		killTimer(cdTimer)
		killTimer(cdTimeOutTimer)
	end
	
	g_Deathlist = {}
	lastDeathPos = -1
end

function mapStarts()
	triggerEvent("onMapStarting",g_Root, nil, nil, nil)
	setTimer(function()
		setElementData(getElementByID("room_"..tostring(g_roomID)),"room.state","starting")
	end,1500,1)
	
	g_forcedMap = -1
	mapState = "starting"
	cdTimer = setTimer(checkCountdown, 1000, 0,false)
	cdTimeOutTimer = setTimer(checkCountdown, 30000, 1,true)
	lastSurvivor = false
	
	local nextMap, nextMapInfo = exports.BB_Maps:getRandomMap(g_roomID,g_mapFolders)
	g_forcedMap = nextMap
	g_nextMapName = nextMapInfo["mapName"]
	
	local roomInfo = exports.BB_Rooms:getRoomInformation(g_roomID)
	for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
		triggerClientEvent(v,"setCurrentMap",getRootElement(),roomInfo.mapName)
	end
	
	for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
		triggerClientEvent(v,"setNextMap",getRootElement(),g_nextMapName)
	end
	
	g_Deathlist = {}
	lastDeathPos = -1
end

addEventHandler ( "onResourceStop", g_ResourceRoot,
	function(res)
		exports.BB_Rooms:onRoomStop(g_roomID)
	end
)

function doNextMap()
	playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
	for _,plr in ipairs(playerTable) do
		fadeCamera(plr,false)
	end
	
	setElementData(getElementByID("room_"..tostring(g_roomID)),"room.state","loading")
	
	setTimer(function()
		playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
		for _,plr in ipairs(playerTable) do
			setElementData(plr,"state","loading")
			roomInfo = exports.BB_Rooms:getRoomInformation(g_roomID)
			exports.BB_Maps:loadMapForPlayer(plr,g_roomID,roomInfo.mapFolder,roomInfo.map)
		end
		mapStarts()
	end,1300,1)
end

function randomMap(player)
	if(player ~= false) then
		if(getElementData(player,"bb.room") ~= g_roomID) then return end
		if not (exports.BB_Login:isInGroup(player,"UAG Member")) then return end
	end
	
	if(player == false) then
		setElementData(getElementByID("room_"..tostring(g_roomID)),"room.state","unloading")
	end
	
	playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
	for _,plr in ipairs(playerTable) do
		fadeCamera(plr,false)
	end
	
	setTimer(function()
		mapState = "unloading"
		setElementData(getElementByID("room_"..tostring(g_roomID)),"room.state","unloading")
	
		mapStops()
		g_currentMap = exports.BB_Maps:loadRandomMap(g_roomID,g_mapFolders,g_forcedMap)
		
		playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
		for _,plr in ipairs(playerTable) do
			setElementData(plr,"state","loading")
			roomInfo = exports.BB_Rooms:getRoomInformation(g_roomID)
			exports.BB_Maps:loadMapForPlayer(plr,g_roomID,roomInfo.mapFolder,roomInfo.map)
		end
		mapStarts()
	end,1500,1)
end
addCommandHandler ("random", randomMap)

function redoMap(player)
	if(getElementData(player,"bb.room") ~= g_roomID) then return end
	if not (exports.BB_Login:isInGroup(player,"UAG Member")) then return end
	
	if(g_forcedMap == g_currentMap) then
		outputChatBox("[REDO]: #91FFFFThis map already has been marked to be replayed.",player,27,161,226,true)
	else
		for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
			outputChatBox("[REDO]: #64a6ff"..getPlayerName(player).." #91FFFFmarked this map to be replayed.",v,27,161,226,true)
		end
		g_forcedMap = g_currentMap
		
		local roomInfo = exports.BB_Rooms:getRoomInformation(g_roomID)
		g_nextMapName = roomInfo.mapName
		
		for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
			triggerClientEvent(v,"setNextMap",getRootElement(),g_nextMapName)
		end
	end
end
addCommandHandler ("redo", redoMap)

function setNextMap(player,cmd,map)
	if(getElementData(player,"bb.room") ~= g_roomID) then return end
	if not (exports.BB_Login:isInGroup(player,"UAG Member")) then return end
	
	local mapTable = exports.BB_Maps:getMapByPartOfName(g_mapFolders,map)
	if(mapTable == false or #mapTable == 0) then
		outputChatBox("[NEXTMAP]: #91FFFFNo maps were found.",player,27,161,226,true)
		return
	end
	
	if((g_forcedMap == mapTable[1].map) and (#mapTable == 1)) then
		outputChatBox("[NEXTMAP]: #91FFFFThis map already is set as the next map.",player,27,161,226,true)
	else
		if(#mapTable >= 5) then
			outputChatBox("[NEXTMAP]: #91FFFFThere are more than 5 maps found. Please be more specific.",player,27,161,226,true)
		else
			if(#mapTable == 1) then
				for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
					outputChatBox("[NEXTMAP]: #64a6ff"..getPlayerName(player).." #91FFFFhas set the next map to:",v,27,161,226,true)
					outputChatBox("[NEXTMAP]: #64a6ff"..mapTable[1].name,v,27,161,226,true)
				end
				g_forcedMap = mapTable[1].map
				g_nextMapName = mapTable[1].name
				for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
					triggerClientEvent(v,"setNextMap",getRootElement(),g_nextMapName)
				end
			else
				outputChatBox("[NEXTMAP]: #91FFFFThere are #64a6ff"..#mapTable.." #91FFFFmaps found:",player,27,161,226,true)
				for i,map in ipairs(mapTable) do
					outputChatBox("["..i.."]: #64a6ff"..map.name,player,27,161,226,true)
				end
				outputChatBox("[NEXTMAP]: #91FFFFUse /selectmap <number> to select the right map.",player,27,161,226,true)
				setElementData(player,"nextMapList",mapTable)
			end
		end
	end
end
addCommandHandler ("nextmap", setNextMap)

function selectNextMap(player,cmd,pos)
	if(getElementData(player,"bb.room") ~= g_roomID) then return end
	if not (exports.BB_Login:isInGroup(player,"UAG Member")) then return end
	
	if(tonumber(pos) == 0 or pos == nil or pos == false) then
		outputChatBox("[NEXTMAP]: #91FFFFSyntax: /selectmap <number>",player,27,161,226,true)
		return
	end
	
	local mapTable = (getElementData(player,"nextMapList") or -1)
	if(mapTable == -1) then
		outputChatBox("[NEXTMAP]: #91FFFFThere are no maps to select.",player,27,161,226,true)
		return
	end
	
	if(tonumber(pos) > #mapTable) then
		outputChatBox("[NEXTMAP]: #91FFFFPlease specify a correct map.",player,27,161,226,true)
	else
		outputChatBox("[NEXTMAP]: #91FFFFYou selected: #64a6ff"..mapTable[tonumber(pos)].name.."#91FFFF.",player,27,161,226,true)
		g_nextMapName = mapTable[tonumber(pos)].name
		g_forcedMap = mapTable[tonumber(pos)].map
		
		for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
			outputChatBox("[NEXTMAP]: #64a6ff"..getPlayerName(player).." #91FFFFhas set the next map to:",v,27,161,226,true)
			outputChatBox("[NEXTMAP]: #64a6ff"..mapTable[tonumber(pos)].name,v,27,161,226,true)
			triggerClientEvent(v,"setNextMap",getRootElement(),g_nextMapName)
		end
		setElementData(player,"nextMapList",-1)
	end
end
addCommandHandler ("selectmap", selectNextMap)

function table.find(t, ...)
	local args = { ... }
	if #args == 0 then
		for k,v in pairs(t) do
			if v then
				return k
			end
		end
		return false
	end
	
	local value = table.remove(args)
	if value == '[nil]' then
		value = nil
	end
	for k,v in pairs(t) do
		for i,index in ipairs(args) do
			if type(index) == 'function' then
				v = index(v)
			else
				if index == '[last]' then
					index = #v
				end
				v = v[index]
			end
		end
		if v == value then
			return k
		end
	end
	return false
end