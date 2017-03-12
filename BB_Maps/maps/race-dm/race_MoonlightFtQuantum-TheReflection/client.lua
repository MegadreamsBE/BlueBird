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
outputChatBox ("#7A02BF[MAP]:  #FFFFFFMoonlight and Quantum presents : The Reflection", 27, 89, 224, true)
outputChatBox ("#7A02BF[MUSIC]:  #FFFFFFPress #7A02BF'M'#FFFFFF to toggle the music On/Off.", 27, 89, 224, true)
outputChatBox ("#7A02BF[NOTICE]:  #FFFFFFGood Luck & Have Fun!", 27, 89, 224, true)


addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
speedmarker1 = createMarker(1632.6082763672, -7829.7529296875, 135.49397277832, "corona", 3.5, 0, 0, 0, 0) 

end)
function MarkerHit (element)
if (element == getLocalPlayer()) then
if (source == speedmarker1) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
local vehicle = getPedOccupiedVehicle(element)
local velx, vely, velz = getElementVelocity(vehicle)
local newx, newy, newz = velx*1, vely*1, velz*1
setElementVelocity(vehicle, newx, newy, newz)
end
end
end
end
end
addEventHandler("onClientMarkerHit", getRootElement(), MarkerHit)


speed1 = createMarker(1756.6496582031, -7155.6713867188, 104.8716583252, "corona", 5, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed1 then
            setElementVelocity(vehicle, 1, 0, 0.8)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)


speed2 = createMarker(1872.0067138672, -7156.2197265625, 136.20166015625, "corona", 10, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed2 then
            setElementVelocity(vehicle, 1.5, 0, 0.8)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)


speed3 = createMarker(2103.3327636719, -7155.5600585938, 149.0779876709, "corona", 10, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == speed3 then
            setElementVelocity(vehicle, 1.5, 0, 0.8)
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)