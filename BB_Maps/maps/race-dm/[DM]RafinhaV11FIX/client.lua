Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 
g1 = createMarker(5371.2280273438, 762.43658447266, 0, "corona", 10, 0, 0, 0, 0)
g2 = createMarker(5363.5961914063, 1762.2983398438, 27.848320007324, "corona", 6, 0, 0, 0, 0)
g3 = createMarker(4671.0615234375, 2426.8310546875, 224.1236114502, "cylinder", 8, 0, 0, 0, 0)
t = createMarker(4418.54296875, 634.67999267578, 1.5758868455887, "corona", 9, 0, 0, 0, 0)
t2 = createMarker(7770.6552734375, 2061.1259765625, 1.1102600097656, "ring", 8, 0, 0, 0, 0)

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == g1 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, 0.0, speedy+0.9, speedz+0.95)
	end
	if source == g2 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, 0.0, speedy+0.7, speedz+1.1)
	end
        if source == g3 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, 1.8, speedy+0.2, speedz+0.1)

	end
	if source == t then
         setElementPosition(vehicle, 5132.6206054688, 610.1796875, 434.11361694336)
	 setElementRotation(vehicle,0,0,270) 
			fadeCamera ( false, 0, 0, 0, 0)
			setTimer(function() fadeCamera ( true, 2 ) end, 750, 1)
	end
	if source == t2 then
         setElementPosition(vehicle, 4941.83984375, 1588.6887207031, 358.59237670898)
	 setElementRotation(vehicle,0,0,0) 
			fadeCamera ( false, 0, 0, 0, 0)
			setTimer(function() fadeCamera ( true, 2 ) end, 900, 1)
	end


end


function ClientStarted ()
setWaterColor( 255, 255, 0 )
setSkyGradient( 255 , 255 , 0 , 156, 156 , 156 )
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )