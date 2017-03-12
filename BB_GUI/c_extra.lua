----------------------------------<
-- Bluebird GUI
-- c_change.lua
----------------------------------<
-- Element Changing
--[[------------------------------<

<export function="dxSetSize" type="client"/>
<export function="dxSetPaneSize" type="client"/>
<export function="dxSetPosition" type="client"/>
<export function="dxSetParent" type="client"/>

--]]------------------------------<

function dxSetPosition(dxElement, x,y, relativeX, relativeY)
	if (dxElement == nil) or (x == nil) or (y == nil) then
		pushError(1, "dxSetPosition")
		return false
	end

	if (not dxElementsList[dxElement]) then
		pushError(2, "dxSetPosition", "dxElement", "dxElement")
		return false
	end

	dxElement = dxElementsList[dxElement]

	if type(x) ~= "number" then
		pushError(2, "dxSetPosition", "X Position", "number")
		return false
	end

	if type(y) ~= "number" then
		pushError(2, "dxSetPosition", "Y Position", "number")
		return false
	end

	if relativeX == true then
		x = x*dxElement.parent.sx
	end

	if relativeY == true then
		y = y*dxElement.parent.sy
	end

	dxElement.x = x
	dxElement.y = y
end

function dxSetSize(dxElement, sx,sy, relativeX, relativeY)
	if (dxElement == nil) or (x == nil) or (y == nil) then
		pushError(1, "dxSetSize")
		return false
	end

	if (not dxElementsList[dxElement]) then
		pushError(2, "dxSetSize", "dxElement", "dxElement")
		return false
	end

	dxElement = dxElementsList[dxElement]

	if type(sx) ~= "number" then
		pushError(2, "dxSetSize", "Width", "number")
		return false
	end

	if type(sy) ~= "number" then
		pushError(2, "dxSetSize", "Height", "number")
		return false
	end

	if relativeX == true then
		sx = sx*dxElement.parent.sx
	end

	if relativeY == true then
		sy = sy*dxElement.parent.sy
	end

	local limits = {
		["dxSlider"] = {30,30} 
	}

	if limits[dxElement.type] then
		if sx < limits[dxElement.type][1] then
			pushError(4, "dxSetSize", "Width")
			return false
		end
		if sy < limits[dxElement.type][2] then
			pushError(4, "dxSetSize", "Height")
			return false
		end
	end

	local add = {
		["dxSlider"] = {30,30}
	}

	if dxElement.render then
		destroyElement(dxElement.render)
		dxElement.render = dxCreateRenderTarget(sx,sy,true)
		if dxElement.shader then
			dxSetShaderValue(dxElement.shader, "Tex0", dxElement.render)
		end
	end

	if dxElement.holder then
		destroyElement(dxElement.holder)
		local addX, addY = 0,0
		if add[dxElement.type] then
			addX, addY = unpack(add[dxElement.type])
		end
		dxElement.holder = dxCreateTexture(sx+addX, sy+addY,true)
	end

	dxElement.sx = sx
	dxElement.sy = sy

	updateElement(dxElement)
end

function dxSetPaneSize(dxElement, sx,sy, relativeX, relativeY)
	if (dxElement == nil) or (sx == nil) or (sy == nil) then
		pushError(1, "dxSetPaneSize")
		return false
	end

	if (not dxElementsList[dxElement]) then
		pushError(2, "dxSetPaneSize", "dxElement", "dxScrollPane")
		return false
	end

	dxElement = dxElementsList[dxElement]

	if dxElement.type ~= "dxScrollPane" then
		pushError(2, "dxSetPaneSize", "dxElement", "dxScrollPane")
		return false
	end

	if type(sx) ~= "number" then
		pushError(2, "dxSetPaneSize", "Width", "number")
		return false
	end

	if type(sy) ~= "number" then
		pushError(2, "dxSetPaneSize", "Height", "number")
		return false
	end

	if relativeX == true then
		sx = sx*dxElement.sx
	end

	if relativeY == true then
		sy = sy*dxElement.sy
	end

	table.remove(dxTargets, table.find(dxTargets,dxElement.render))
	destroyElement(dxElement.render)
	dxElement.render = dxCreateRenderTarget(sx+dxElement.sx,sy+dxElement.sy,true)
	table.insert(dxTargets, dxElement.render)
	dxElement.mOffsets = {sx, sy}
end

function dxSetParent(dxElement, parent)
	if (dxElement == nil) or (parent == nil) then
		pushError(1, "dxSetParent")
		return false
	end

	if (not dxElementsList[dxElement]) then
		pushError(2, "dxSetParent", "dxElement", "dxElement")
		return false
	end

	dxElement = dxElementsList[dxElement]

	if parent == false then
		parent = dxContainer
	elseif (not dxElementsList[parent]) then
		pushError(2, "dxSetParent", "Parent", "dxTile/dxScrollPane")
		return false
	else
		parent = dxElementsList[parent]
	end

	local oldParent = dxElement.parent
	table.remove(oldParent.children, dxElement)
	dxElement.parent = parent
	table.insert(parent.children, dxElement)

	updateList()
end

----------------------------------<
-- Element Destroyer
--[[------------------------------<

<export function="dxDestroyElement" type="client"/>
<export function="dxDestroyChildren" type="client"/>

--]]------------------------------<

function dxDestroyElement(dxElement)
	if (dxElement == nil) then
		pushError(1, "dxDestroyElement")
		return false
	end

	if (not dxElementsList[dxElement]) then
		pushError(2, "dxDestroyElement", "dxElement", "dxElement")
		return false
	end

	dxElement = dxElementsList[dxElement]
	local orParent = dxElement.parent
	local id = table.find(orParent.children, dxElement)

	local t = {}
	function insert(parent)
		if parent.children then
			for i = #parent.children, 1, -1 do
				table.insert(t, 1, parent.children[i])
				insert(parent.children[i])
			end
		end
	end
	table.insert(t,dxElement)
	insert(dxElement)

	for k, element in ipairs(t) do
		if element.shader then
			destroyElement(element.shader)
		end
		if element.render then
			table.remove(dxTargets, table.find(dxTargets, element.render))
			destroyElement(element.render)
		end
		if element.texture then
			destroyElement(element.texture)
		end
		destroyElement(element.element)
	end

	table.remove(orParent.children,id)

	triggerEvent("onDXElementDeletion", root)

	return true
end

function dxDestroyChildren(dxElement)
	if (dxElement == nil) then
		pushError(1, "dxDestroyElement")
		return false
	end

	if (not dxElementsList[dxElement]) then
		pushError(2, "dxDestroyElement", "dxElement", "dxElement")
		return false
	end

	dxElement = dxElementsList[dxElement]

	local t = {}
	function insert(parent)
		if parent.children then
			for i = #parent.children, 1, -1 do
				table.insert(t, 1, parent.children[i])
				insert(parent.children[i])
			end
		end
	end
	insert(dxElement)

	for k, element in ipairs(t) do
		if element.shader then
			destroyElement(element.shader)
		end
		if element.render then
			table.remove(dxTargets, table.find(dxTargets, element.render))
			destroyElement(element.render)
		end
		if element.texture then
			destroyElement(element.texture)
		end
		destroyElement(element.element)
	end

	triggerEvent("onDXElementDeletion", root)

	return true
end



----------------------------------<
-- Element Extras
--[[------------------------------<

<export function="dxEditIsUsing" type="client"/>

<export function="dxBringToFront" type="client"/>
<export function="dxMoveToBack" type="client"/>

<export function="dxScrollPaneGetCurrentOffsets" type="client"/>

<export function="dxGetRawData" type="client"/>
<export function="dxSetRawData" type="client"/>

--]]------------------------------<

function dxEditIsUsing(dxElement)
	if (dxElement == nil) then
		pushError(1,"dxEditIsUsing")
		return false
	end

	dxElement = dxElementsList[dxElement]

	if (not dxElement) then
		pushError(2,"dxEditIsUsing", "dxElement", "dxEdit")
		return false
	end

	if (dxElement.type) ~= "dxEdit" then
		pushError(2,"dxEditIsUsing", "dxElement", "dxEdit")
		return false
	end

	return dxElement.state
end

function dxBringToFront(dxElement, global)
	if (dxElement == nil) then
		pushError(1,"dxBringToFront")
		return false
	end

	dxElement = dxElementsList[dxElement]

	if (not dxElement) then
		pushError(2,"dxBringToFront", "dxElement", "dxElement")
		return false
	end

	if dxElement == dxContainer then return end

	local ParentChildList = dxElement.parent.children
	table.remove(ParentChildList, table.find(ParentChildList, dxElement)) -- Remove it
	table.insert(ParentChildList, 1, dxElement) -- Insert it in the front.

	updateList()

	if global then dxBringToFront(dxElement.parent,true) end
end


function dxMoveToBack(dxElement, global)
	if (dxElement == nil) then
		pushError(1,"dxMoveToBack")
		return false
	end

	dxElement = dxElementsList[dxElement]

	if (not dxElement) then
		pushError(2,"dxMoveToBack", "dxElement", "dxElement")
		return false
	end

	if dxElement == dxContainer then return end

	local ParentChildList = dxElement.parent.children
	table.remove(ParentChildList, table.find(ParentChildList, dxElement)) -- Remove it
	table.insert(ParentChildList, dxElement) -- Insert at the end.

	updateList()
	
	if global then dxMoveToFront(dxElement.parent,true) end
end

function dxScrollPaneGetCurrentOffsets(dxElement)
	if (dxElement == nil) then
		pushError(1, "dxScrollPaneGetCurrentOffsets")
		return false
	end

	if (not dxElementsList[dxElement]) then
		pushError(2, "dxScrollPaneGetCurrentOffsets", "dxElement", "dxScrollPane")
		return false
	end

	dxElement = dxElementsList[dxElement]

	if dxElement.type ~= "dxScrollPane" then
		pushError(2, "dxScrollPaneGetCurrentOffsets", "dxElement", "dxScrollPane")
		return false
	end

	return unpack(dxElement.cOffsets)
end

function dxGetRawData(dxElement, what) -- Only use this when you're sure of not having any bugs.
	return dxElementsList[dxElement][what]
end

function dxSetRawData(dxElement, what, value) -- ^ + When the value is independent on rendering
	dxElementsList[dxElement][what] = value
end

fileDelete("c_extra.lua")