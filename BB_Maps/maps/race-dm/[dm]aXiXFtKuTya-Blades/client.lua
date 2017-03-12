jump = createMarker(5916.8994140625, -1723.7998046875, 113.30000305176, "arrow", 5, 24, 102, 230, 255)
jump2 = createMarker(5944.3994140625, -2391.099609375, 95.5, "arrow", 5, 24, 102, 230, 255)
jump3 = createMarker(8160.228515625, -1671.3038330078, 15.047927856445, "arrow", 5, 24, 102, 230, 255)
jump4 = createMarker(8376.66015625, -1457.9211425781, 5.6935758590698, "arrow", 5, 24, 102, 230, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
   if (getElementType(element) == "player") then
	if (isPedInVehicle(element)) then
		if (source==jump) then
			local vehicle = getPedOccupiedVehicle(element)
            setElementVelocity(vehicle, 1, -1, 1.075)
	    end
		if (source==jump2) then
			local vehicle = getPedOccupiedVehicle(element)
            setElementVelocity(vehicle, 1, 1, 1.01)
	    end
		if (source==jump3) then
			local vehicle = getPedOccupiedVehicle(element)
            setElementVelocity(vehicle, 1, 1, 1.01)
	    end		
		if (source==jump4) then
			local vehicle = getPedOccupiedVehicle(element)
            setElementVelocity(vehicle, -2, -2, 1.5)
	    end			
	end
    end
end
end
addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)