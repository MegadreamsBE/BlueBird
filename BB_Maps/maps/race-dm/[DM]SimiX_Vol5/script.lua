Me = getLocalPlayer()
Root = getRootElement()

function Main () 
varis1 = createMarker(2342.8999023438,-5672.7998046875,55.799999237061, "corona", 5, 0, 0, 0, 0)

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == varis1 then	
		local nx, ny, nz = getElementPosition( vehicle )
		setCameraMatrix( nx + 35, -5672.7998046875, nz + 2, 2417.19921875, -5672.7998046875, nz )
		createExplosion(2428.8994140625,-5672.7998046875,60.299999237061,6)
		setWeather ( 17 )
		setTime ( 5, 5 )
		
		setTimer ( function()
		createExplosion(2457.3999023438,-5763,2.4000000953674,10)
		end, 2000, 0 )

		setTimer ( function()
		createExplosion(2534.6999511719,-5761.7001953125,2.4000000953674,10)
		end, 1000, 0 )

		setTimer ( function()
		createExplosion(2539.5,-5875.8999023438,2.4000000953674,10)
		end, 2000, 0 )

		setTimer ( function()
		createExplosion(2604.6999511719,-5814.5,2.4000000953674,10)
		end, 1000, 0 )

		setTimer ( function()
		createExplosion(2656.3999023438,-5759.1000976563,2.4000000953674,10)
		end, 2000, 0 )

		setTimer ( function()
		createExplosion(2694.6000976563,-5870.2998046875,2.4000000953674,10)
		end, 1000, 0 )

	
	end
end

varis2 = createMarker(2475.2998046875,-5672.7998046875,55.799999237061, "corona", 5, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == varis2 then
		camera1 = 1
		obje1 = createObject ( 17472, 2508.5, -5656.2001953125, 41.599998474121, 79.51025390625, 307.986328125, 224.28460693359 )
		obje2 = createObject ( 17472, 2548.5, -5656.2001953125, 41.599998474121, 79.51025390625, 307.986328125, 224.28460693359 )
		obje3 = createObject ( 17472, 2588.5, -5656.2001953125, 44.599998474121, 79.51025390625, 307.986328125, 224.28460693359 )
		moveObject ( obje1, 3000, 2508.5, -5656.2001953125, 0 )
		moveObject ( obje2, 3000, 2548.5, -5656.2001953125, 0 )
		moveObject ( obje3, 3000, 2588.5, -5656.2001953125, 3 )
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

varis3 = createMarker(2585,-5672.7998046875,55.799999237061, "corona", 5, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == varis3 then
		camera1 = 0
		local nx, ny, nz = getElementPosition( vehicle )
		setCameraMatrix( nx + 110, -5666.7998046875, nz + 2, nx, -5672.7998046875, nz )
        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)

varis4 = createMarker(2699.8000488281,-5672.7998046875,55.799999237061, "corona", 5, 0, 0, 0, 0)

function boost(player)
 if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
        if source == varis4 then


        end
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, boost)



function camerayenileme ()
	if camera1 == 1 then
		local nx, ny, nz = getElementPosition( vehicle )
		setCameraMatrix( nx + 30, ny + 40, nz + 25, nx, ny, nz )
	end
end
addEventHandler( 'onClientPreRender', root, camerayenileme )




addEventHandler( 'onClientPlayerFinish', root,
	function ()
		removeEventHandler( 'onClientPreRender', root, camerayenileme )
	end
)