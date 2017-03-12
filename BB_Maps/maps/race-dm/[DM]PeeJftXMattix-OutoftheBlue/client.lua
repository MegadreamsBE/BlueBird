Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 
g1 = createMarker(5371.2280273438, 762.43658447266, 0, "corona", 10, 0, 0, 0, 0)
g2 = createMarker(5363.5961914063, 1762.2983398438, 27.848320007324, "corona", 6, 0, 0, 0, 0)
g3 = createMarker(4671.0615234375, 2426.8310546875, 224.1236114502, "cylinder", 8, 0, 0, 0, 0)
t = createMarker(2794.787109375, -2912.4384765625, 28.33510017395, "corona", 20, 0, 0, 0, 0)
t2 = createMarker(1842.404296875, -3311.7080078125, 28.33510017395, "corona", 20, 0, 0, 0, 0)

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == g1 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		--setElementVelocity(vehicle, 0.0, speedy+0.9, speedz+0.95)
	end
	if source == g2 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		--setElementVelocity(vehicle, 0.0, speedy+0.7, speedz+1.1)
	end
        if source == g3 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		--setElementVelocity(vehicle, 1.8, speedy+0.2, speedz+0.1)

	end
	if source == t then
         setElementPosition(vehicle, 2331.275390625, -5013.236328125, 7.5845999717712)
	 setElementRotation(vehicle,0,0,180) 
			fadeCamera ( false, 0, 0, 0, 0)
			setTimer(function() fadeCamera ( true, 2 ) end, 900, 1)
	end
	if source == t2 then
         setElementPosition(vehicle, 2331.275390625, -5013.236328125, 7.5845999717712)
	 setElementRotation(vehicle,0,0,180) 
			fadeCamera ( false, 0, 0, 0, 0)
			setTimer(function() fadeCamera ( true, 2 ) end, 900, 1)
	end


end