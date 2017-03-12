Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 
g1 = createMarker(5242.4702734375, -1649.5922851563, 10.423696517944, "ring", 7, 0, 0, 0, 0)
g2 = createMarker(5242.4702734375, -1286.8038330078, 10.423696517944, "ring", 7, 0, 0, 0, 0)
g3 = createMarker(6954.3452148438, -764.9052734375, 126.023696517944, "corona", 10, 0, 0, 0, 0)

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == g1 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, 0, speedy+0.78, speedz+1.06)
	end
	if source == g2 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, 0, speedy-0.78, speedz+1.06)
	end
	if source == g3 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, -0.25, speedy-0.0, speedz+4)
	end
end

function ClientStarted ()
setWaterColor( 255 , 250 , 250 , 255 )
setSkyGradient( 83 , 134 , 139 , 93 , 104 , 205 )
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )