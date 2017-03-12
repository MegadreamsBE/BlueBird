Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

-- Jump 1 --

function Main () 
gravityjump2 = createMarker(4916, 7684.0224609375, 
43.8950004577643, "corona", 3, 0, 0, 0, 0)

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == gravityjump2 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, 1.0, speedy-1.0, speedz+0.7)
	end
end


-- Jump 2 --

function Main1 () 
gravityjump1 = createMarker(4892.5, 7684.0224609375, 
43.8950004577643, "corona", 3, 0, 0, 0, 0)

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction2 )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main1 )


function MainFunction2 ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == gravityjump1 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, -1.0, speedy-1.0, speedz+0.7)
	end
end

-- Jump 3 --

function Main12 () 
gravityjump3 = createMarker(3672.7424316406, 5182.1977539063, 
2.2346000671387, "corona", 3, 0, 0, 0, 0)

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction12 )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main12 )


function MainFunction12 ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == gravityjump3 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, 0.0, speedy-2.0, speedz+1.7)
	end
end
