Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 
gravityjump1 = createMarker(5367.0712890625, -535.02850341797, 3.0084414482117, "corona", 5, 1, 1, 1, 1)

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == gravityjump1 then
		speedx, speedy, speedz = getElementVelocity ( vehicle ) 
		setElementVelocity(vehicle, 0.0, speedy-0.0, speedz+0.76)
	end
end

speed = createMarker(5367.0712890625, -535.02850341797, 3.0084414482117, "corona", 15, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed then
            setElementVelocity(vehicle, 0, 0, 2.6)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

speed1 = createMarker(4226.6000976563, 487.70001220703, 2.5, "corona", 15, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed1 then
            setElementVelocity(vehicle, 0, 0.2, 1)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

speed2 = createMarker(4252.2998046875, 1402.19921875, 26.10000038147, "corona", 15, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed2 then
            setElementVelocity(vehicle, 0, 1, 1.3)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)