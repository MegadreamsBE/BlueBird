outputChatBox ("#027FD0[MAP]: #FFFFFF[DM] FakeDeath# Ft. Killerbee_x. - DotEXE!", 255, 255, 255, true)
outputChatBox ("#027FD0[SONG]: #ffffffPress 'M' to toggle the music On/Off.", 255, 255, 255, true)
outputChatBox ("#027FD0[MAP]: #ffffffGood Luck & Have Fun!", 255, 255, 255, true)
outputChatBox ("#027FD0[SONG]: #ffffffDotEXE - 36 Degrees!", 255, 255, 255, true)

function startMusic()
    setRadioChannel(0)
    song = playSound("music.aac",true)

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