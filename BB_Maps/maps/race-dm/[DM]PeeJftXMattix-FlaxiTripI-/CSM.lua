-- * Collision/Scale object Manager * --
noCollsTab = {}
noScaleTab = {}
addEventHandler("onClientResourceStart", resourceRoot, function()
	local i = 1
	while(i <= #noCollsTab)do
		setElementCollisionsEnabled(noCollsTab[i], false)
		i=i+1
	end
	local j = 1
	while(j <= #noScaleTab)do
		setObjectScale(noScaleTab[j], 0)
		j=j+1
	end
end
)
table.insert(noScaleTab, createObject(3458,5458.6201171875,-1736.8941650391,23.93630027771,0,0,139.99453735352))

table.insert(noScaleTab, createObject(3458,5464.9965820313,-1738.3442382813,23.93630027771,0,90,229.99328613281))
table.insert(noScaleTab, createObject(3458,5457.2260742188,-1731.8369140625,23.93630027771,0,90,229.99328613281))
table.insert(noScaleTab, createObject(3458,5457.2255859375,-1731.8369140625,23.93630027771,0,90,229.99328613281))
table.insert(noScaleTab, createObject(3458,5453.3408203125,-1728.5830078125,23.93630027771,0,90,229.99328613281))
table.insert(noScaleTab, createObject(3458,5453.3408203125,-1728.5832519531,23.93630027771,0,90,229.99328613281))
table.insert(noScaleTab, createObject(3458,5461.111328125,-1735.0905761719,23.93630027771,0,90,229.99328613281))
table.insert(noScaleTab, createObject(6959,5434.7998046875,-1636.5,0,299.99816894531,0,295.99914550781))
table.insert(noScaleTab, createObject(8171,4309.8984375,-45.518901824951,36.575199127197,90,0,120))
table.insert(noScaleTab, createObject(8171,4315.0576171875,-34.267700195313,36.575199127197,90,0,299.99816894531))
table.insert(noScaleTab, createObject(8171,4318.3984375,-55.638500213623,36.575199127197,90,0,209.99816894531))