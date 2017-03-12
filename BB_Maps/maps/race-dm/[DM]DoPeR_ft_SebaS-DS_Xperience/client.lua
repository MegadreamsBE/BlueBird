setCloudsEnabled ( false )

Me = getLocalPlayer()
Root = getRootElement()

function Boosters ()
-- Markers
push8 = createMarker(3284.22, -1774.68, 7.46, "corona", 3, 255, 0, 0, 0)
push7 = createMarker(3285.98, -1781.54, 7.46, "corona", 3, 255, 0, 0, 0)
push9 = createMarker(3285.98, -1768.42, 7.46, "corona", 3, 255, 0, 0, 0)
push4 = createMarker(5080.25, -965.57202148438, 39.6, "corona", 5, 255, 0, 0, 0)
push5 = createMarker(4677.2607421875, -527.20288085938, 73.1, "corona", 5, 255, 0, 0, 0)


-- Start function
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Boosters )

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == push8 then
				setElementVelocity ( vehicle, 0.45, 0, 1.21 )
	end
              if source == push7 then
				setElementVelocity ( vehicle, 0.43, 0.04, 1.21 )
	end
              if source == push9 then
				setElementVelocity ( vehicle, 0.43, -0.04, 1.21 )
	end
              if source == push4 then
				setElementVelocity ( vehicle, -1.2, 0, 1.1 )
	end
              if source == push5 then
				setElementVelocity ( vehicle, 0, 1.2, 0.6 )
	end
end

-------

function startClient ()

         shade = createObject (3437, 4006.42, -1775.08, 26.23, 0, 77.24, 0)

setElementCollisionsEnabled (shade, false)

end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), startClient )

-------------

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	txd = engineLoadTXD ( "gta_tree_palm.txd" )
	engineImportTXD ( txd, 622 )
	engineImportTXD ( txd, 624 )
	engineImportTXD ( txd, 710 )
	engineImportTXD ( txd, 3510 )
	engineImportTXD ( txd, 718 )
	dff = engineLoadDFF ( "veg_palm03.dff", 0 )
	engineReplaceModel ( dff, 622 )
	dff2 = engineLoadDFF ( "vgs_palm01.dff", 0 )
end
)

-----------------

function onResourceStart()
 vgncarshade1 = engineLoadTXD("billbrd01_lan.txd")
 engineImportTXD(vgncarshade1, 4239)
 end
 addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onResourceStart) 

----------------

 setWaterColor(112,147,219,230)

function startMusic()
    setRadioChannel(0)
    song = playSound("SSNR.mp3",true)
	outputChatBox("#FFFFFFPress #00FFFF'M'#FFFFFF to toggle the music On/Off.", 27, 89, 224, true)
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
addCommandHandler("mkmap1_racetheme",toggleSong)
bindKey("m","down","mkmap1_racetheme")