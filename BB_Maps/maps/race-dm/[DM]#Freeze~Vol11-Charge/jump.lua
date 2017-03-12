local marker1 = createMarker(6849.580078125, -283.44680786133, 101.79229736328, "corona", 3, 255, 255, 255, 0) -- s-Size; r-Red; g-Green; b-Blue; a-Alpha


function MarkerHit(hitPlayer)

	if hitPlayer~=localPlayer then return end
		local vehicle = getPedOccupiedVehicle(hitPlayer)
	if vehicle and source==marker1 then
		setElementVelocity(vehicle, -0.8, 0, 0.2)

	end
end

addEventHandler("onClientMarkerHit", resourceRoot, MarkerHit)





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


table.insert(noScaleTab, createObject(3458,5920.490234375,157.4462890625,41.608940124512,358.52783203125,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,162.572265625,41.411678314209,357.0556640625,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,167.6904296875,41.083068847656,355.58898925781,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,172.798828125,40.623310089111,354.11682128906,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,177.8935546875,40.032699584961,352.65014648438,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,182.9716796875,39.31164932251,351.18347167969,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,188.029296875,38.460620880127,349.71130371094,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,193.0634765625,37.480171203613,348.24462890625,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,198.0712890625,36.370941162109,346.7724609375,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,203.048828125,35.133670806885,345.30578613281,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,207.9931640625,33.76916885376,343.83361816406,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,212.900390625,32.278339385986,342.36694335938,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,217.7685546875,30.662149429321,340.89477539063,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,222.5927734375,28.921680450439,339.42810058594,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,227.37109375,27.05805015564,337.95593261719,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,246.75,20.346900939941,343.83361816406,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,232.1494140625,25.19441986084,339.42260742188,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,241.841796875,21.837739944458,342.36694335938,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,251.6943359375,18.982400894165,345.30578613281,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,236.974609375,23.453939437866,340.89477539063,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,261.6787109375,16.635889053345,348.24462890625,0,0))
table.insert(noScaleTab, createObject(6959,5917.9462890625,254.2041015625,26.725900650024,0,90,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,256.671875,17.745119094849,346.7724609375,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,266.7138671875,15.655429840088,349.71130371094,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,271.771484375,14.804389953613,351.18347167969,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,276.849609375,14.083330154419,352.65014648438,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,281.9443359375,13.492719650269,354.11682128906,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,297.2958984375,12.507069587708,358.52783203125,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,292.1708984375,12.704330444336,357.0556640625,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,302.4248046875,12.441289901733,0,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,287.052734375,13.032950401306,355.58898925781,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,307.5537109375,12.507049560547,1.4666748046875,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,312.6787109375,12.704299926758,2.9388427734375,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,317.796875,13.032910346985,4.405517578125,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,322.9052734375,13.492659568787,5.8721923828125,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,328,14.083250045776,7.3443603515625,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,333.078125,14.804300308228,8.81103515625,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,338.1357421875,15.655320167542,10.283203125,0,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,343.1708984375,16.635759353638,11.749877929688,0,0))
table.insert(noScaleTab, createObject(6959,5923.080078125,334.1357421875,26.725900650024,0,90,0))
table.insert(noScaleTab, createObject(3458,5920.490234375,348.177734375,17.744979858398,13.222045898438,0,0))