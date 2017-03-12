Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 
gravityjump1 = createMarker(3763.1127929688, -1701.9271240234, 7.7384572029114, "corona", 6, 0, 0, 0, 0)
gravityjump2 = createMarker(3763.1127929688, -1788.2172851563, 7.7384572029114, "corona", 6, 0, 0, 0, 0)


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
setWaterColor( 255 , 250 , 250 , 255 ) -- RGB colors
setSkyGradient( 83 , 134 , 139 , 93 , 104 , 205 ) -- 1st RGB colors top sky, 2nd RGB colors bottom sky
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )