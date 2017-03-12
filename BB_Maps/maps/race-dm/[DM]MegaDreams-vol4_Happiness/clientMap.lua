local objectsMoved = false
local spiralState = false

addEventHandler('onClientResourceStart', resourceRoot, 
function() 
	mapShadesLeft = {}
	mapShadesRight = {}

	objMoveMarker = createMarker(2365.3999023438,-4334.3999023438,17.89999961853,"corona",11,19,235,166,0)
	
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4253.8999023438,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (3458, 2404.8999023438,-4248.7998046875,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4243.6997070313,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (8558, 2404.8999023438,-4238.599609375,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4233.4995117188,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (3458, 2404.8999023438,-4228.3994140625,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4223.2993164063,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (8558, 2404.8999023438,-4218.19921875,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4213.0991210938,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight= createObject (3458, 2404.8999023438,-4207.9990234375,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4202.8989257813,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (8558, 2404.8999023438,-4197.798828125,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4192.6987304688,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (3458, 2404.8999023438,-4187.5986328125,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4182.4985351563,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (8558, 2404.8999023438,-4177.3984375,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4172.2983398438,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (3458, 2404.8999023438,-4167.1982421875,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4162.0981445313,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (8558, 2404.8999023438,-4156.998046875,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4151.8979492188,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (3458, 2404.8999023438,-4146.7978515625,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeLeft = createObject (3458, 2324.8999023438,-4141.7001953125,0.0,0.0,0.0,0.0) table.insert(mapShadesLeft, mapShadeLeft)
	local mapShadeRight = createObject (8558, 2404.8999023438,-4136.6000976563,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	local mapShadeRight = createObject (8558, 2404.8999023438,-4136.6000976563,0.0,0.0,0.0,0.0) table.insert(mapShadesRight, mapShadeRight)
	
	addEventHandler ( "onClientMarkerHit", getRootElement(), onMarkerHit)
	end 
)

function onMarkerHit(hitPlayer, matchingDimension)
	if source == objMoveMarker and hitPlayer == getLocalPlayer() and objectsMoved == false then
		for i=1, #mapShadesLeft do
			local objX, objY, objZ = getElementPosition(mapShadesLeft[i])
			moveObject (mapShadesLeft[i], 2000, objX+40, objY, objZ)
		end
		for i=1, #mapShadesRight do
			local objX, objY, objZ = getElementPosition(mapShadesRight[i])
			moveObject (mapShadesRight[i], 2000, objX-40, objY, objZ)
		end	
		objectsMoved = true
	end
end