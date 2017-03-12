----------------------------------<
-- Bluebird GUI
-- elements/dxSlider.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxSlider
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
position : The scroll amount of the scrollbar (from 0 to 1)
rotation : If false, the scrollbar will be horizontal, vertical otherwise
sticky : Moves the slider directly to one of the 'closest' sides
background : Shows up an accent colored bar in the background.
enabled : Allow to interact with the slider
holder : Texture of the element used for pre-rendering
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateSlider(x,y,sx,sy,rotation,parent,relativeX, relativeY)
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) or (rotation == nil) then pushError(1, 'dxCreateSlider') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateSlider', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateSlider', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateSlider', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateSlider', 'Dist', 'number') return false end
	if type(rotation) ~= 'boolean' then pushError(2, 'dxCreateSlider', 'Rotation', 'boolean') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateSlider', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateSlider', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateSlider', 'X Relativity', 'boolean')
			relativeX = false
		end
		if (relativeX == true) then
			x = parent.sx*x
			sx = parent.sx*sx
		end
	end

	if (relativeY == nil) then
		relativeY = false
	else
		if type(relativeY) ~= "boolean" then
			pushError(3, 'dxCreateSlider', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
			sy = parent.sy*sy
		end
	end

	if (sx < 35) then
		pushError(4, 'dxCreateSlider', 'Width')
		return false
	end

	if (sy < 35) then
		pushError(4, 'dxCreateSlider', 'Height')
		return false
	end

	local ElementTable = {
		["type"] = "dxSlider",
		["element"] = createElement("dxGUI", "dxSlider"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["Position"] = 0,
		["Rotation"] = rotation,
		["Sticky"] = false,
		["Background"] = true,
		["Dragable"] = true,
		["Enabled"] = true,
		["holder"] = dxCreateTexture(sx+30,sy+30),
		["parent"] = parent,
	}

	table.insert(parent["children"], ElementTable)
	dxElementsList[ElementTable["element"]] = ElementTable

	updateElement(ElementTable)

	triggerEvent("onDXElementCreation", root)

	return ElementTable["element"]
end

----------------------------------<

g_ScreenX, g_ScreenY = guiGetScreenSize()

local Sliding = false
local Direction = false
local maxDistance = 0
local AfterSlides = {}

addEvent("onClientDXClick")
addEventHandler("onClientDXClick", root,
	function(btn,state,dxElements, x, y)
		if btn ~= "left" then return end

		if (state == "down") and (dxElementsList[source].type == "dxSlider") then
			Sliding = {}
			Sliding.element = source
			AfterSlides[Sliding.element] = nil
			if dxElementsList[Sliding.element].Dragable then
				if dxElementsList[Sliding.element].Rotation then
					Sliding.rot = "vert"
					Sliding.cursorStart = y
					Sliding.totalDist = dxElementsList[Sliding.element].sy-30
				else
					Sliding.rot = "hor"
					Sliding.cursorStart = x
					Sliding.totalDist = dxElementsList[Sliding.element].sx-30
				end
				Sliding.localPos = Sliding.totalDist*dxElementsList[Sliding.element].Position

				addEventHandler("onClientRender", root, updateDragging)
			end
		elseif (state == "up") then
			if Sliding then
				removeEventHandler("onClientRender", root, updateDragging)
				if dxElementsList[Sliding.element].Sticky then
					if Direction == "still" then
						if dxElementsList[Sliding.element].Position < 0.5 then Direction = "left" else Direction = "right" end
					end
					
					if maxDistance < 10 then
						if Direction == "left" then Direction = "right" else Direction = "left" end
					end

					AfterSlides[Sliding.element] = {
						["tick"] = getTickCount(),
						["startPos"] = dxElementsList[Sliding.element].Position ,
						["headTo"] =  Direction
					}
				else
					triggerEvent("onClientDXSliderFinalMove", Sliding.element,dxElementsList[Sliding.element].Position)
				end
				Sliding = false
				Direction = false
				maxDistance = 0
			end
		end
	end
)

function updateDragging()
	if Sliding then
		local pos
		if Sliding.rot == "hor" then pos,_ = getCursorPosition() pos = pos*g_ScreenX else _,pos = getCursorPosition() pos = pos*g_ScreenY end

		local diff = pos-Sliding.cursorStart
		local prog = (Sliding.localPos+diff)/Sliding.totalDist

		local speedX, speedY = getCursorSpeed()
		if Sliding.rot == "hor" then
			if speedX > 0 then Direction = "right" elseif speedX < 0 then Direction = "left" else Direction = "still" end
		else
			if speedY > 0 then Direction = "right" elseif speedY < 0 then Direction = "left" else Direction = "still" end
		end

		if prog < 0 then prog = 0 end
		if prog > 1 then prog = 1 end 

		dxElementsList[Sliding.element].Position = prog

		maxDistance = math.max(math.sqrt((pos-Sliding.cursorStart)^2), maxDistance)

		triggerEvent("onClientDXSliderMove", Sliding.element,prog)
	end
end

addEventHandler("onClientRender", root, function()
	for dxSlider, data in pairs(AfterSlides) do
		local tick = getTickCount()
		local prog = (tick-data.tick)/500
		local endPos

		if prog >=1 then
			AfterSlides[dxSlider] = nil 
			local finalValue = 0
			if data.headTo == "right" then finalValue = 1 end
			dxElementsList[dxSlider].Position = finalValue
			triggerEvent("onClientDXSliderMove", dxSlider,finalValue)
			triggerEvent("onClientDXSliderFinalMove", dxSlider,finalValue)
			return
		end

		if data.headTo == "right" then
			endPos = data.startPos+(1-data.startPos)*getEasingValue(prog, "OutQuad")
		else
			endPos = data.startPos-(data.startPos)*getEasingValue(prog, "OutQuad")
		end

		dxElementsList[dxSlider].Position = endPos
		triggerEvent("onClientDXSliderMove", dxSlider,endPos)
	end
end)

addEvent("onClientDXSliderMove")
addEvent("onClientDXSliderFinalMove")

fileDelete("elements/dxSlider.lua")