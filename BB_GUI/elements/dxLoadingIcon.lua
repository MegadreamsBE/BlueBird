----------------------------------<
-- Bluebird GUI
-- elements/dxLoadingIcon.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxLoadingIcon
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
version : Version of the loading icon
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateLoadingIcon(x,y,sx,sy,parent,relativeX, relativeY, version, lockedRelative)
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) then pushError(1, 'dxCreateLoadingIcon') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateLoadingIcon', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateLoadingIcon', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateLoadingIcon', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateLoadingIcon', 'Height', 'number') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateLoadingIcon', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateLoadingIcon', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateLoadingIcon', 'X Relativity', 'boolean')
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
			pushError(3, 'dxCreateLoadingIcon', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
			sy = parent.sy*sy
		end
	end

	if (version == nil) then
		version = 1
	else
		if type(version) ~= "number" then
			pushError(3, 'dxCreateLoadingIcon', 'Version', 'number')
			version = 1
		end
		local versions = {1,2}
		if not versions[version] then
			pushError(3, 'dxCreateLoadingIcon', 'Version', 'number')
			version = 1
		end
	end

	if (lockedRelative ~= nil) then
		if type(lockedRelative) ~= "boolean" then
			pushError(3, 'dxCreateLoadingIcon', 'Locked Relative', 'boolean')
			lockedRelative = nil
		end
		if (lockedRelative == true) then -- True = SX Value will stay the same, SY will change.
			sy = sx
		elseif (lockedRelative == false) then -- False = SY Value will stay the same, SX will change.
			sx = sy
		end
	end

	local ElementTable = {
		["type"] = "dxLoadingIcon",
		["element"] = createElement("dxGUI", "dxLoadingIcon"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["Version"] = version,
		["Enabled"] = true,
		["parent"] = parent,
	}

	table.insert(parent["children"], ElementTable)
	dxElementsList[ElementTable["element"]] = ElementTable

	triggerEvent("onDXElementCreation", root)

	return ElementTable["element"]
end

fileDelete("elements/dxLoadingIcon.lua")