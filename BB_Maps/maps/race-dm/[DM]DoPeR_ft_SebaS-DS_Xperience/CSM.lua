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
table.insert(noCollsTab, createObject(10871,7531.095703125,-1697.390625,34.644897460938,11,270,180))

table.insert(noScaleTab, createObject(8558,6489.4599609375,-970.8251953125,67.386703491211,0,90,263.48510742188))
table.insert(noScaleTab, createObject(8558,6484.3828125,-970.4072265625,67.386703491211,0,90,267.08312988281))
table.insert(noScaleTab, createObject(8558,6479.2900390625,-970.3076171875,67.386703491211,0,90,270.68115234375))
table.insert(noScaleTab, createObject(8558,6474.2001953125,-970.529296875,67.386703491211,0,90,274.28466796875))
table.insert(noScaleTab, createObject(8558,6469.134765625,-971.0703125,67.386703491211,0,90,277.88269042969))
table.insert(noScaleTab, createObject(8558,6464.1123046875,-971.927734375,67.386703491211,0,90,281.48620605469))
table.insert(noScaleTab, createObject(8558,6459.1552734375,-973.0986328125,67.386703491211,0,90,285.08422851563))
table.insert(noScaleTab, createObject(8558,6449.5078125,-976.3623046875,67.386703491211,0,90,292.28576660156))
table.insert(noScaleTab, createObject(8558,6444.857421875,-978.44140625,67.386703491211,0,90,295.8837890625))
table.insert(noScaleTab, createObject(8558,6440.3466796875,-980.80859375,67.386703491211,0,90,299.4873046875))
table.insert(noScaleTab, createObject(8558,6435.9931640625,-983.4541015625,67.386703491211,0,90,303.08532714844))
table.insert(noScaleTab, createObject(8558,6431.814453125,-986.3681640625,67.386703491211,0,90,306.68334960938))
table.insert(noScaleTab, createObject(8558,6424.0458984375,-992.9541015625,67.386703491211,0,90,313.88488769531))
table.insert(noScaleTab, createObject(8558,6420.4873046875,-996.599609375,67.386703491211,0,90,317.48840332031))
table.insert(noScaleTab, createObject(8558,6427.8271484375,-989.5390625,67.386703491211,0,90,310.28686523438))
table.insert(noScaleTab, createObject(8558,6414.0908203125,-1004.5234375,67.386703491211,0,90,324.68444824219))
table.insert(noScaleTab, createObject(3458,6417.1650390625,-1000.4609375,67.386680603027,0,90,321.08642578125))
table.insert(noScaleTab, createObject(3458,6454.2802734375,-974.578125,67.386680603027,0,90,288.68225097656))
table.insert(noScaleTab, createObject(3458,6494.5009765625,-971.5615234375,67.386680603027,0,90,259.88159179688))
table.insert(noScaleTab, createObject(3458,4663.0913085938,-53.872100830078,146.68589782715,0,30.399169921875,270))
table.insert(noScaleTab, createObject(3458,4699.3129882813,-53.872100830078,146.68589782715,0,30.399169921875,269.99450683594))