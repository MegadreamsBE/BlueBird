----------------------------------<
-- Bluebird GUI
-- elements/dxTile.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxTile
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
alpha : Transparency of the dxTile
render : Drawing target for its children
shader : Rotation transformation holder
transform : Transformation values
temp : Temporary addition of size, used for animations. E.g zooming, approach left.
parent : Parent table
children : Children container

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateTile(x,y,sx,sy,parent,relativeX, relativeY,alpha)
	-- CHANGED: relativeX and relativeY are now seperated.
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) then pushError(1, 'dxCreateTile') return false end -- Check needed arguments

	if type(x) ~= 'number' then pushError(2, 'dxCreateTile', 'X Position', 'number') return false end -- Check argument types
	if type(y) ~= 'number' then pushError(2, 'dxCreateTile', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateTile', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateTile', 'Height', 'number') return false end

	if (parent == nil) or (parent == false) then -- It's 'not' possible to give the dxContainer as parent, just use false instead.
		parent = dxContainer -- Default parent
	else
		if (not isElement(parent)) then -- Check if it's an element or not.
			pushError(2, 'dxCreateTile', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"] -- Get's parent's dxElement type
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then -- Check if it's allowed to use it as parent.
			pushError(4, 'dxCreateTile', 'Parent')
			return false
		end
		parent = dxElementsList[parent] -- Assign given parent as parent.
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateTile', 'X Relativity', 'boolean')
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
			pushError(3, 'dxCreateTile', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
			sy = parent.sy*sy
		end
	end

	if (alpha == nil) then
		alpha = 255
	else
		if type(alpha) ~= "number" then
			pushError(3, 'dxCreateTile', 'Alpha', 'number')
			alpha = 255
		end
		if (alpha < 0) or (alpha > 255) then
			pushError(6, 'dxCreateTile', 'Alpha')
			return false
		end
	end

	-- Assign data values
	local ElementTable = {
		["type"] = "dxTile",
		["element"] = createElement("dxGUI", "dxTile"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["parent"] = parent,
		["Alpha"] = alpha,
		["BlockChildren"] = false,
		["render"] = dxCreateRenderTarget(sx,sy,true),
		["shader"] = dxCreateShader("shader/window.fx"),
		["transform"] = {0,0,0},
		["temp"] = {0,0,0,0},
		["Enabled"] = true,
		["children"] = {}
	}

	dxSetShaderValue(ElementTable.shader, "Tex0", ElementTable.render)
	table.insert(parent.children, 1,ElementTable) -- Push it in the front of the table, needs to be the last one to be drawn.
	table.insert(dxTargets, ElementTable.render) -- Place the render target in the quick-to-clear list for at rendering.
	dxElementsList[ElementTable.element] = ElementTable -- Makes a quick pointer(the element created with createElement).

	triggerEvent("onDXElementCreation", root)

	return ElementTable.element -- Return the element pointer.
end

fileDelete("elements/dxTile.lua")