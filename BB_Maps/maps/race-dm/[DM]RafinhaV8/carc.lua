-- By Davy
function turnEngineOff ( theVehicle, leftSeat, jackerPlayer )
    -- if it's the driver who got out, and he was not jacked,
    if leftSeat == 0 and not jackerPlayer then
        -- turn off the engine
        setVehicleEngineState ( theVehicle, false )
    end
end
-- add 'turnEngineOff' as a handler for "onPlayerExitVehicle"
addEventHandler ( "onPlayerVehicleExit", getRootElement ( ), turnEngineOff )

function randomVehColors()
	for i, car in ipairs( getElementsByType( "vehicle" ) ) do
		local color = {}
		color[1] = math.random(6,6) -- random from 0 to 126, because colors is from 0 to 126
		color[2] = math.random(0,0)
		color[3] = math.random(6,6)
		color[4] = math.random(0,0) -- we take 4 random numbers because setVehicleColor have parameters with 4 colors
		setVehicleColor ( car, color[1], color[2], color[3], color[4] ) -- setting color to vehicle
	end
end
 
setTimer( randomVehColors, 500, 0 )	-- timer changes all vehicles colors to random every 0.5 sec.