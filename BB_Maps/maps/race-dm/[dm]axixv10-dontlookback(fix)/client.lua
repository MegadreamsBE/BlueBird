jump = createMarker(4129, -3166.7998046875, 115, "arrow", 3, 24, 102, 230, 255)
stop = createMarker(4132.5, -3589, 150, "arrow", 3, 24, 102, 230, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
   if (getElementType(element) == "player") then
	if (isPedInVehicle(element)) then
		if (source==jump) then
			local vehicle = getPedOccupiedVehicle(element)
            setElementVelocity(vehicle, 0, 1, 1)
	    end
		if (source==stop) then
			local vehicle = getPedOccupiedVehicle(element)
            setElementVelocity(vehicle, 0, 0, 0)
	    end
	end
    end
end
end
addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)