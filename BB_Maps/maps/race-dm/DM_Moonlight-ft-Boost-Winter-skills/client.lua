setWaterColor(112,147,219,230)

setCloudsEnabled ( false )
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox ("#FF0000Merry #ffffffX#FF0000-#ffffffMas #FF0000everyone!", 27, 89, 224, true)
outputChatBox ("#FF0000Press #ffffff'M' #FF0000to toggle the music #ffffffon/off!", 27, 89, 224, true)
outputChatBox("",255,255,255,true)


addEventHandler("onClientMarkerHit", root, MarkerHit)


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


function markers()
	marker1 = createMarker(5234.7905273438, -1477.8269042969, 7.049072265625,"corona",5, 0, 0, 0, 0)
	marker2 = createMarker(5263.7387695313, -1587.8106689453, 6.5284667015076,"corona",5, 0, 0, 0, 0)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), markers)

function MarkerHit ( hitPlayer, matchingDimension )
	vehicle = getPedOccupiedVehicle ( hitPlayer )
	if hitPlayer ~= localPlayer then return end
	if source == marker1 then
		setGameSpeed(0.5)
	elseif source == marker2 then
		setGameSpeed(1)
	end

end

addEventHandler("onClientMarkerHit", root, MarkerHit)


function load()
	texture1 = engineLoadTXD( "rdtrain.txd" )
	engineImportTXD( texture1, 515 )
	texture = engineLoadDFF( "rdtrain.dff", 515 )
	engineReplaceModel(texture, 515 )
end


addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
function()
	texture = engineLoadTXD( "artict1.txd" )
	engineImportTXD( texture, 435 )
	texture = engineLoadDFF( "artict1.dff", 435 )
	engineReplaceModel(texture, 435 )
	load()
end)

addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),
function()
	engineRestoreModel(515)
	engineRestoreModel(435)
end)