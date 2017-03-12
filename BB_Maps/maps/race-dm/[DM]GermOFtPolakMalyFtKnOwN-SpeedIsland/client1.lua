 function ClientStarted ()
	txd = engineLoadTXD ( "gta_tree_palm.txd" )
	engineImportTXD ( txd, 622 )
	dff = engineLoadDFF ( "veg_palm03.dff", 622 )
	engineReplaceModel ( dff, 622 )
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )


function palm ()
palmtxd = engineLoadTXD("gta_tree_palm2.txd")
engineImportTXD(palmtxd, 621 )
palmdff = engineLoadDFF('veg_palm02.dff', 0) 
engineReplaceModel(palmdff, 621)  
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )

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
 
 
function mukkestart()
    setRadioChannel(0)
    song = playSound("SpeedIoPink.mp3",true)
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
outputChatBox("#38B6E4'Press 'M' to toggle the music.'", 27, 89, 224, true)