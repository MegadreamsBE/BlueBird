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
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("#88C0C0RonnY#ffcc00BRA#:  #8B8989H#EEE9E9appy Island !", 27, 89, 224, true)
outputChatBox ("#88C0C0RonnY#ffcc00BRA#:  #8B8989P#EEE9E9ress: #ffcc00'M'#EEE9E9 to toggle the music On/Off.", 27, 89, 224, true)
outputChatBox ("#88C0C0RonnY#ffcc00BRA#:  #8B8989G#EEE9E9ood Luck & Have Fun !", 27, 89, 224, true)
outputChatBox ("#88C0C0RonnY#ffcc00BRA#:  #8B8989Music#EEE9E9Hate Mosh & Shy Kidx - Hanging On !", 27, 89, 224, true)



txd = engineLoadTXD ( "gta_tree_palm.txd" )
engineImportTXD ( txd, 622 )
txd = engineLoadTXD ( "gta_tree_palm2.txd" )
engineImportTXD ( txd, 621 )
dff = engineLoadDFF ( "veg_palm03.dff", 622 )
engineReplaceModel ( dff, 622 )
dff = engineLoadDFF ( "veg_palm02.dff", 622 )
engineReplaceModel ( dff, 621 ) 
txd = engineLoadTXD ( "ballypillar01.txd" )
engineImportTXD ( txd, 3437 )




function ClientStarted ()
setWaterColor( 204 , 204 , 250 , 255 ) -- RGB colors
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )

setRadioChannel(0)
song = playSound("song.mp3", true)

bindKey("m", "down",
function ()
        setSoundPaused(song, not isSoundPaused(song))
end
)