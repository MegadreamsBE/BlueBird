Me = getLocalPlayer()
 Root = getRootElement()
 local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution
 
function Main () 
gravityjump1 = createMarker(3258.5, -3329.5, 22.299999237061, "arrow", 6, 0, 0, 0, 0)
 gravityjump2 = createMarker(0, 0, 0, "corona", 6, 0, 0, 0, 0)
 gravityjump3 = createMarker(0, 0, 0, "corona", 6, 0, 0, 0, 0)
 gravityjump4 = createMarker(0, 0, 0, "corona", 6, 0, 0, 0, 0)
 

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
 end
 

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )
 

function MainFunction ( hitPlayer, matchingDimension )
 vehicle = getPedOccupiedVehicle ( hitPlayer )
 if hitPlayer ~= Me then return end
 if source == gravityjump1 then
 speedx, speedy, speedz = getElementVelocity ( vehicle ) 
setElementVelocity(vehicle, -1, speedy+1, speedz+1)
 end
 if source == gravityjump2 then
 speedx, speedy, speedz = getElementVelocity ( vehicle ) 
setElementVelocity(vehicle, 40, speedy+2, speedz+3)
 end
 if source == gravityjump3 then
 speedx, speedy, speedz = getElementVelocity ( vehicle ) 
setElementVelocity(vehicle, -1, speedy-0, speedz+1)
 end
 if source == gravityjump4 then
 speedx, speedy, speedz = getElementVelocity ( vehicle ) 
setElementVelocity(vehicle, -40, speedy-1, speedz+0.5)
 end
 
end
 
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )