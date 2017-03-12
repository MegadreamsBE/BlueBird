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
outputChatBox ("#7A02BF*Moonlight and Quantum #FFFFFFpresents : Boxville Trip!", 27, 89, 224, true)
outputChatBox ("#7A02BFPress 'M'#FFFFFF to toggle the music #7A02BFOn/Off.", 27, 89, 224, true)
outputChatBox ("#7A02BFGood Luck & #FFFFFFHave Fun!", 27, 89, 224, true)


addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
speedmarker1 = createMarker(4588.759765625, -1970.7069091797, 25.676122665405, "corona", 5, 0, 0, 0, 0) 

end)
function MarkerHit (element)
if (element == getLocalPlayer()) then
if (source == speedmarker1) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
local vehicle = getPedOccupiedVehicle(element)
local velx, vely, velz = getElementVelocity(vehicle)
local newx, newy, newz = velx*2, vely*2, velz*2
setElementVelocity(vehicle, newx, newy, newz)
end
end
end
end
end
addEventHandler("onClientMarkerHit", getRootElement(), MarkerHit)


addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
speedmarker2 = createMarker(4774.138671875, -1970.7060546875, 67.386116027832, "corona", 5, 0, 0, 0, 0) 

end)
function MarkerHit (element)
if (element == getLocalPlayer()) then
if (source == speedmarker2) then
if (getElementType(element) == "player") then
if (isPedInVehicle(element)) then
local vehicle = getPedOccupiedVehicle(element)
local velx, vely, velz = getElementVelocity(vehicle)
local newx, newy, newz = velx*2, vely*2, velz*2
setElementVelocity(vehicle, newx, newy, newz)
end
end
end
end
end
addEventHandler("onClientMarkerHit", getRootElement(), MarkerHit)


function Tutorialforteleboostscript ()
tutorialmarker1 = createMarker(5153.1772460938, -1970.4035644531, 100.35335540771, "ring", 2.20000004, 0, 0, 0, 0)
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Tutorialforteleboostscript )

function TutorialMarkerHit  ( hitPlayer, matchingDimension )
   if hitPlayer ~= getLocalPlayer() then 
   return 
   end
   if source == tutorialmarker1 then
    tutorialvehicleowns = getPedOccupiedVehicle(hitPlayer)
	setElementRotation ( tutorialvehicleowns, 0, 0, 270)
    setElementPosition ( tutorialvehicleowns, 5157.9067382813, -1970.3995361328, 583.16284179688)
    setTimer(setVehicleFrozen, 2500, 5, vehicle, true)
end
if source == tutorialmarker2 then
 tutorialvehicleowns = getPedOccupiedVehicle(hitPlayer)
end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), TutorialMarkerHit )


function invicibleObjects()
shade1 = createObject(8558, 3738.546875, -1953.7041015625, 5.7506713867188, 333.99536132813, 0, 179.99450683594)

setElementAlpha(shade1, 0)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), invicibleObjects)


function palm ()
palmtxd = engineLoadTXD("gta_tree_palm.txd")
engineImportTXD(palmtxd, 622 )
palmdff = engineLoadDFF('veg_palm03.dff', 0) 
engineReplaceModel(palmdff, 622)  
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )