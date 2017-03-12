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
table.insert(noCollsTab, createObject(18228,347.19921875,-5769.3994140625,101.40000152588,326.39282226563,108.89099121094,111.72546386719))
table.insert(noCollsTab, createObject(18228,348.099609375,-5757.5,61.900001525879,322.89916992188,43.071899414063,77.398681640625))
table.insert(noCollsTab, createObject(18228,452.3994140625,-5759.7001953125,118.19999694824,34.60693359375,246.51672363281,267.39074707031))
table.insert(noCollsTab, createObject(18228,451.3994140625,-5769.099609375,80.300003051758,32.047119140625,297.04833984375,232.08068847656))

table.insert(noCollsTab, createObject(4666,370,-4902.3994140625,127,278.49792480469,90,90))