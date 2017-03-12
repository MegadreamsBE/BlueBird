function startMusic()
    setRadioChannel(0)
    song = playSound("Buzzin.mp3",true)
end

function makeRadioStayOff()
    setRadioChannel(0)
    cancelEvent()
end

function toggleSong()
    if not songOff then
	    setSoundVolume(song,0)
		songOff = true
		removeEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
	else
	    setSoundVolume(song,1)
		songOff = false
		setRadioChannel(0)
		addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
	end
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startMusic)
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),makeRadioStayOff)
addCommandHandler("music",toggleSong)
bindKey("m","down","music")

setCloudsEnabled (false)

---

gMe1 = getLocalPlayer()
function gravity1()
marker1 = createMarker (3368.2834472656, 2377.7138671875, 275.36651611328, "cylinder", 10, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker1 then
setElementVelocity ( vehicle, 2, 0, 3)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

setElementModel(getLocalPlayer(),285)

---

gMe1 = getLocalPlayer()
function gravity1()
marker2 = createMarker (3368.283203125, 2396.3747558594, 275.36651611328, "cylinder", 10, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker2 then
setElementVelocity ( vehicle, 2, 0, 3)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

---

gMe1 = getLocalPlayer()
function gravity1()
marker3 = createMarker (3368.283203125, 2415.2250976563, 275.36651611328, "cylinder", 10, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker3 then
setElementVelocity ( vehicle, 2, 0, 3)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

---

gMe1 = getLocalPlayer()
function gravity1()
marker4 = createMarker (3368.283203125, 2433.8254394531, 275.36651611328, "cylinder", 10, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker4 then
setElementVelocity ( vehicle, 2, 0, 3)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

---

gMe1 = getLocalPlayer()
function gravity1()
marker5 = createMarker (3368.283203125, 2453.8764648438, 275.36651611328, "cylinder", 10, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker5 then
setElementVelocity ( vehicle, 2, 0, 3)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

---

gMe1 = getLocalPlayer()
function gravity1()
marker6 = createMarker (3368.283203125, 2475.2172851563, 275.36651611328, "cylinder", 10, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker6 then
setElementVelocity ( vehicle, 2, 0, 3)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

---

gMe1 = getLocalPlayer()
function gravity1()
marker7 = createMarker (3368.283203125, 2496.2778320313, 275.36651611328, "cylinder", 10, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker7 then
setElementVelocity ( vehicle, 2, 0, 3)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

---

gMe1 = getLocalPlayer()
function gravity1()
marker8 = createMarker (3368.283203125, 2517.1887207031, 275.36651611328, "cylinder", 10, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker8 then
setElementVelocity ( vehicle, 2, 0, 3)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

---

gMe1 = getLocalPlayer()
function gravity1()
marker9 = createMarker (4015.9438476563, 2750.9340820313, 308.02145385742, "cylinder", 10, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == marker9 then
setElementVelocity ( vehicle, -1, 0, 1)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

---

function startClient()
shade1 = createObject(4847, 3159.2412109375, 2444.4951171875, 236.96989440918, 0, 0, 90)
shade2 = createObject(4847, 3258.1552734375, 2444.4951171875, 218.60487365723, 0, 0, 90)
shade3 = createObject(4847, 3292.6962890625, 2444.4951171875, 209.18482971191, 0, 0, 90)
setElementCollisionsEnabled(shade1, false)
setElementCollisionsEnabled(shade2, false)
setElementCollisionsEnabled(shade3, false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), startClient)



object2 = createObject (10444, 3161.068359375, 2547.5388183594, 269.62680053711, 0, 0, 90)
if ( object2 ) then 
	setObjectScale ( object2, 10)
	       setElementCollisionsEnabled (object2, false)
end


object3 = createObject (10444, 3161.0688476563, 2358.3410644531, 269.62680053711, 0, 0, 90)
if ( object3 ) then 
	setObjectScale ( object3, 10)
	       setElementCollisionsEnabled (object3, false)
end


object4 = createObject (10444, 3227.4321289063, 2552.4594726563, 268, 0, 0, 90)
if ( object4 ) then 
	setObjectScale ( object4, 10)
	       setElementCollisionsEnabled (object4, false)
end


object5 = createObject (10444, 3227.431640625, 2353.0603027344, 268, 0, 0, 90)
if ( object5 ) then 
	setObjectScale ( object5, 10)
	       setElementCollisionsEnabled (object5, false)
end


object6 = createObject (10444, 3274.7836914063, 2375.3605957031, 269.15191650391, 0, 0, 0)
if ( object6 ) then 
	setObjectScale ( object6, 10)
	       setElementCollisionsEnabled (object5, false)
end


object7 = createObject (10444, 3274.783203125, 2454.1137695313, 268, 0, 0, 0)
if ( object7 ) then 
	setObjectScale ( object7, 10)
	       setElementCollisionsEnabled (object5, false)
end



object8 = createObject (10444, 3274.783203125, 2516.2749023438, 269.15191650391, 0, 0, 0)
if ( object8 ) then 
	setObjectScale ( object8, 10)
	       setElementCollisionsEnabled (object5, false)
end

--

asd = createMarker (3314.5327148438, 5169.8740234375, 34.731792449951, "cylinder", 3, 255, 0, 0, 0)
addEventHandler("onClientMarkerHit", asd, function (hitElement)
setElementRotation (getPedOccupiedVehicle(hitElement), 0, 270, 0)
end) 


setWindVelocity(5,5,5)



gMe1 = getLocalPlayer()


function gravity1()
gravity1 = createMarker(4447.7250976563, 2452.232421875, 234.95176696777, "ring", 80, 1, 255, 36, 0)

end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe1 then return end
if source == gravity1 then
setGameSpeed(0.8)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity1 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )


gMe2 = getLocalPlayer()


function gravity2()
gravity2 = createMarker(4695.7573242188, 2452.232421875, 185.85154724121, "ring", 80, 1, 255, 36, 0)

end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe2 then return end
if source == gravity2 then
setGameSpeed(1)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity2 )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

txd = engineLoadTXD("files/gta_tree_palm.txd")
engineImportTXD(txd, 622)
dff = engineLoadDFF("files/veg_palm03.dff", 622)
engineReplaceModel(dff, 622)
txd = engineLoadTXD("files/gtatreeshi9.txd")
engineImportTXD(txd, 731)
txd = engineLoadTXD("files/luxorpillar1.txd")
engineImportTXD(txd, 8397)
txd = engineLoadTXD("files/ballypillar01.txd")
engineImportTXD(txd, 3437)


setWaterColor(0,206,209, 255)

outputChatBox ("#f50000Your misery begains here..", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("#FF6666[Music]: #b0ff00Mann ft 50 cent - Buzzin , press #ff6400m #b0ff00to toggle music on / off", 255, 0, 0, true)
outputChatBox ("#ff6400[FFS]:  #FFFFFFDon't forget to visit: #FF9900|FFS|Racing #FFFFFFWebsite: #FF9900www.ffsracing.net", 27, 89, 224, true)
outputChatBox ("#ff6666[MAP]: #b0ff00Have fun and good luck!", 27, 89, 224, true)