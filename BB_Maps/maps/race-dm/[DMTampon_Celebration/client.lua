speed = createMarker(4672.4, -181.5, 1086.3, "corona", 5, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed then
            setElementVelocity(vehicle, 1.2, 0, 0)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)



speed2 = createMarker(5058.1, -307.1, 37.9, "corona", 10, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed2 then
            setElementVelocity(vehicle, 1.695, 0, 0.565)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)



speed3 = createMarker(5569.1, -307.1, 0, "corona", 10, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed3 then
            setElementVelocity(vehicle, 1.2, 0, 0)
            setElementRotation(vehicle, 11.25, 0, 270)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)



speed4 = createMarker(5591, -307.1, 20, "corona", 10, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed4 then
            setElementVelocity(vehicle, 0.51, 0, 0.66)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)




marker = createMarker(7179, 306.1, 50.8, "corona", 4, 0, 0, 0, 0)

function gravity(player)
if getElementType(player)=="player" then
if source == marker then
vehicle = getPedOccupiedVehicle(player)
x,y,z = getElementPosition(player)
setVehicleGravityPoint(vehicle, x, y, z+1000, 1)
end
end
end

function setVehicleGravityPoint(targetVehicle, pointX, pointY, pointZ, strength)
if isElement(targetVehicle) and getElementType(targetVehicle)=="vehicle" then
local vehicleX,vehicleY,vehicleZ = getElementPosition(targetVehicle)
local vectorX = vehicleX-pointX
local vectorY = vehicleY-pointY
local vectorZ = vehicleZ-pointZ
local length = (vectorX^2 + vectorY^2 + vectorZ^2)^0.5
local propX = vectorX^2 / length^2
local propY = vectorY^2 / length^2
local propZ = vectorZ^2 / length^2
local finalX = (strength^2 * propX)^0.5
local finalY = (strength^2 * propY)^0.5
local finalZ = (strength^2 * propZ)^0.5
if vectorX > 0 then finalX = finalX * -1 end
if vectorY > 0 then finalY = finalY * -1 end
if vectorZ > 0 then finalZ = finalZ * -1 end
return setVehicleGravity(targetVehicle, finalX, finalY, finalZ)
end
return false
end
addEventHandler("onClientMarkerHit", getRootElement(), gravity) 




marker2 = createMarker(7281.6, 385.8, 517.3, "corona", 10, 0, 0, 0, 0)

function gravity(player)
if getElementType(player)=="player" then
if source == marker2 then
vehicle = getPedOccupiedVehicle(player)
x,y,z = getElementPosition(player)
setVehicleGravityPoint(vehicle, x, y, z-1000, 1)
end
end
end

function setVehicleGravityPoint(targetVehicle, pointX, pointY, pointZ, strength)
if isElement(targetVehicle) and getElementType(targetVehicle)=="vehicle" then
local vehicleX,vehicleY,vehicleZ = getElementPosition(targetVehicle)
local vectorX = vehicleX-pointX
local vectorY = vehicleY-pointY
local vectorZ = vehicleZ-pointZ
local length = (vectorX^2 + vectorY^2 + vectorZ^2)^0.5
local propX = vectorX^2 / length^2
local propY = vectorY^2 / length^2
local propZ = vectorZ^2 / length^2
local finalX = (strength^2 * propX)^0.5
local finalY = (strength^2 * propY)^0.5
local finalZ = (strength^2 * propZ)^0.5
if vectorX > 0 then finalX = finalX * -1 end
if vectorY > 0 then finalY = finalY * -1 end
if vectorZ > 0 then finalZ = finalZ * -1 end
return setVehicleGravity(targetVehicle, finalX, finalY, finalZ)
end
return false
end
addEventHandler("onClientMarkerHit", getRootElement(), gravity) 



gMe1 = getLocalPlayer()


function gravity1()
marker3 = createMarker(7281.6, 342.3, 76.5, "corona", 1, 0, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker3 then
setGameSpeed( 0.5 )
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )




gMe1 = getLocalPlayer()


function gravity1()
marker4 = createMarker(7281.6, 342.3, 490.6, "corona", 10, 0, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker4 then
setGameSpeed( 1 )
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )



speed5 = createMarker(7281.6, 342.3, 490.6, "corona", 10, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed5 then
            setElementVelocity(vehicle, 0, 0, 1)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)



speed6 = createMarker(7281.6, 411.9, 56.5, "corona", 10, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed6 then
            setElementVelocity(vehicle, 0, 0.42, 0.42)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)




gMe1 = getLocalPlayer()


function gravity1()
marker5 = createMarker(3815.6, 0, 1237.3, "corona", 6, 0, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker5 then
setGameSpeed( 0.25 )
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )




gMe1 = getLocalPlayer()


function gravity1()
marker6 = createMarker(3841.5, -0.2, 1208.5, "corona", 11, 0, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker6 then
setGameSpeed( 1 )
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )



speed7 = createMarker(6989.4, 3774.1, 33.1, "corona", 2, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed7 then
            setElementVelocity(vehicle, 0, 1.2, 0)
            setElementRotation(vehicle, 0, 0, 0)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)




gMe1 = getLocalPlayer()


function gravity1()
marker7 = createMarker(6989.4, 3774.1, 33.1, "corona", 2, 0, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker7 then
setGameSpeed( 0.333333333334 )
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )




function Tutorialforteleboostscript ()
tutorialmarker1 = createMarker(6989.4, 3933.5, 32.8, "corona", 10, 0, 0, 0, 0)
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Tutorialforteleboostscript )

function TutorialMarkerHit  ( hitPlayer, matchingDimension )
   if hitPlayer ~= getLocalPlayer() then 
   return 
   end
   if source == tutorialmarker1 then
    tutorialvehicleowns = getPedOccupiedVehicle(hitPlayer)
	setElementRotation ( tutorialvehicleowns, 0, 0, 0)
    setElementPosition ( tutorialvehicleowns, 1544.58, -1356.375, 335)

end
if source == tutorialmarker2 then
 tutorialvehicleowns = getPedOccupiedVehicle(hitPlayer)
end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), TutorialMarkerHit )




gMe1 = getLocalPlayer()


function gravity1()
marker8 = createMarker(6989.4, 3830.3, 41.1, "corona", 4, 0, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker8 then
setGameSpeed( 1 )
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )