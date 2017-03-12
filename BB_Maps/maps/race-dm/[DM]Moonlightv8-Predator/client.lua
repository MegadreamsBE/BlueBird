function palm ()
palmtxd = engineLoadTXD("gta_tree_palm2.txd")
engineImportTXD(palmtxd, 621 )
palmdff = engineLoadDFF('veg_palm02.dff', 0) 
engineReplaceModel(palmdff, 621)  
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )
 
 
 setWaterColor(112,147,219,230)
 
function mukkestart()
    setRadioChannel(0)
    song = playSound("music.mp3",true)
end

function turnradiooff()
    setRadioChannel(0)
    cancelEvent()
end

function toggleSong()
    if not songOff then
	    setSoundVolume(song,0)
		songOff = true
		removeEventHandler("onClientPlayerRadioSwitch",getRootElement(),turnradiooff)
	else
	    setSoundVolume(song,1)
		songOff = false
		setRadioChannel(0)
		addEventHandler("onClientPlayerRadioSwitch",getRootElement(),turnradiooff)
	end
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),mukkestart)
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),turnradiooff)
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),turnradiooff)
addCommandHandler("musicmusic",toggleSong)
bindKey("m","down","musicmusic")


setCloudsEnabled ( false )
outputChatBox("",255,255,255,true)
outputChatBox ("#aaaaaaPress #299F34'M' #aaaaaato toggle the music #299F34on/off!", 27, 89, 224, true)
outputChatBox("",255,255,255,true)


function markers()
	marker1 = createMarker(7028.38671875, -1709.51953125, -3.0034804344177,"corona",5, 0, 0, 0, 0)
	marker2 = createMarker(7073.0219726563, -1709.51953125, -3.0034804344177,"corona",5, 0, 0, 0, 0)
	marker3 = createMarker(6782.5732421875, -1063.0830078125, 12.962998390198,"ring",5, 0, 0, 0, 0)
	marker4 = createMarker(6663.2666015625, -1063.0830078125, 24.383995056152,"ring",5, 0, 0, 0, 0)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), markers)

function MarkerHit ( hitPlayer, matchingDimension )
	vehicle = getPedOccupiedVehicle ( hitPlayer )
	if hitPlayer ~= localPlayer then return end
	if source == marker1 then
		setGameSpeed(0.25)
	elseif source == marker2 then
		setGameSpeed(1)
	elseif source == marker3 then
		setGameSpeed(0.35)
	elseif source == marker4 then
		setGameSpeed(1)
	end

end

addEventHandler("onClientMarkerHit", root, MarkerHit)