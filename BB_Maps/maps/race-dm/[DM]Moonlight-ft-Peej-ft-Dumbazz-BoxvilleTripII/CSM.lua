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
table.insert(noCollsTab, createObject(4587,4594.3369140625,-1884.0833740234,-7.4973001480103,312.00024414063,269.78356933594,81.514068603516))

table.insert(noScaleTab, createObject(8838,4400.3403320313,-1565.4155273438,13.447626113892,296.05480957031,266.57019042969,139.52200317383))
table.insert(noScaleTab, createObject(8838,4402.21484375,-1563.3093261719,12.069400787354,296.05480957031,275.57019042969,139.52200317383))
table.insert(noScaleTab, createObject(8838,4404.4340820313,-1561.5539550781,10.712169647217,296.05480957031,284.57019042969,139.52200317383))
table.insert(noScaleTab, createObject(8838,4406.9438476563,-1560.1927490234,9.4093551635742,296.05480957031,293.57019042969,139.52200317383))
table.insert(noScaleTab, createObject(8838,4409.6821289063,-1559.2590332031,8.1930351257324,296.05480957031,302.57019042969,139.52200317383))
table.insert(noScaleTab, createObject(8838,4412.5815429688,-1558.7758789063,7.0931606292725,296.05480957031,311.57019042969,139.52200317383))
table.insert(noScaleTab, createObject(8838,4415.5708007813,-1558.7552490234,6.1368126869202,296.05480957031,320.57019042969,139.52200317383))
table.insert(noScaleTab, createObject(8838,4418.5756835938,-1559.1976318359,5.3475403785706,296.05480957031,329.57019042969,139.52200317383))
table.insert(noScaleTab, createObject(8838,4421.5229492188,-1560.0920410156,4.7447786331177,296.05480957031,338.57019042969,139.52200317383))
table.insert(noScaleTab, createObject(8838,4424.33984375,-1561.4165039063,4.3433694839478,296.05480957031,347.57019042969,139.52200317383))
table.insert(noScaleTab, createObject(8838,4426.9565429688,-1563.1384277344,4.1531963348389,296.05480957031,356.57019042969,139.52200317383))