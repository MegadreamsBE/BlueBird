setCloudsEnabled ( false )
outputChatBox ("#7A02BF[MAP]:  #FFFFFFPress #7A02BF'M'#FFFFFF to toggle the music On/Off.", 27, 89, 224, true)

function palm ()
palmtxd = engineLoadTXD("gta_tree_palm2.txd")
engineImportTXD(palmtxd, 621 )
palmdff = engineLoadDFF('veg_palm02.dff', 0) 
engineReplaceModel(palmdff, 621)  
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )
 
