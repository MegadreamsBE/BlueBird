----------------------------------<
-- Bluebird GUI
-- elements/dxImage.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxImage
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
pathOrImage : The path to the image or just the texture
rotation : Rotation of the image in degrees
rotationOffX : X Offset from the image center to rotation point
rotationOffY : Y Offset ...
color : The color of the images (includes alpha)
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateImage(x,y,sx,sy,pathOrImage,parent,relativeX, relativeY,rotation, rotationOffX, rotationOffY, color)
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) or (pathOrImage == nil) then pushError(1, 'dxCreateImage') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateImage', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateImage', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateImage', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateImage', 'Height', 'number') return false end
	if (type(pathOrImage) ~= 'string') and (type(pathOrImage) ~= 'userdata') then pushError(2, 'dxCreateImage', 'Path or Image', 'path/material') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateImage', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateImage', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if type(pathOrImage) == "string" then
		if string.sub(pathOrImage, 1,1) ~= ":" then
			pathOrImage = ":"..getResourceName(sourceResource or getThisResource()).."/"..pathOrImage
		end
	else
		if (not isElement(pathOrImage)) then
			pushError(2, 'dxCreateImage', 'Path or Image', 'path/material')
			return false
		end
		if (getElementType(pathOrImage) ~= "texture") then
			pushError(2, 'dxCreateImage', 'Path or Image', 'path/material')
			return false
		end
	end


	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateImage', 'X Relativity', 'boolean')
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
			pushError(3, 'dxCreateImage', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
			sy = parent.sy*sy
		end
	end

	if (color == nil) then
		color = -1
	else
		if type(color) ~= "number" then
			pushError(3, 'dxCreateTile', 'Color', 'number')
			color = -1
		end
		if (color < -2147483648) or (color > 2147483647) then
			pushError(6, 'dxCreateTile', 'Color')
			return false
		end
	end

	if (rotation == nil) then
		rotation = 0
	else
		if type(rotation) ~= "number" then
			pushError(3, 'dxCreateTile', 'Rotation', 'number')
			rotation = 0
		end
	end

	if (rotationOffX == nil) then
		rotationOffX = 0
	else
		if type(rotationOffX) ~= "number" then
			pushError(3, 'dxCreateTile', 'Rotation X Offset', 'number')
			rotationOffX = 0
		end
	end

	if (rotationOffY == nil) then
		rotationOffY = 0
	else
		if type(rotationOffY) ~= "number" then
			pushError(3, 'dxCreateTile', 'Rotation Y Offset', 'number')
			rotationOffY = 0
		end
	end

	local ElementTable = {
		["type"] = "dxImage",
		["element"] = createElement("dxGUI", "dxImage"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["Image"] = pathOrImage,
		["rotation"] = rotation,
		["rotationOffX"] = rotationOffX,
		["rotationOffY"] = rotationOffY,
		["Enabled"] = true,
		["Color"] = color,
		["parent"] = parent,
	}

	table.insert(parent["children"], ElementTable)
	dxElementsList[ElementTable["element"]] = ElementTable

	triggerEvent("onDXElementCreation", root)

	return ElementTable["element"]
end

fileDelete("elements/dxImage.lua")