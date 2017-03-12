--script by
--          aXiX
--Jackob v3

robban = createMarker(-3603.4357, 6014.8681, 271.4790, "corona", 50, 0, 0, 0, 255)
robban2 = createMarker(-3249.8540, 6194.6821, 181.1687, "corona", 10, 0, 0, 0, 255)
robban3 = createMarker(-3161.4714, 6240.0590, 145.7683, "corona", 30, 0, 0, 0, 255)

function MarkerHit (element)
if (element == getLocalPlayer()) then
   if (getElementType(element) == "player") then
	if (isPedInVehicle(element)) then
	
		if (source==robban) then
			setTimer ( kesleltet, 1000, 1, "Hello, World!" )
	    end
		if (source==robban2) then
			createExplosion ( 3202.5566, 6256.3769, 181.4530, 6 )
	    end
		if (source==robban3) then
			createExplosion ( -3088.0419, 6347.5634, 69.6012, 6 )
			createExplosion ( -3110.9238, 6258.5888, 59.6442, 6 )
			createExplosion ( -3045.7851, 6254.9912, 134.2, 6 )
	    end
		
	end
    end
end
end
addEventHandler ( "onClientMarkerHit", getRootElement() ,MarkerHit)

function kesleltet (  )
createExplosion ( -3556.2189941406, 6064.8525390625, 241.17771911621, 6 )
end