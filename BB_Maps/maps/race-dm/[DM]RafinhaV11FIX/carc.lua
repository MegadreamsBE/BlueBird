function randomVehColors()
	for i, car in ipairs( getElementsByType( "vehicle" ) ) do
		local color = {}
		color[1] = math.random(6,6) 
		color[2] = math.random(0,0)
		color[3] = math.random(6,6)
		color[4] = math.random(0,0) 
		setVehicleColor ( car, color[1], color[2], color[3], color[4] )
	end
end
 
setTimer( randomVehColors, 050, 0 )