addEventHandler('onClientResourceStart', resourceRoot, 
function() 
	song = playSound("song.mp3",true)
	setWaterColor (0, 206, 206)
	
	local txd = engineLoadTXD('vgsn_billboard.txd') 
	engineImportTXD(txd, 7301 )
	end 
)

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
function ()
	setSoundVolume(song,1)
	setRadioChannel ( 0 )
	outputChatBox ( "#00FF00[#FFFFFF [DM] MegaDreams vol.4 - Happiness by #64A6FFMegaDreams #00FF00]", 255, 255, 255, true)
	outputChatBox ( "#00FF00[*#FFFFFF Music: #64A6FFInna - 10 minutes ( Radio Edit by Play & Win )", 255, 255, 255, true)
	outputChatBox ( "#00FF00[*#FFFFFF Press 'M' to toggle the music on/off.", 255, 255, 255, true)
	outputChatBox ( "#00FF00[#FFFFFF Have fun! #00FF00]", 255, 255, 255, true)
end
)

function stationChange()
    setRadioChannel(0)
    cancelEvent()
end
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),stationChange)
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),stationChange)

function toggleSong()
    if not songOff then
	    setSoundVolume(song,0)
		songOff = true
		removeEventHandler("onClientPlayerRadioSwitch",getRootElement(),stationChange)
	else
	    setSoundVolume(song,1)
		songOff = false
		setRadioChannel(0)
		addEventHandler("onClientPlayerRadioSwitch",getRootElement(),stationChange)
	end
end

addCommandHandler("music",toggleSong)
bindKey("m","down","music")