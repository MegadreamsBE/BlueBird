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

addEvent("onMapSpawn",true)
addEventHandler("onMapSpawn",g_Root,
	function(spawn)
		if(getElementData(source,"bb.room") ~= g_roomID) then return end
		spawnPlayer(source, 0.0, 0.0, 0.0, 0.0, 0, 0)
		setCameraTarget(source,source)
		
		local roomInfo = exports.BB_Rooms:getRoomInformation(g_roomID)
		triggerClientEvent(source,"setCurrentMap",getRootElement(),roomInfo.mapName)
		triggerClientEvent(source,"setNextMap",getRootElement(),g_nextMapName)
		triggerClientEvent(source,"updateDeathList",getRootElement(),g_Deathlist)
		
		if(mapState == "running") then
			setElementData(source,"state","spectating")
			setTimer (function(player)
				goSpectating(player)
				fadeCamera(player,true)
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
					triggerClientEvent(v,"setGhostMode",getRootElement(),getAlivePlayers())
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
		local plrVehicle = getPedOccupiedVehicle(source)
		if(pickup.pType == "nitro") then
			addVehicleUpgrade(plrVehicle, 1010)
		end
		if(pickup.pType == "repair") then
			fixVehicle(plrVehicle)
			setVehicleWheelStates(plrVehicle,0,0,0,0)
			for i=0,5 do
				setVehicleDoorOpenRatio(plrVehicle, i, 0)
			end
		end
		if(pickup.pType == "vehiclechange") then
			if(getElementModel(plrVehicle) ~= pickup.vehicle) then
				setElementModel(plrVehicle,pickup.vehicle)
				
				triggerClientEvent(source,"alignVehicleWithUp",getRootElement())
			end
		end
	end
)

addEvent("onKillPlayer",true)
addEventHandler("onKillPlayer",g_Root,
	function()
		fadeCamera(source,true)
		killPed(source)
	end
)

function goSpectating(player)
	if (getElementData(player, "bb.room") ~= g_roomID) then return end
	local aliveTable = getAlivePlayers()
	
	local aliveSeed = 0
	if(#aliveTable > 0) then
		aliveSeed = math.random(1,#aliveTable)
	end
	
	fadeCamera(player,true)
	setElementData(player,"state","spectating")
	if(#aliveTable <= 0) then 
		setElementData(player,"spectating",-1)
	else
		setElementData(player,"spectating",aliveTable[aliveSeed])
		setCameraTarget(player,aliveTable[aliveSeed])
	end
	setElementDimension(player,getElementData(player,"bb.room"))
	
	triggerClientEvent(player,"setGhostMode",getRootElement(),aliveTable)
end

addEvent("onSpectatePrevious",true)
addEventHandler("onSpectatePrevious",g_Root,
	function()
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

addEventHandler ( "onPlayerWasted", getRootElement(),
	function()
		if(getElementData(source,"bb.room") ~= g_roomID) then return end
		if (mapState ~= "running") then return end
		if (getElementData(source,"state") ~= "alive") then return end	
		
		setElementData(source,"state","dead")
		spawnPlayer(source, 0.0, 0.0, 0.0, 0.0, 0, 0)
		
		local x,y,z = getElementPosition(source)
		setCameraMatrix(source,x,y+10,z+20,x,y+10,z+20)
		
		setElementHealth(source,100)
		setElementPosition(source,0,0,3)
		setElementPosition(getElementData(source,"UAG.vehicle"),0,0,3)
		
		goSpectating(source)
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

addEventHandler ( "onPlayerQuit", getRootElement(),
	function()
		if(getElementData(source,"bb.room") ~= g_roomID) then return end
		if (mapState ~= "running") then return end
		
		local plrTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
		for _,v in ipairs(plrTable) do
			if((getElementData(v,"state") ~= "alive") and getElementData(v,"spectating") == source) then
				goSpectating(v)
			end
		end
		
		checkSurvivors(source)
		addDeathlist(source,getPlayerName(source))
	end
)

function addDeathlist(player,playerName)
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

function doNextMap()
	mapStops()
	g_currentMap = exports.BB_Maps:loadRandomMap(g_roomID,g_mapFolders,g_forcedMap)
	playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
	for _,plr in ipairs(playerTable) do
		setElementData(plr,"state","loading")
		roomInfo = exports.BB_Rooms:getRoomInformation(g_roomID)
		exports.BB_Maps:loadMapForPlayer(plr,g_roomID,roomInfo.mapFolder,roomInfo.map)
	end
	mapStarts()
end

function checkSurvivors(player)
	local aliveTable = getAlivePlayers()
	if(#aliveTable == 1 and mapState == "running") then
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
	if(#aliveTable == 0 and mapState == "running") then		
		for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
			fadeCamera(v,false)
		end
		
		local plrVehicle = getElementData(player,"UAG.vehicle")
		setElementPosition(plrVehicle,getElementData(player,"UAG.spawnPosX"),getElementData(player,"UAG.spawnPosY"),getElementData(player,"UAG.spawnPosZ"))
		setElementRotation(plrVehicle,getElementData(player,"UAG.spawnRotX"),getElementData(player,"UAG.spawnRotY"),getElementData(player,"UAG.spawnRotZ"))
		setElementFrozen(plrVehicle,true)
		fixVehicle(plrVehicle)
		
		setVehicleWheelStates(plrVehicle,0,0,0,0)
		for i=0,5 do
			setVehicleDoorOpenRatio(plrVehicle, i, 0)
		end
		
		setTimer(function()
			for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(g_roomID)) do
				warpPedIntoVehicle(player,plrVehicle)
				setElementData(plrVehicle,"UAG.WonVehicle",true)
				triggerClientEvent(v,"onWonScreen",getRootElement(),getPlayerName(player),getElementData(player,"UAG.spawnPosX"),getElementData(player,"UAG.spawnPosY"),getElementData(player,"UAG.spawnPosZ"))
			end
		end,1000,1)
		
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
	
	for _,plr in ipairs(playerTable) do
		triggerClientEvent(plr,"doCountdown",getRootElement(),3)
	end
end

function unfreezeCars()
	playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
	mapState = "running"
	
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
	mapState = "unloading"
	g_currentMap = -1
	setTimer (function()
		for _,v in ipairs(getElementsByType("vehicle")) do
			if(getElementDimension(v) == g_roomID) then
				destroyElement(v)
			end
		end
	end, 200, 1)
		
	g_Vehicles = {}
	if isTimer(cdTimer) then
		killTimer(cdTimer)
		killTimer(cdTimeOutTimer)
	end
	
	g_Deathlist = {}
	lastDeathPos = -1
end

function mapStarts()
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

function randomMap(player)
	if(getElementData(player,"bb.room") ~= g_roomID) then return end
	if not (exports.BB_Login:isInGroup(player,"UAG Member")) then return end
	
	mapStops()
	g_currentMap = exports.BB_Maps:loadRandomMap(g_roomID,g_mapFolders,g_forcedMap)
	playerTable = exports.BB_Rooms:getPlayersInRoom(g_roomID)
	for _,plr in ipairs(playerTable) do
		setElementData(plr,"state","loading")
		roomInfo = exports.BB_Rooms:getRoomInformation(g_roomID)
		exports.BB_Maps:loadMapForPlayer(plr,g_roomID,roomInfo.mapFolder,roomInfo.map)
	end
	mapStarts()
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