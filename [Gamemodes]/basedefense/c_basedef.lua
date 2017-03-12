-- Variables
g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)
local screenX, screenY = guiGetScreenSize()

local g_Spawnpoints = {}
local g_Pickups = {}
local g_VisiblePickups = {}
local g_DeathListRec = {}

local deathListPositions = 10
local plrDeathListPos = -1
local deathListAdded = false

local pickupAngle = 0
local survivorDynY = 0
local wonCamZ = 0
local wonPosX = 0
local wonPosY = 0
local wonPosZ = 0
local wonCY = 0
local wonName = nil

local cdTimer = nil
local heliTimer = nil

local countState = nil
local countTXT = nil

local cImageGO = dxCreateTexture("images/count_go.png")
local cImage1 = dxCreateTexture("images/count_1.png")
local cImage2 = dxCreateTexture("images/count_2.png")
local cImage3 = dxCreateTexture("images/count_3.png")
local imgSurvivor = dxCreateTexture("images/last_survivor.png")

local cMapName = "None"
local nextMapName = "Random"

countImages = {
[0] = cImageGO,
[1] = cImage1,
[2] = cImage2,
[3] = cImage3
}

local g_WaterCraftIDs = table.create({ 539, 460, 417, 447, 472, 473, 493, 595, 484, 430, 453, 452, 446, 454 }, true)

addEventHandler("onClientFilesAreAllDownloaded",g_ResourceRoot,
	function ()
		setBlurLevel(0)
		g_ModelForPickupType = { nitro = 2221, repair = 2222, vehiclechange = 2223 }
		
		engineImportTXD(engineLoadTXD('models/nitro.txd'), 2221)
		engineReplaceModel(engineLoadDFF('models/nitro.dff', 2221), 2221)
		engineSetModelLODDistance(2221, 60 )
		
		engineImportTXD(engineLoadTXD('models/repair.txd'), 2222)
		engineReplaceModel(engineLoadDFF('models/repair.dff', 2222), 2222)
		engineSetModelLODDistance(2222, 60 )
		
		engineImportTXD(engineLoadTXD('models/vehiclechange.txd'), 2223)
		engineReplaceModel(engineLoadDFF('models/vehiclechange.dff', 2223), 2223)
		engineSetModelLODDistance(2223, 60 )
		
		setCameraClip ( true, false )
		setPedCanBeKnockedOffBike(localPlayer, false)
		
		exports.BB_Rooms:loadRoomMap(localPlayer,getElementData(localPlayer,"bb.room"))
	end
)

addEvent("onMapElement",true)
addEventHandler("onMapElement",g_Root,
	function (name,element)
		if(name == "spawnpoint") then
			table.insert(g_Spawnpoints,{
				vehicle = (element.vehicle or 0),
				posX = (element.posX or 0.0),
				posY = (element.posY or 0.0),
				posZ = (element.posZ or 0.0),
				rotX = (element.rotX or 0.0),
				rotY = (element.rotY or 0.0),
				rotZ = (element.rotZ or 0.0)
			})
		end
		if(name == "racepickup") then
			pType = (element.type or "nitro")
			vehicle = (element.vehicle or 0)
			posX = (element.posX or 0.0)
			posY = (element.posY or 0.0)
			posZ = (element.posZ or 0.0)
			respawn = (element.respawn or 0)
			
			if(pType == "nitro") then 
				racePickup = createObject(2221,posX,posY,posZ) 
			end
			if(pType == "repair") then 
				racePickup = createObject(2222,posX,posY,posZ) 
			end
			if(pType == "vehiclechange") then 
				racePickup = createObject(2223,posX,posY,posZ)
			end
			
			setElementCollisionsEnabled(racePickup, false)
			setElementDimension(racePickup,getElementData(localPlayer,"bb.room"))
			colShape = createColSphere(posX,posY,posZ, 3.5)
			
			table.insert(g_Pickups,{
				pType = pType,
				vehicle = vehicle,
				element = racePickup,
				colshape = colShape,
				respawn = respawn
			})
		end
	end
)

addEventHandler('onClientElementStreamIn', g_Root,
	function()
		for _,v in ipairs(g_Pickups) do
			if(v.element == source) then
				table.insert(g_VisiblePickups,{ element = v.element, vehicle = v.vehicle, pType = v.pType })
				break
			end
		end
	end
)



addEventHandler('onClientElementStreamOut', g_Root,
	function()
		for i,v in ipairs(g_VisiblePickups) do
			if(v.element == source) then
				table.remove(g_VisiblePickups,i)
				break
			end
		end
	end
)

function checkWater()
	if(getElementData(localPlayer,"state") ~= "alive") then return end
	if isPedInVehicle(localPlayer) then
		if g_WaterCraftIDs[getElementModel(getPedOccupiedVehicle(localPlayer))] then
			return
		end
		
		local x, y, z = getElementPosition(localPlayer)
        local waterZ = getWaterLevel(x, y, z)
		
		if waterZ and z < waterZ - 0.5 then
			triggerServerEvent("onKillPlayer",localPlayer)
		end
	end
end
setTimer(checkWater,1000,0)

function performSuicide(player)
	if not isPedInVehicle(localPlayer) then return end
	if not isElementFrozen(getPedOccupiedVehicle(localPlayer)) then
		triggerServerEvent("onKillPlayer",localPlayer)
	end
end
addCommandHandler("kill",performSuicide)
bindKey(next(getBoundKeys"enter_exit"), "down", "kill")

function spectatePrevious()
	if (getElementData(localPlayer,"state") ~= "spectating") then return end
	
	triggerServerEvent("onSpectatePrevious",localPlayer)
end
addCommandHandler("spectate previous",spectatePrevious)

function spectateNext()
	if (getElementData(localPlayer,"state") ~= "spectating") then return end
	
	triggerServerEvent("onSpectateNext",localPlayer)
end
addCommandHandler("spectate next",spectateNext)

bindKey("arrow_l", "down", "spectate previous")
bindKey("arrow_r", "down", "spectate next")

function renderStats()
	local state = getElementData(localPlayer,"state")
	if(state == "alive" or state == "spectating") then
		dxDrawText("FPS:",conv(10), screenY-conv(65), conv(50), screenY-conv(20), tocolor(27,161,226,200), conv(1.2), "default-bold")
		dxDrawText(getElementData(localPlayer,"fps"),conv(50), screenY-conv(64), conv(50), screenY-conv(20), tocolor(255,255,255,200), conv(1.1), "default")
		
		dxDrawText("Next Map:",conv(10), screenY-conv(45), conv(50), screenY-conv(20), tocolor(27,161,226,200), conv(1.2), "default-bold")
		dxDrawText(nextMapName,conv(90), screenY-conv(44), conv(50), screenY-conv(20), tocolor(255,255,255,200), conv(1.1), "default")
		
		dxDrawText("Map:",conv(10), screenY-conv(25), conv(50), screenY-conv(20), tocolor(27,161,226,200), conv(1.2), "default-bold")
		dxDrawText(cMapName,conv(50), screenY-conv(24), conv(50), screenY-conv(20), tocolor(255,255,255,200), conv(1.1), "default")
	end
end
addEventHandler('onClientRender', g_Root, renderStats)

addEvent("updateDeathList",true)
addEventHandler("updateDeathList",g_Root,
	function(deathlist)
		local cCount = 1
		
		table.sort(deathlist, function(a,b) return a.pos<b.pos end)
		for _,v in ipairs(deathlist) do
			if(cCount >= deathListPositions) then break end
			
			if(#g_DeathListRec <= deathListPositions) then
				if(cCount == 1 and #g_DeathListRec >= 1) then
					g_DeathListRec[1].pos = v.pos
					g_DeathListRec[1].player = v.player
					g_DeathListRec[1].name = v.name
					g_DeathListRec[1].recX = 0
				elseif(cCount == 1 and #g_DeathListRec == 0) then
					table.insert(g_DeathListRec,cCount,{pos=v.pos,player=v.player,name=v.name,recX=0})
				elseif(cCount > 1 and cCount <= #g_DeathListRec) then
					g_DeathListRec[cCount].pos = v.pos
					g_DeathListRec[cCount].player = v.player
					g_DeathListRec[cCount].name = v.name
				elseif(cCount > #g_DeathListRec) then
					table.insert(g_DeathListRec,cCount,{pos=v.pos,player=v.player,name=v.name,recX=150})
				end
			else
				if(cCount < deathListPositions) then
					g_DeathListRec[cCount].pos = g_DeathListRec[cCount+1].pos
					g_DeathListRec[cCount].player = g_DeathListRec[cCount+1].player
					g_DeathListRec[cCount].name = g_DeathListRec[cCount+1].name
				else
					g_DeathListRec[cCount].pos = v.pos
					g_DeathListRec[cCount].player = v.player
					g_DeathListRec[cCount].name = v.name
				end
			end
			
			if(v.player == localPlayer) then
				plrDeathListPos = v.pos
				deathListAdded = true
			end
			cCount = cCount + 1
		end
	end
)

function renderDeathlist()
	if(#g_DeathListRec == 0) then return end
	
	local recPos = conv(15)+(conv(30)*(deathListPositions/2))
	local fontHeight = dxGetFontHeight(conv(1.2),"default-bold")
	local plrFound = false
	
	for _,v in ipairs(g_DeathListRec) do
		if(v.player == localPlayer) then
			dxDrawRectangle((screenX-v.recX), ((screenY/2)-recPos), conv(200), conv(30), tocolor(0,0,0,200))
			plrFound = true
		else
			dxDrawRectangle((screenX-v.recX), ((screenY/2)-recPos), conv(200), conv(30), tocolor(0,0,0,100))
		end
		dxDrawText(v.pos..". "..v.name,(screenX-(v.recX-conv(10))), ((((screenY/2)-recPos)+conv(15))-(fontHeight/2)), conv(200), conv(30), tocolor(255,255,255,150), conv(1.2), "default-bold","left","top",false,false,false,true)
		
		recPos = recPos - conv(30)
		
		if(v.recX < conv(200)) then
			v.recX = v.recX + conv(2)
		end		
		if(v.recX > conv(200)) then
			v.rexX = conv(200)
		end
	end
	
	if((getElementData(localPlayer,"state") ~= "alive") and (plrFound == false) and (deathListAdded == true)) then
		dxDrawRectangle((screenX-conv(200)), ((screenY/2)+conv(105)), conv(200), conv(30), tocolor(0,0,0,200))
		dxDrawText(plrDeathListPos..". "..getPlayerName(localPlayer),(screenX-(conv(190))), ((((screenY/2)+conv(135))-conv(15))-(fontHeight/2)), conv(200), conv(30), tocolor(255,255,255,150), conv(1.2), "default-bold","left","top",false,false,false,true)
	end
end
addEventHandler('onClientRender', g_Root, renderDeathlist)

function updatePickups()
	local cx, cy, cz = getCameraMatrix()
	
	for i,v in ipairs(g_VisiblePickups) do
	
		if (v.pType == "vehiclechange") then
			local x,y,z = getElementPosition(v.element)
		
			local distance = getDistanceBetweenPoints3D(cx,cy,cz,x,y,z)
			if distance < 60 then
				local sx,sy = getScreenFromWorldPosition (x,y,z+1,0.08)
				if sx then
					if isLineOfSightClear(cx,cy,cz,x,y,z,true, false, false, true, false) then
						local scale = (60/distance)*0.5
						dxDrawText(getVehicleNameFromModel(v.vehicle), sx, sy, sx, sy, tocolor(27,161,226,200), (scale/3.5), "bankgothic", "center", "bottom", false, false, false )
					end
				end
			end
		end
		setElementRotation(v.element,0,0,pickupAngle)
	end
	
	if((pickupAngle + 5) > 360) then
		pickupAngle = 0
	else
		pickupAngle = pickupAngle + 5
	end
end
addEventHandler('onClientRender', g_Root, updatePickups)

function renderLastSurvivor()
	if(survivorDynY < conv(200)) then
		survivorDynY = survivorDynY + 2
		if(survivorDynY > conv(200)) then
			survivorDynY = conv(200)
		end
	end
	dxDrawImage((screenX-(conv(200))), survivorDynY-conv(240), conv(240), conv(240), imgSurvivor, 0)
end

addEvent("onWonScreen",true)
addEventHandler("onWonScreen",g_Root,
	function(plrName,camX,camY,camZ)	
		removeEventHandler('onClientRender', g_Root, renderLastSurvivor)
		
		setCameraMatrix(camX+20,camY,camZ+100,camX,camY,camZ)
		wonPosX = tonumber(camX)
		wonPosY = tonumber(camY)
		wonPosZ = tonumber(camZ)
		
		wonCamZ = tonumber(camZ+100)
		wonName = plrName
		wonCY = conv(200)
		
		setTimer(function()
			fadeCamera(true)
			removeEventHandler('onClientRender', g_Root, moveWonCamera)
			addEventHandler('onClientRender', g_Root, moveWonCamera)
		end,1000,1)
	end
)

function moveWonCamera()
	if(wonCamZ > wonPosZ) then
		wonCamZ = wonCamZ - 1
	end
	if(wonCY > 0) then
		wonCY = wonCY - 2
	end
	if(wonCY < 0) then
		wonCY = 0
	end
	setCameraMatrix(wonPosX+10,wonPosY,wonPosZ+((wonCamZ-wonPosZ)+3),wonPosX,wonPosY,wonPosZ)
	
	dxDrawRectangle(0,((screenY-conv(200))+wonCY),screenX,conv(200),tocolor(0,0,0,150))
	
	local height = dxGetFontHeight(conv(5),"default-bold")
	local width = dxGetTextWidth(removeColorCoding(wonName),conv(5),"default-bold")
	dxDrawText(wonName, ((screenX/2)-(width/2)),(((screenY-conv(125))-(height/2))+wonCY), ((screenX/2)-(width/2)),((screenY-conv(125))-(height/2)), tocolor(255,255,255,255), conv(5), "default-bold","left","top",false,false,false,true) 
	
	local height = dxGetFontHeight(conv(3),"default-bold")
	local width = dxGetTextWidth("Won the map!",conv(3),"default-bold")
	dxDrawText("Won the map!", ((screenX/2)-(width/2)),(((screenY-conv(50))-(height/2))+wonCY), ((screenX/2)-(width/2)),((screenY-conv(50))-(height/2)), tocolor(255,255,255,255), conv(3), "default-bold","left","top",false,false,false,true) 
end

addEvent("onLastSurvivor",true)
addEventHandler("onLastSurvivor",g_Root,
	function()
		survivorDynY = 0
		addEventHandler('onClientRender', g_Root, renderLastSurvivor)
	end
)

addEvent("onMapIsLoaded",true)
addEventHandler("onMapIsLoaded",g_Root,
	function ()
		removeEventHandler('onClientRender', g_Root, moveWonCamera)
		setCameraTarget(localPlayer,localPlayer)
		
		local pID = getElementData(localPlayer,"UAG.pIDroom")
		setCloudsEnabled(false)
		
		if(pID <= #g_Spawnpoints) then
			spawnClientOnPoint(pID)
		elseif(pID <= (#g_Spawnpoints*2)) then
			spawnClientOnPoint(pID-#g_Spawnpoints)
		else
			local pPos = (pID-(#g_Spawnpoints*math.round((pID/#g_Spawnpoints), 0, "floor")))
			spawnClientOnPoint(pPos)
		end
		
		g_DeathListRec = {}
		deathListAdded = false
		
		heliTimer = setTimer(checkHelicopter,500,0)
	end
)

addEvent("setGhostMode",true)
addEventHandler("setGhostMode",g_Root,
	function (aliveTable)
		for i,plr in ipairs(aliveTable) do
			for i,veh in ipairs(getElementsByType("vehicle")) do
				setElementCollidableWith(getPedOccupiedVehicle(plr), veh, false)
				setElementCollidableWith(veh, getPedOccupiedVehicle(plr), false)
			end
		end
	end
)

addEvent("onMapStopping",true)
addEventHandler("onMapStopping",g_Root,
	function ()
		removeEventHandler('onClientRender', g_Root, moveWonCamera)
		for _,v in ipairs(g_Pickups) do
			destroyElement(v.element)
		end

		removeEventHandler('onClientRender', g_Root, renderLastSurvivor)
		triggerServerEvent("destroyPlayerVehicle",localPlayer)
		
		g_Pickups = {}
		g_Spawnpoints = {}
		g_VisiblePickups = {}
		g_DeathListRec = {}
		deathListAdded = false
		
		if(isTimer(cdTimer)) then killTimer(cdTimer) end
		if(isTimer(heliTimer)) then killTimer(heliTimer) end
	end
)

addEvent("setCurrentMap",true)
addEventHandler("setCurrentMap",getRootElement(),
	function (mapname)
		cMapName = mapname
	end
)

addEvent("setNextMap",true)
addEventHandler("setNextMap",getRootElement(),
	function (mapname)
		nextMapName = mapname
	end
)

function vehicleEnter()
	local plrVehicle = getPedOccupiedVehicle(localPlayer)
	
	if(source == localPlayer) then	
		setCameraBehindVehicle(plrVehicle)
	end
end
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),vehicleEnter)

function doCountdown(count)
	if(count >= 1) then
		cdTimer = setTimer(doCountdown,1000,1,(count-1))
		if(count == 3) then
			exports.BB_Maps:closeLoader()
			addEventHandler("onClientRender",getRootElement(),renderCount)
		end
		playSound("audio/count_"..count..".mp3",false)
		countState = count
	else
		countState = 0
		setTimer(function()
			removeEventHandler("onClientRender",getRootElement(),renderCount)
		end,1000,1)
		local goSound = playSound("audio/count_go.mp3",false)
		setSoundVolume(goSound,60)
		cdTimer = nil
	end
end
addEvent("doCountdown",true)
addEventHandler("doCountdown",g_Root,doCountdown)

function renderCount()
	dxDrawImage(((screenX/2)-(conv(270)/2)), ((screenY/2)-(conv(300)/2)), conv(300), conv(300), countImages[countState], 0)
end

addEventHandler("onClientColShapeHit", g_Root,
	function (player, matchingDimension)
		if(player == localPlayer) then
			for _,v in ipairs(g_Pickups) do
				if(v.colshape == source) then
					playSoundFrontEnd(46)
					triggerServerEvent("onRacePickupTrigger",localPlayer,v)
					break
				end
			end
		end
	end
)

addEvent("alignVehicleWithUp",true)
addEventHandler("alignVehicleWithUp",g_Root,
	function ()
		local vehicle = getPedOccupiedVehicle(localPlayer)

		if not vehicle then return end

		local matrix = getElementMatrix(vehicle)
		local Right = Vector3D:new(matrix[1][1], matrix[1][2], matrix[1][3])
		local Fwd	= Vector3D:new(matrix[2][1], matrix[2][2], matrix[2][3])
		local Up	= Vector3D:new(matrix[3][1], matrix[3][2], matrix[3][3])

		local Velocity = Vector3D:new( getElementVelocity( vehicle ) )
		local rz
		if Velocity:Length() > 0.05 and Up.z < 0.001 then
			rz = directionToRotation2D( Velocity.x, Velocity.y)
		else
			rz = directionToRotation2D(Fwd.x, Fwd.y)
		end
		setElementRotation(vehicle, 0, 0, rz)
		
		checkHelicopter()
	end
)

function checkHelicopter()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not isPedInVehicle(localPlayer) then return end
	local vehID = getElementModel(vehicle)
	if vehID == 417 or vehID == 425 or vehID == 447 or vehID == 465 or vehID == 469 or vehID == 487 or vehID == 488 or vehID == 497 or vehID == 501 or vehID == 548 or vehID == 563 then
		setHelicopterRotorSpeed (vehicle, 0.2)
	end
end

function spawnClientOnPoint(pos)
	triggerServerEvent("onMapSpawn",localPlayer,g_Spawnpoints[pos])
end