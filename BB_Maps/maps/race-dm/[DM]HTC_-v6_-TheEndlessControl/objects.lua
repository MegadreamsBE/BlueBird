noCollsTab = {}

addEventHandler("onClientResourceStart", resourceRoot, function()
	local i = 1
	while(i <= #noCollsTab)do
		setElementCollisionsEnabled(noCollsTab[i], false)
		i=i+1
	end
end
)

--table.insert(noCollsTab, createObject(9690,5140.87109375,1593.2119140625,-57.908847808838,0,0,2))
--table.insert(noCollsTab, createObject(9690,5103.8076171875,1591.9453125,-57.908847808838,0,0,182))

--table.insert(noCollsTab, createObject(9690,5147.32421875,1400.3017578125,-58.408847808838,0,0,2))
--table.insert(noCollsTab, createObject(9690,5110.552734375,1399.125,-58.233867645264,0,0,182))




table.insert(noCollsTab, createObject(16376,5219.8427734375,728.06555175781,234.40795898438,270,180,108.48999023438))
table.insert(noCollsTab, createObject(16376,5161.71484375,702.32183837891,234.40795898438,270,180,74.4873046875))



table.insert(noCollsTab, createObject(981,5090.498046875,624.546875,137.28123474121,0,0,105.74890136719))
table.insert(noCollsTab, createObject(981,5220.9267578125,629.966796875,137.28123474121,0,0,258.74450683594))
