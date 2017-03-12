addEventHandler("onClientResourceStart",resourceRoot,
function()
	txd = engineLoadTXD("crystal.txd",true)
	engineImportTXD(txd,3505)
	dff = engineLoadDFF("crystal.dff", 0 )
	engineReplaceModel(dff,3505)
	billboard = engineLoadTXD("vgsn_billboard.txd",true)
	engineImportTXD(billboard, 7301 )
end)

addEventHandler("onClientResourceStop",resourceRoot,
function()
	for i,object in ipairs(getElementsByType("object")) do
		if getElementModel(object) == 3505 then
			setElementAlpha(object,255)
		end
	end
end)

for i,object in ipairs(getElementsByType("object")) do
	if getElementModel(object) == 3505 then
		setElementAlpha(object,101)
	end
end

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
