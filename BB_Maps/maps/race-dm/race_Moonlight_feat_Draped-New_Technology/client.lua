setCloudsEnabled ( false )
function palm ()
palmtxd = engineLoadTXD("gta_tree_palm.txd")
engineImportTXD(palmtxd, 622 )
palmdff = engineLoadDFF('veg_palm03.dff', 0) 
engineReplaceModel(palmdff, 622)  
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )

speed1 = createMarker(3054.9128417969, -1652.2847900391, 11.23810005188, "corona", 7, 0, 0, 0, 0)
speed2 = createMarker(3054.912109375, -1698.9925537109, 11.23810005188, "corona", 7, 0, 0, 0, 0)
speed3 = createMarker(3195.7700195313, -1752.1829833984, 12.197999954224, "corona", 5, 0, 0, 0, 0)
speed4 = createMarker(3195.7700195313, -1599.3979492188, 12.197999954224, "corona", 5, 0, 0, 0, 0)
speed5 = createMarker(3874.7077636719, 1587.2044677734, 52.641098022461, "corona", 20, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed1 then
            setElementVelocity(vehicle, 0, -0.5, 0.5)
        end
		if source == speed2 then
            setElementVelocity(vehicle, 0, 0.5, 0.5)
        end
		if source == speed3 then
			if getElementModel(vehicle) == 411 then
				setElementVelocity(vehicle, 1.5, 0, 0.8)
			else
				blowVehicle(vehicle)
			end
        end
		if source == speed4 then
			if getElementModel(vehicle) == 411 then
				setElementVelocity(vehicle, 1.5, 0, 0.8)
			else
				blowVehicle(vehicle)
			end
        end
		if source == speed5 then
            setElementVelocity(vehicle, -2, 0, 1)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

function changeWater()
  setWaterColor(60, 100, 196, 255)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), changeWater)

function changeSky()
   setSkyGradient(60, 100, 196, 136, 170, 212)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), changeSky)
