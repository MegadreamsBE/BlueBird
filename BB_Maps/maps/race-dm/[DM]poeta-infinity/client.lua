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

--setWaterColor(0,206,209, 255)
--setSkyGradient(0,206,209,255,69,0)