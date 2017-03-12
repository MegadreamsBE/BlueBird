setCloudsEnabled ( false )
function palm ()
palmtxd = engineLoadTXD("gta_tree_palm.txd")
engineImportTXD(palmtxd, 622 )
local palmdff = engineLoadDFF('veg_palm03.dff', 0) 
engineReplaceModel(palmdff, 622)  
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )




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
outputChatBox ("#122666Speed Vibes Special for -ftw- server", 255, 255, 255, true)




function ClientStarted ()
setWaterColor( 0 , 125 , 255 ) -- RGB colors
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )
