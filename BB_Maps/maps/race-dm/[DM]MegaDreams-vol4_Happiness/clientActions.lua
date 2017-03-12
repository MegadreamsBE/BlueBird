local gatesOpen = false
local gateMarker = false
local submarineTrigger = false
local vehicleTurned = false

addEventHandler('onClientResourceStart', resourceRoot, 
function() 
	gatesLeft = {}
	gatesRight = {}
	vehicleFences = {}
	
	vehicleMarker = createMarker(2329.0,-3783.6999511719,-1.3999999761581,"cylinder", 3,8,246,126,100)
	teleportMarker = createMarker(2329.0,-3784.1000976563,11.300000190735,"corona", 6,19,235,166,100)
	
	gateMarker0 = createMarker(2366,-4651.53,42.0,"corona", 10,255,255,255,0)
	gateMarker1 = createMarker(2366,-4606.6000976563,7.1999998092651,"corona", 10,255,255,255,0)

	local vehicleFence = createObject (970, 2334.3999023438,-3731.5,1.6000000238419,0.0,0.0,0.0) table.insert(vehicleFences, vehicleFence)
	local vehicleFence = createObject (970, 2329.3999023438,-3731.5,1.6000000238419,0.0,0.0,0.0) table.insert(vehicleFences, vehicleFence)
	local vehicleFence = createObject (970, 2324.3000488281,-3731.5,1.6000000238419,0.0,0.0,0.0) table.insert(vehicleFences, vehicleFence)
	local vehicleFence = createObject (970, 2324.3999023438,-3843,1.6000000238419,0.0,0.0,0.0) table.insert(vehicleFences, vehicleFence)
	local vehicleFence = createObject (970, 2329.3999023438,-3843,1.6000000238419,0.0,0.0,0.0) table.insert(vehicleFences, vehicleFence)
	local vehicleFence = createObject (970, 2334.3999023438,-3843,1.6000000238419,0.0,0.0,0.0) table.insert(vehicleFences, vehicleFence)
	
	local gateLeft = createObject (3458, 2345.8000488281,-4512.6000976563,9.6000003814697,90.0,0.0,0.0) table.insert(gatesLeft, gateLeft)
	local gateLeft = createObject (3458, 2345.8000488281,-4512.6000976563,14.699999809265,90.0,0.0,0.0) table.insert(gatesLeft, gateLeft)
	local gateLeft = createObject (3458, 2345.8000488281,-4512.6000976563,19.8,90.0,0.0,0.0) table.insert(gatesLeft, gateLeft)
	local gateLeft = createObject (3458, 2345.8000488281,-4512.6000976563,24.9,90.0,0.0,0.0) table.insert(gatesLeft, gateLeft)
	local gateRight = createObject (3458, 2386.1000976563,-4512.6000976563,9.6000003814697,90.0,0.0,0.0) table.insert(gatesRight, gateRight)
	local gateRight = createObject (3458, 2386.1000976563,-4512.6000976563,14.699999809265,90.0,0.0,0.0) table.insert(gatesRight, gateRight)
	local gateRight = createObject (3458, 2386.1000976563,-4512.6000976563,19.8,90.0,0.0,0.0) table.insert(gatesRight, gateRight)
	local gateRight = createObject (3458, 2386.1000976563,-4512.6000976563,24.9,90.0,0.0,0.0) table.insert(gatesRight, gateRight)
	
	subMarineMarker = createMarker(2395.1999511719,-4063.3000488281,2.5,"corona", 20,255,255,255,0)
	subMarine = createObject (9958, 2484.8999023438,-4147.2998046875,-10.39999961853,0.0,0.0,180.0)
	
	markerTurn0 = createMarker(2717.8999023438,-6835.1000976563,25.39999961853,"corona", 8,0,255,0,255)
	markerTurn1 = createMarker(2717.8999023438, -7197.8999023438, 25.39999961853,"corona", 8,0,255,0,255)
	
	addEventHandler ( "onClientMarkerHit", getRootElement(), onClientHitMarker)
	end 
)

function onClientHitMarker(hitPlayer, matchingDimension)
	if source == vehicleMarker and hitPlayer == getLocalPlayer() and gatesOpen == false then
		for i=1, #vehicleFences do
			local objX, objY, objZ = getElementPosition(vehicleFences[i])
			moveObject (vehicleFences[i], 2000, objX, objY, objZ-2)
		end
		
		outputChatBox("#64a6ffMegaDreams: #00FF00[#FFFFFFI opened the gates for you, good luck!#00FF00]",255,255,255,true);
		gatesOpen = true
	end
	
	if source == teleportMarker and hitPlayer == getLocalPlayer() and gatesOpen == true then
		local plrVehicle = getPedOccupiedVehicle (hitPlayer)
		setElementPosition(plrVehicle, 2365.8000488281, -4517.1000976563, 8.1000003814697)
		setElementRotation(plrVehicle,0,0,180) 
		fadeCamera ( false, 0, 0, 0, 0)
		setTimer(function() fadeCamera ( true, 2 ) end, 1000, 1)
	end
	
	if source == gateMarker0 and hitPlayer == getLocalPlayer() then
		gateMarker = true
	end
	if source == gateMarker1 and hitPlayer == getLocalPlayer() and gateMarker == true then
		for i=1, #gatesRight do
			local objX, objY, objZ = getElementPosition(gatesLeft[i])
			moveObject (gatesLeft[i], 5000, objX-20, objY, objZ)
		end
		for i=1, #gatesRight do
			local objX, objY, objZ = getElementPosition(gatesRight[i])
			moveObject (gatesRight[i], 5000, objX+20, objY, objZ)
		end
	end
	
	if source == subMarineMarker and hitPlayer == getLocalPlayer() and submarineTrigger == false then
		local objX, objY, objZ = getElementPosition(subMarine)
		moveObject (subMarine, 2000, objX, objY+200, objZ)
	end
	
	if source == markerTurn0 and hitPlayer == getLocalPlayer() then
		if vehicleTurned == true then
			local plrVehicle = getPedOccupiedVehicle (hitPlayer)
			local x,y,z = getElementVelocity(plrVehicle)
			setElementVelocity(plrVehicle,x,y,0.7)
			return
		end
		local plrVehicle = getPedOccupiedVehicle (hitPlayer)
		local x,y,z = getElementVelocity(plrVehicle)
		setElementVelocity(plrVehicle,-x,-y,-z)
		setElementRotation(plrVehicle,0,0,180)
		vehicleTurned = true
	end
	
	if source == markerTurn1 and hitPlayer == getLocalPlayer() then
		if vehicleTurned == true then
			local plrVehicle = getPedOccupiedVehicle (hitPlayer)
			local x,y,z = getElementVelocity(plrVehicle)
			setElementVelocity(plrVehicle,x,y,0.7)
			return
		end
		local plrVehicle = getPedOccupiedVehicle (hitPlayer)
		local x,y,z = getElementVelocity(plrVehicle)
		setElementVelocity(plrVehicle,-x,-y,-z)
		setElementRotation(plrVehicle,0,0,0)
		vehicleTurned = true
	end
end