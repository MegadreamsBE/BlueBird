Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 
gravityjump1 = createMarker(1355,-4428,0.5, "corona", 10, 0, 0, 0, 0)

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == gravityjump1 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle,-0.11,-2.3,1.88)
	end
end


speed = createMarker(445,-4428,0.5, "corona", 10, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed then
            setElementVelocity(vehicle,0.11,-2.3,1.88)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

speed1 = createMarker(400,-6945.8999023438,78.199996948242, "corona", 3, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed1 then
            setElementVelocity(vehicle,3,0,1)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

speed2 = createMarker(355,-4428,0.5, "corona", 10, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed2 then
            setElementVelocity(vehicle,-0.11,-2.3,1.88)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)