----------------------------------<
-- Bluebird GUI
-- c_property.lua
---------------------------------<
-- *~ Variables ~*
---------------------------------<

dxProperties = {}
dxNeedUpdate = {"dxEdit", "dxButton", "dxRadioButton", "dxSlider", "dxCheckBox", "dxLoadingBar"}

-- Propety name					Value type | Range | Rounded

dxProperties.dxTile = {
	["Alpha"] =					"number|0#255|true",
	["Enabled"] =				"boolean",
	["BlockChildren"] =			"boolean"
}

dxProperties.dxScrollPane = {
	["AutoFocus"] = 			"boolean",
	["AfterMovement"] =			"boolean",
	["Scrollable"] =			"boolean",
	["SlideTime"] =				"number|50#inf|true",
	["Enabled"] =				"boolean",
	["BlockChildren"] =			"boolean"
}

dxProperties.dxRectangle = {
	["Color"] =					"number|-2147483648#2147483647|true",
	["Enabled"] =				"boolean"
}

dxProperties.dxImage = {
	["Image"] =					"image",
	["Color"] =					"number|-2147483648#2147483647|true",
	["Enabled"] =				"boolean"
}

dxProperties.dxEdit = {
	["GhostText"] =				"string",
	["Text"] =					"string",
	["Enabled"] =				"boolean",
	["Masked"] =				"boolean",
	["Editable"] =				"boolean",
	["CaretIndex"] =			"number|0#inf|true",
	["CaretTime"] =				"number|50#inf|true",
	["SelectStart"] =			"number|0#inf|true",
	["SelectLength"] =			"number|0#inf|true"
}

dxProperties.dxCheckBox = {
	["Ticked"] =				"boolean",
	["Enabled"] =				"boolean"
}

dxProperties.dxButton = {
	["Text"] =					"string",
	["Enabled"] =				"boolean",
	["State"] =					"boolean"
}

dxProperties.dxSlider = {
	["Sticky"] =			 	"boolean",
	["Rotation"] =				"boolean",
	["Background"] =			"boolean",
	["Position"] =			 	"number|0#1|false",
	["Dragable"] =				"boolean",
	["Enabled"] =				"boolean"
}

dxProperties.dxText = {
	["Text"] =					"string",
	["Color"] =					"number|-2147483648#2147483647|true",
	["Scale"] =					"number",
	["Font"] =					"font",
	["HorAlign"] =				"string|left,center,right",
	["VertAlign"] =				"string|top,center,bottom",
	["Clip"] =					"boolean",
	["WordBreak"] =				"boolean",
	["ColorCoded"] =			"boolean",
	["SubPixelPos"] =			"boolean",
	["Enabled"] =				"boolean",
}

dxProperties.dxRadioButton = {
	["Ticked"] =				"boolean",
	["Enabled"] =				"boolean"
}

dxProperties.dxLoadingIcon = {
	["Version"] =				"number|1#2|true",
	["Enabled"] =				"boolean"
}

dxProperties.dxLoadingBar = {
	["Color"] =					"number|-2147483648#2147483647|true",
	["Progress"] =				"number|0#1",
	["Enabled"] =				"boolean"
}

---------------------------------<
-- *~ Functions ~*
---------------------------------<

function dxSetProperty(dxElement, propertyName, propertyValue)
	if (dxElement == nil) or (propertyName == nil) or (propertyValue == nil) then
		pushError(1,"dxSetProperty")
		return false
	end

	dxElement = dxElementsList[dxElement]

	if (not dxElement) then
		pushError(2,"dxSetProperty", "dxElement", "dxElement")
		return false
	end

	local name = dxElement.type
	local list = dxProperties[name]

	if not list[propertyName] then
		pushError(10,"dxSetProperty|"..name)
		return false
	end

	local tags = split(list[propertyName], "|")

	if tags[1] == 'boolean' then
		if type(propertyValue) ~= 'boolean' then
			pushError(2,"dxSetProperty", "propertyValue", "boolean")
			return false
		end
		dxElement[propertyName] = propertyValue
	elseif tags[1] == 'number' then
		if type(propertyValue) ~= 'number' then
			pushError(2,"dxSetProperty", "propertyValue", "number")
			return false
		end
		if #tags >= 2 then
			local range = split(tags[2], "#")

			if range[1] == '-inf' then range[1] = -math.huge end
			if range[2] == 'inf' then range[2] = math.huge end

			if (propertyValue > tonumber(range[1])) and (propertyValue < tonumber(range[2])) and (#tags >= 2) then
				dxElement[propertyName] = propertyValue
			else
				pushError(4,"dxSetProperty", "propertyValue")
				return false
			end
			if #tags == 3 then
				if tags[3] == "true" then
					dxElement[propertyName] = math.ceil(propertyValue)
				end
			end
		else
			dxElement[propertyName] = propertyValue
		end
	elseif tags[1] == 'string' then
		if type(propertyValue) ~= 'string' then
			pushError(2,"dxSetProperty", "propertyValue", "string")
			return false
		end
		if #tags == 2 then
			-- This means that the string can be only a few parameters.
			local possible = split(tags[2], ",")
			if table.find(possible,propertyValue) then
				dxElement[propertyName] = propertyValue
			else
				pushError(4,"dxSetProperty", "propertyValue")
				return false
			end
		else
			dxElement[propertyName] = propertyValue
		end
	elseif tags[1] == 'font' then
		if type(propertyValue) == 'string' then
			if table.find(dxGUIStandardFonts, propertyValue) then
				dxElement[propertyName] = propertyValue
			elseif dxGUIStandardFonts[propertyValue] then
				dxElement[propertyName] = propertyValue
			end
		elseif type(propertyValue) == 'userdata' then
			if getElementType(propertyValue) == 'dx-font' then
				dxElement[propertyName] = propertyValue
			else
				pushError(4,"dxSetProperty", "propertyValue")
				return false
			end
		else
			pushError(4,"dxSetProperty", "propertyValue")
			return false
		end
	elseif tags[1] == 'image' then
		if type(propertyValue) == 'string' then
			if string.sub(propertyValue, 1,1) ~= ":" then
				propertyValue = ":"..getResourceName(sourceResource or getThisResource()).."/"..propertyValue
			end
		elseif type(propertyValue) == "userdata" then
			if (not isElement(propertyValue)) then
				pushError(4, 'dxSetProperty', 'propertyValue')
				return false
			end
			if (getElementType(propertyValue) ~= "texture") then
				pushError(4, 'dxSetProperty', 'propertyValue')
				return false
			end
		else
			pushError(4,"dxSetProperty", "propertyValue")
			return false
		end
	end

	if table.find(dxNeedUpdate, dxElement.type) then
		updateElement(dxElement)
	end

	return true
end

function dxGetProperty(dxElement, propertyName)
	if not dxElementsList[dxElement] then
		pushError(1,"dxGetProperty")
		return false
	end

	-- If the propertyName doesn't exist.. Then it just return false anyways. :)
	return dxElementsList[dxElement][propertyName] or false
end

function quickPropertyChange(dxElement, propertyName, propertyValue) -- May only used for unbugged scripts > Gives more performance.
	dxElement[propertyName] = propertyValue

	if table.find(dxNeedUpdate, dxElement.type) then
		updateElement(dxElement)
	end

	return true
end

---------------------------------<
-- *~ Events/Handlings ~*
---------------------------------<

fileDelete("c_property.lua")