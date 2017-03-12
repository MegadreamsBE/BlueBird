-- This script is created by MegaDreams for [FUN] MegaDreams ft. Rutyy - Paradise Shooter II, Don't even think about stealing it.

addEventHandler('onClientResourceStart', resourceRoot, 
function() 
	song = playSound("music.mp3",true)
	setWaterColor (0, 206, 206)
	setSunColor(0,0,0,0,0,0)
	end 
)


addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
function ()
	setSoundVolume(song,1)
	setRadioChannel ( 0 )
	
	palmtxd = engineLoadTXD("gta_tree_palm.txd")
	engineImportTXD(palmtxd, 622 )

	local palmdff = engineLoadDFF('veg_palm03.dff', 0) 
	engineReplaceModel(palmdff, 622) 
	
	outputChatBox ( "#00FF00[#FFFFFF [FUN] MegaDreams ft. Rutyy - Paradise Shooter II#00FF00]", 255, 255, 255, true)
	outputChatBox ( "#00FF00[*#FFFFFF Music: #64A6FFTristam  Braken - Flight", 255, 255, 255, true)
	outputChatBox ( "#00FF00[*#FFFFFF Press '#64a6ffK#FFFFFF' to toggle the music on/off.", 255, 255, 255, true)
	
	local keys = nil
	local keysCount = 0
	for keyName, state in pairs(getBoundKeys("fire")) do
		if keysCount == 0 then
			keys = keyName
		else
			keys = keys.." #FFFFFFor #64a6ff"..keyName
		end
		keysCount = keysCount + 1
    end
	
	outputChatBox ( "#00FF00[*#FFFFFF Press '#64a6ff"..keys.."#FFFFFF' to shoot. #00FF00]", 255, 255, 255, true)
	
	keys = nil
	keysCount = 0
	for keyName, state in pairs(getBoundKeys("jump")) do
		if keysCount == 0 then
			keys = keyName
		else
			keys = keys.." #FFFFFFor #64a6ff"..keyName
		end
		keysCount = keysCount + 1
    end
	
	outputChatBox ( "#00FF00[*#FFFFFF Press '#64a6ff"..keys.."#FFFFFF' to jump. #00FF00]", 255, 255, 255, true)
	outputChatBox ( "#00FF00[#FFFFFF Have fun, #64A6FFMegaDreams #00FF00]", 255, 255, 255, true)
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
bindKey("k","down","music")