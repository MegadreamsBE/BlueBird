function quickText(txt, startX, startY, points, duration,color,align)
	-- Won't check if syntax is wrong! > Must have every argument in correct order and type.
	-- duration = Milliseconds SHOWN excluding animations.
	local font = exports.BB_GUI:dxGetFont("Segoe UI", points)
	local height = dxGetFontHeight(1,font)
	local width = dxGetTextWidth(txt, 1, font)
	local align = align or "left"

	local Tile
	if align == "left" then
		Tile = exports.BB_GUI:dxCreateTile(startX,startY,width,height,false,false,false,0)
	elseif align == "center" then
		Tile = exports.BB_GUI:dxCreateTile(startX-(width/2),startY,width,height,false,false,false,0)
	elseif align == "right" then
		Tile = exports.BB_GUI:dxCreateTile(startX-width,startY,width,height,false,false,false,0)
	end
	exports.BB_GUI:dxCreateText(txt,0,0,1,1,Tile,true,true,color, 1,font)

	exports.BB_GUI:dxCreateAnimation(Tile, "RotateUp",true, "OutBack", 750)
	setTimer(
	function()
		exports.BB_GUI:dxCreateAnimation(Tile, "RotateDown", false, "Linear", 500)
	end,duration+750,1)

	setTimer(
	function()
		exports.BB_GUI:dxDestroyElement(Tile)
	end, 1300+duration,1)

	return width 
end