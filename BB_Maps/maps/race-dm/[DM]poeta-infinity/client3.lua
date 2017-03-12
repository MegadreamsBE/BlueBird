Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 
gravityjump1 = createMarker(0, -1411.0323486328, 0, "corona", 6, 0, 0, 0, 0)
gravityjump2 = createMarker(8087.98046875, -1411.0323486328, 60.91056060791, "corona", 6, 0, 0, 0, 0)


addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == gravityjump1 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, 1.25, speedy+0.5, speedz+0.8)
	end
	if source == gravityjump2 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, 1.25, speedy-0.5, speedz+0.8)
	end

end

function ClientStarted ()
setWaterColor( 0 , 250 , 245 , 255 ) -- RGB colors
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )