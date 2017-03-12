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
table.insert(noScaleTab, createObject(8947,1863.3996582031,-4002.2770996094,78.199996948242,0,0,350.982421875))
table.insert(noScaleTab, createObject(8947,1868.7529296875,-4024.6052246094,78.199996948242,0,0,35.982421875))
table.insert(noScaleTab, createObject(8947,1863.0288085938,-4006.9699707031,78.199996948242,0,0,359.982421875))
table.insert(noScaleTab, createObject(8947,1863.3967285156,-4011.6630859375,78.199996948242,0,0,8.982421875))
table.insert(noScaleTab, createObject(8947,1864.4942626953,-4016.2409667969,78.199996948242,0,0,17.982421875))
table.insert(noScaleTab, createObject(8947,1866.2944335938,-4020.5908203125,78.199996948242,0,0,26.982421875))
table.insert(noScaleTab, createObject(8947,1871.8092041016,-4028.1857910156,78.199996948242,0,0,44.982421875))
table.insert(noScaleTab, createObject(8947,1875.3878173828,-4031.2443847656,78.199996948242,0,0,53.982421875))
table.insert(noScaleTab, createObject(8947,1879.4010009766,-4033.7053222656,78.199996948242,0,0,62.982421875))
