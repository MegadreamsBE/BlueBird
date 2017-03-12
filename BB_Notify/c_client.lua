---------------------------------<
-- Bluebird Notifier
-- c_client.lua
--[[-----------------------------<
This little script pushes notifications up to the right top corner of the screen
to inform the user of something, this can be an error or some message.
--]]-----------------------------<

g_ScreenX, g_ScreenY = guiGetScreenSize()

local quickAcces = {
	["Error"] = "images/error.png",
	["Warning"] = "images/warning.png",
	["Wait"] = "images/wait.png",
	["Check"] = "images/check.png"
}

local min_Height = 64 -- Minimal height for a block
local raster = {} -- Block holder, Block 1 = highest block, 2 = block under 1, etc.
local font = exports.BB_GUI:dxGetFont("Segoe UI", 12)

function Notify(msg,lines,image,time)
	if (msg == nil) or (lines == nil) or (image == nil) then exports.BB_GUI:pushError(1, 'Notify') return false end

	if time == nil then
		time = 3000
	end

	if type(msg) ~= "string" then
		exports.BB_GUI:pushError(2, 'Notify', 'Message', 'string')
		return false
	end

	if type(lines) ~= "number" then
		exports.BB_GUI:pushError(2, 'Notify', 'Lines', 'number')
		return false
	end

	if type(time) ~= "number" then
		exports.BB_GUI:pushError(3, 'Notify', 'Time', 'number')
		time = 3000
	end

	lines = math.ceil(lines)
	if lines <= 0 then
		exports.BB_GUI:pushError(4, 'Notify', 'Lines')
		return false
	end

	time = math.ceil(time)
	if time < 1000 then
		exports.BB_GUI:pushError(4, 'Notify', 'Time')
		return false
	end

	if quickAcces[image] then
		image = quickAcces[image]
	end

	local height = 14+lines*21 -- 14 = 2x Border, 21 = dxGetFontHeight > Segoe UI:12
	if height < min_Height then height = min_Height end

	local cHeight = 0
	if raster[#raster] then
		cHeight = raster[#raster].Height+exports.BB_GUI:dxGetRawData(raster[#raster].Tile, "y")
	end
	
	if(#raster == 0) then
		exports.BB_GUI:startRender()
	end

	local tile = exports.BB_GUI:dxCreateTile(g_ScreenX, cHeight, 300, height)
	exports.BB_GUI:dxCreateRectangle(0,0,1,1,tile, true,true, exports.BB_GUI:dxGetColor("Background"))
	exports.BB_GUI:dxCreateImage(7,7,50,50, image, tile)
	exports.BB_GUI:dxCreateText(msg,64, 7, 229, height-14,tile,false,false,tocolor(255,255,255,255), 1, font, "left", "center", true,true,true)
	table.insert(raster, {["Tile"] = tile, ["Height"] = height, ["Tick"] = getTickCount(), ["Time"] = time})
end

addEventHandler("onClientRender", root, function()
	local tick = getTickCount()
	for key, block in ipairs(raster) do
		local foo = false
		local diff = tick-block.Tick
		if diff < 1000 then
			local ease = getEasingValue(diff/1000, "OutQuad")
			local x = g_ScreenX-(300*ease)
			exports.BB_GUI:dxSetRawData(block.Tile, "x", x)
		elseif (diff >= 1000) and (diff <= 1000+block.Time) then
			-- Nothing o/
		elseif (diff > 1000+block.Time) and (diff < 2000+block.Time) then
			local ease = getEasingValue((diff-(1000+block.Time))/1000, "InQuad")
			local x = g_ScreenX-300+(300*ease)
			exports.BB_GUI:dxSetRawData(block.Tile, "x", x)
		else
			exports.BB_GUI:dxDestroyElement(block.Tile)
			table.remove(raster,key)
			
			if(#raster == 0) then
				if((getElementData(localPlayer,"UAG.MenuShown") or false) == false) then
					exports.BB_GUI:stopRender()
				end
			end
			foo = true
		end

		if not foo then
			local move = 10
			local pos = exports.BB_GUI:dxGetRawData(block.Tile, "y")
			if raster[key-1] then
				local distance = pos-exports.BB_GUI:dxGetRawData(raster[key-1].Tile, "y")-raster[key-1].Height
				if distance < 10 then
					move = distance
				end
			end
			local endPos = pos-move
			if endPos < 0 then
				move = move+endPos
			end
			exports.BB_GUI:dxSetRawData(block.Tile, "y",pos-move)
		end
	end
end)

fileDelete("c_client.lua")