addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	txd = engineLoadTXD ( "gta_tree_palm.txd" )
	engineImportTXD ( txd, 622 )
    txd = engineLoadTXD ( "gta_tree_palm2.txd" )
    engineImportTXD ( txd, 621 )
	dff = engineLoadDFF ( "veg_palm03.dff", 0 )
	engineReplaceModel ( dff, 622 )
	dff2 = engineLoadDFF ( "veg_palm02.dff", 0 )
	engineReplaceModel ( dff2, 621 )
end
)

