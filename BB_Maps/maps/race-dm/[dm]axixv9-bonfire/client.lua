pushmaked = createMarker(3059.5, -2532.5, 126.90000152588, "arrow", 5, 24, 102, 230, 255)
pushmaked2 = createMarker(3076.599609375, -2146.7998046875, 126.90000152588, "arrow", 5, 24, 102, 230, 255)
wallridepush = createMarker(3909, -3165.69921875, 25.89999961853, "arrow", 5, 24, 102, 230, 255)
wallridepush2 = createMarker(3183.5, -3186.3999023438, 15.800000190735, "arrow", 3, 24, 102, 230, 255)
endpush = createMarker(2690.6999511719, -3135.6000976563, 3.7000000476837, "arrow", 25, 24, 102, 230, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
   if (getElementType(element) == "player") then
	if (isPedInVehicle(element)) then
		if (source==pushmaked) then
			local vehicle = getPedOccupiedVehicle(element)
            setElementVelocity(vehicle, 0.5, 0.5, 2)
	    end
		if (source==pushmaked2) then
			local vehicle = getPedOccupiedVehicle(element)
            setElementVelocity(vehicle, 0.5, -0.5, 2)
	    end
		if (source==wallridepush) then
			local vehicle = getPedOccupiedVehicle(element)
            setElementVelocity(vehicle, 2, -1, 1)
	    end
		if (source==wallridepush2) then
			local vehicle = getPedOccupiedVehicle(element)
			speedx, speedy, speedz = getElementVelocity ( vehicle ) 
            setElementVelocity(vehicle, speedx, speedy-0.5, speedz+1.5)
	    end
		if (source==endpush) then
			local vehicle = getPedOccupiedVehicle(element)
			speedx, speedy, speedz = getElementVelocity ( vehicle ) 
            setElementVelocity(vehicle, speedx-4, speedy, speedz+4)
	    end
	end
    end
end
end
addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)