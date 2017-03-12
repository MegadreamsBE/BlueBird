function txdClient ()
tekstura = engineLoadTXD("ballypillar01.txd") 
engineImportTXD(tekstura, 3437 )
end
addEventHandler( "onClientResourceStart", resourceRoot, txdClient )