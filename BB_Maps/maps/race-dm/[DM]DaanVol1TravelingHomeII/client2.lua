function edificio ()
edificiotxd = engineLoadTXD("ballys01.txd")
engineImportTXD(edificiotxd, 8392 )
local edificiodff = engineLoadDFF('ballys02_lvs', 0) 
engineReplaceModel(edificiodff, 8392)  
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), edificio )
