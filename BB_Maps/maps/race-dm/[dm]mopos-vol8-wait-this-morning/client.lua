outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("#00ff00Press #ff0000M #00ff00To Turn Music On/Off!", 255, 255, 255, true)
outputChatBox ("#777777Song Name#ffffff: #ffaa00Italobrothers - Boom ft. Carlprit", 255, 255, 255, true)

function startMusic()
    setRadioChannel(0)
    song = playSound("song.mp3",true)

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
addCommandHandler("musicmusic",toggleSong)
bindKey("m","down","musicmusic")
addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),startMusic)