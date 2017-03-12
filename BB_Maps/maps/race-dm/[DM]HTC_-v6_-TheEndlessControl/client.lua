
-- Create Objects 

markerOb = createMarker( 5206.9638671875, -3103.533203125, 20.168937683105, "corona", 20, 0, 0, 0, 0)

function MarkerHitOb()
	if source == markerA or markerB then
	-- Left Wallride
	object0 = createObject ( 3458, 5313.8500976563, -2548.6499023438, 40.696979522705, 0, 90, 270 )
   object1 = createObject ( 8558, 5314.9013671875, -2547.6240234375, 40.696979522705, 0, 90, 0 )
   object2 = createObject ( 8558, 5315.158203125, -2542.71484375, 39.530311584473, 0, 90, 353.99597167969 )
   object3 = createObject ( 8558, 5315.927734375, -2537.8603515625, 38.363647460938, 0, 90, 347.99743652344 )
   object4 = createObject ( 8558, 5317.19921875, -2533.1123046875, 37.196979522705, 0, 90, 341.99890136719 )
   object5 = createObject ( 8558, 5318.9609375, -2528.5244140625, 36.030311584473, 0, 90, 335.99487304688 )
   object6 = createObject ( 8558, 5321.1923828125, -2524.14453125, 34.863647460938, 0, 90, 329.99633789063 )
   object7 = createObject ( 8558, 5323.869140625, -2520.0224609375, 33.696979522705, 0, 90, 323.99780273438 )
	-- Right Wallride
	object01 = createObject ( 3458, 5100.990234375, -2548.669921875, 40.696979522705, 0, 90, 270 )
   object8 = createObject ( 8558, 5099.95703125, -2547.6240234375, 40.696979522705, 0, 90, 180 )
   object9 = createObject ( 8558, 5099.7001953125, -2542.71484375, 39.530311584473, 0, 90, 185.99853515625 )
   object10 = createObject ( 8558, 5098.9306640625, -2537.8603515625, 38.363647460938, 0, 90, 191.9970703125 )
   object11 = createObject ( 8558, 5097.6591796875, -2533.1123046875, 37.196979522705, 0, 90, 197.99560546875 )
   object12 = createObject ( 8558, 5095.8974609375, -2528.5244140625, 36.030311584473, 0, 90, 203.99963378906 )
   object13 = createObject ( 8558, 5093.666015625, -2524.14453125, 34.863647460938, 0, 90, 209.99816894531 )
   object14 = createObject ( 8558, 5090.9892578125, -2520.0224609375, 33.696979522705, 0, 90, 215.99670410156 )
	else
	return checkMarker()
	end
end
addEventHandler("onClientMarkerHit",markerOb, MarkerHitOb)


function checkMarker()
destroyElement(object01)
destroyElement(object0)
destroyElement(object1)
destroyElement(object2)
destroyElement(object3)
destroyElement(object4)
destroyElement(object5)
destroyElement(object6)
destroyElement(object7)
destroyElement(object8)
destroyElement(object9)
destroyElement(object10)
destroyElement(object11)
destroyElement(object12)
destroyElement(object13)
destroyElement(object14)
	--end
end
addEventHandler("onClientPlayerSpawn", getLocalPlayer(), checkMarker)




-- Marker Vehicle

-- Rotation
gMe = getLocalPlayer()
markerRo = createMarker( 5207.4375, -3940.1328125, 41.310256958008, "corona", 5, 0, 0, 0, 0)


function MarkerHitRo(hitPlayer)
	if hitPlayer ~= gMe then return end
   vehicle = getPedOccupiedVehicle(hitPlayer)
   if source == markerRo then
      setVehicleRotation (vehicle, 0, 0, 0)
   end
end
addEventHandler("onClientMarkerHit",markerRo, MarkerHitRo)


-- Right
gMe = getLocalPlayer()
markerA = createMarker( 5095.8330078125, -2400.203125, 9.1554412841797, "arrow", 3, 0, 0, 0, 0)

function MarkerHitA(hitPlayer)
   if hitPlayer ~= gMe then return end
   vehicle = getPedOccupiedVehicle(hitPlayer)
   if source == markerA then
      setElementVelocity(vehicle, 0, -4, 1)
	  checkMarker()
   end
end
addEventHandler("onClientMarkerHit",getResourceRootElement(getThisResource()), MarkerHitA)

-- Left
gMe = getLocalPlayer()
markerB = createMarker( 5318.998046875, -2400.203125, 9.1554412841797, "arrow", 3, 0, 0, 0, 0)

function MarkerHitB(hitPlayer)
   if hitPlayer ~= gMe then return end
   vehicle = getPedOccupiedVehicle(hitPlayer)
   if source == markerB then
      setElementVelocity(vehicle, 0, -4, 1)
	  checkMarker()
   end
end
addEventHandler("onClientMarkerHit",getRootElement(), MarkerHitB)



-- Game Speed Right
gMe = getLocalPlayer()
markerGameRight = createMarker(5096.7998046875, -2770.6999511719, 62.299999237061, "corona", 4, 0, 0, 0, 0) 

function gspeed(hitPlayer)
if hitPlayer~=gMe then return end
local vehicle = getPedOccupiedVehicle(hitPlayer)
local x,y,z = getElementPosition(hitPlayer)
if source==markerGameRight then
    setGameSpeed(0.2)
	setTimer(back,4000,1)
end
end


-- Game Speed Left
gMe = getLocalPlayer()
markerGameLeft = createMarker(5319.3999023438, -2770.6999511719, 62.299999237061, "corona", 4, 0, 0, 0, 0) 

function gspeed1(hitPlayer)
if hitPlayer~=gMe then return end
local vehicle = getPedOccupiedVehicle(hitPlayer)
local x,y,z = getElementPosition(hitPlayer)
if source==markerGameLeft then
    setGameSpeed(0.2)
	setTimer(back,4000,1)
end
end


addEventHandler("onClientMarkerHit", resourceRoot, gspeed)
addEventHandler("onClientMarkerHit", resourceRoot, gspeed1)

function back()
setGameSpeed(1)
end



-- Map Name
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
outputChatBox("#151515T#151515h#1C1C1Ce#2E2E2E E#424242n#585858d#6E6E6El#848484e#A4A4A4s#BDBDBDs #BDBDBDC#A4A4A4o#848484n#6E6E6Et#585858r#424242o#2E2E2El",255,255,255,true)


function startMusic()
    setRadioChannel(0)
    HTC = playSound("data/m.mp3",true)
end

function makeRadioStayOff()
    setRadioChannel(0)
    cancelEvent()
end

function toggleSong()
    if not songOff then
	    setSoundVolume(HTC,0)
		songOff = true
		removeEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
	else
	    setSoundVolume(HTC,1)
		songOff = false
		setRadioChannel(0)
		addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
	end
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startMusic)
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),makeRadioStayOff)
--addCommandHandler("mkmap1_racetheme",toggleSong)
bindKey("m","down",toggleSong)


setCloudsEnabled ( false ) 
function onResourceStart()
txd = engineLoadTXD ( "data/gta_tree_palm.txd" )
engineImportTXD ( txd, 622 )
dff = engineLoadDFF ( "data/veg_palm03.dff", 622 )
engineReplaceModel ( dff, 622 )


end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)