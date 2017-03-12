------------------------------------
-- Idiot stop to edit my client.lua
------------------------------------


-- Marker A to B
-- Get UP + Forward (A)
gMe = getLocalPlayer()
markerA = createMarker(-5186, 1602, 74, "corona", 6, 255, 0, 0, 0)

function MarkerHitA(hitPlayer)
   if hitPlayer ~= gMe then return end
   vehicle = getPedOccupiedVehicle(hitPlayer)
   if source == markerA then
		setElementVelocity(vehicle, -0.35, 0, 1.7)

   end
end
addEventHandler("onClientMarkerHit", getRootElement(), MarkerHitA)


-- Get DOWN + Forward (B)
gMe = getLocalPlayer()
markerB = createMarker(-5250, 1602, 232, "corona", 6, 0, 0, 0, 0)

function MarkerHitB(hitPlayer)
   if hitPlayer ~= gMe then return end
   vehicle = getPedOccupiedVehicle(hitPlayer)
   if source == markerB then
		setElementVelocity(vehicle, -0.7, 0, 0.05)
   end
end
addEventHandler("onClientMarkerHit", getRootElement(), MarkerHitB)




-- Push leftside
gMe = getLocalPlayer()
speed = createMarker(-7208.5, 1594.8, 0, "corona", 6, 0, 0, 0, 0)

function MarkerHitspeed(hitPlayer)
   if hitPlayer ~= gMe then return end
   vehicle = getPedOccupiedVehicle(hitPlayer)
   if source == speed then
      setElementVelocity(vehicle, -0.7, -0.75, 1.8)
   end
end
addEventHandler("onClientMarkerHit", getRootElement(), MarkerHitspeed)


-- Push leftright
gMe = getLocalPlayer()
speedII = createMarker(-7208.5, 1609.2, 0, "corona", 6, 0, 0, 0, 0)

function MarkerHitspeedII(hitPlayer)
   if hitPlayer ~= gMe then return end
   vehicle = getPedOccupiedVehicle(hitPlayer)
   if source == speedII then
      setElementVelocity(vehicle, -0.7, 0.75, 1.8)
   end
end
addEventHandler("onClientMarkerHit", getRootElement(), MarkerHitspeedII)


-- END PART
-- LEFT
gMe = getLocalPlayer()
endleft = createMarker(-8060, 1596.19921875, 130, "corona", 9, 0, 0, 0, 0)

function MarkerHitendleft(hitPlayer)
   if hitPlayer ~= gMe then return end
   vehicle = getPedOccupiedVehicle(hitPlayer)
   if source == endleft then
      setElementVelocity(vehicle, 1.3, 0, 0.4)
   end
end
addEventHandler("onClientMarkerHit", getRootElement(), MarkerHitendleft)


-- RIGHT
gMe = getLocalPlayer()
endright = createMarker(-8060, 1607.7998046875, 130, "corona", 9, 0, 0, 0, 0)

function MarkerHitendright(hitPlayer)
   if hitPlayer ~= gMe then return end
   vehicle = getPedOccupiedVehicle(hitPlayer)
   if source == endright then
      setElementVelocity(vehicle, 1.3, 0, 0.4)
   end
end
addEventHandler("onClientMarkerHit", getRootElement(), MarkerHitendright)

