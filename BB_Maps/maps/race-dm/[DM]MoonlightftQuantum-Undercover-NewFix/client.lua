setWaterColor(26, 176, 184, 255)


setCloudsEnabled ( false )
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox ("#8BC2F5[MAP]:  #FFFFFF*Moonlight and *Quantum presents : Undercover", 27, 89, 224, true)
outputChatBox ("#8BC2F5[MAP]:  #FFFFFFPress #8BC2F5'M'#FFFFFF to toggle the music On/Off.", 27, 89, 224, true)
outputChatBox ("#8BC2F5[MAP]:  #FFFFFFGood Luck & Have Fun!", 27, 89, 224, true)


speed1 = createMarker(3197.8991699219, 1543.0100097656, 0.043750464916229, "corona", 6, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed1 then
            setElementVelocity(vehicle, 1, -0.13, 0.8)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)


speed2 = createMarker(3197.8991699219, 1517.9239501953, 0.043750464916229, "corona", 6, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed2 then
            setElementVelocity(vehicle, 1, 0.13, 0.8)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)


speed3 = createMarker(4504.5952148438, 1494.2290039063, -17.149646759033, "corona", 30, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed3 then
            setElementVelocity(vehicle, 1, 0.13, 0.8)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)


speed4 = createMarker(4504.5952148438, 1565.7301025391, -17.149646759033, "corona", 30, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed4 then
            setElementVelocity(vehicle, 1, -0.13, 0.8)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)


speed5 = createMarker(5780.3232421875, 1090.3994140625, -3.2097001075745, "corona", 15, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed5 then
            setElementVelocity(vehicle, 1, 0, 0.5)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)


speed6 = createMarker(7846, 1468.599609375, 80, "corona", 10, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed6 then
            setElementVelocity(vehicle, -0.05, 0, 2.3)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)


speed7 = createMarker(7984.8891601563, 1484.2739257813, 300.25881958008, "corona", 4, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed7 then
            setElementVelocity(vehicle, 0, 0, 3)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)


speed8 = createMarker(7984.8891601563, 1453.9243164063, 300.25881958008, "corona", 4, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed8 then
            setElementVelocity(vehicle, 0, 0, 3)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)


setCloudsEnabled ( false )
function palm ()
palmtxd = engineLoadTXD("gta_tree_palm.txd")
engineImportTXD(palmtxd, 622 )
palmdff = engineLoadDFF('veg_palm03.dff', 0) 
engineReplaceModel(palmdff, 622)  
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )