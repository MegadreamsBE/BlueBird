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
outputChatBox ("#ffff00Wiz Khalifa:  #FFFFFFYEAH AH HA, YOU KNOW WHAT IT IS", 255, 255, 255, true)
outputChatBox ("#ffff00Wiz Khalifa:  #FFFFFFBLACK AND YELLOW, BLACK AND YELLOW", 255, 255, 255, true)
outputChatBox ("#ffff00Wiz Khalifa:  #FFFFFFBLACK AND YELLOW, BLACK AND YELLOW", 255, 255, 255, true)


function RafinhaClient ()
tekstura = engineLoadTXD("vgncarshade1.txd") 
engineImportTXD(tekstura, 3458 )
end
addEventHandler( "onClientResourceStart", resourceRoot, RafinhaClient )

function txdClient ()
tekstura = engineLoadTXD("ballypillar01.txd") 
engineImportTXD(tekstura, 3437 )
end
addEventHandler( "onClientResourceStart", resourceRoot, txdClient )

function RafinhaClient ()
tekstura = engineLoadTXD("carshowglass_sfsx.txd") 
engineImportTXD(tekstura, 3851 )
end
addEventHandler( "onClientResourceStart", resourceRoot, RafinhaClient )

function txdClient ()
tekstura = engineLoadTXD("excalibursign.txd") 
engineImportTXD(tekstura, 8620 )
end
addEventHandler( "onClientResourceStart", resourceRoot, txdClient )

txd = engineLoadTXD ( "gta_tree_palm.txd" )
engineImportTXD ( txd, 622 )
dff = engineLoadDFF ( "veg_palm03.dff", 622 )
engineReplaceModel ( dff, 622 )
dff2 = engineLoadDFF ( "vgs_palm01.dff", 622 )


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )



