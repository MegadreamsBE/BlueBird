speed1 = createMarker(5867.2998046875, -1707.0999755859, 26.60000038147, "corona", 5, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed1 then
            setElementVelocity(vehicle, -2, 0, 1.4)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

------------------m2-------------------

speed2 = createMarker(4240, -1952.6999511719, 2.5, "corona", 15, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed2 then
            setElementVelocity(vehicle, -0.5, 1.5, 1.2)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

------------------m3-------------------

speed3 = createMarker(3752, -1496.4000244141, 102.59999847412, "corona", 3, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed3 then
            setElementVelocity(vehicle, -0.7, 1.7, 1.2)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

------------------m4-------------------

speed4 = createMarker(3505.599609375, -870.69921875, 1, "corona", 20, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed4 then
            setElementVelocity(vehicle, 0.2, 1.1, 0.7)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

------------------m5-------------------

speed5 = createMarker(3538.3000488281, -685.09997558594, 1, "corona", 15, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed5 then
            setElementVelocity(vehicle, 0.2, 2.2, 1.21)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

------------------m6-------------------

speed6 = createMarker(4332.3999023438, 91.599998474121, 140.10000610352, "corona", 10, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed6 then
            setElementVelocity(vehicle, 1, 0, 0.5)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

------------------m7-------------------

speed7 = createMarker(4439.7001953125, 91.599998474121, 140.10000610352, "corona", 10, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed7 then
            setElementVelocity(vehicle, 1, 0, 0.5)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

------------------m8-------------------

speed8 = createMarker(4558.5, 91.599998474121, 140.10000610352, "corona", 10, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed8 then
            setElementVelocity(vehicle, 1, 0, 0.5)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

------------------m9-------------------

speed9 = createMarker(4673, 91.599998474121, 140.10000610352, "corona", 10, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed9 then
            setElementVelocity(vehicle, 0.9, 0, 0.5)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

------------------m10-------------------

speed10 = createMarker(4782.3999023438, 91.599998474121, 140.10000610352, "corona", 10, 1, 1, 1, 1)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed10 then
            setElementVelocity(vehicle, 3, 0, 0.57)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)