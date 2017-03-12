----------------------------------<
-- Bluebird GUI
-- c_error.lua
----------------------------------<
-- Error system
----------------------------------<

dxGUIErrors = {
	[1]		= "Missing/Invalid argument(s).",
	[2]		= "Invalid argument used at <#>, has to be a(n) #.",
	[3]		= "Invalid argument used at <#>, has to be a(n) #, using default value.",
	[4]		= "Invalid argument used at <#>, check the wiki for the possibilities.",
	[5]		= "Invalid argument used at <#>, using default value, check the wiki for the possibilities.",
	[6]		= "Argument value at <#> isn't possible, check the wiki for the possibilities.",

}

dxGUINotes = {
	[1]		= "A new animation started on an already animating dxElement.",
	[2]		= "This dxElement is already playing an animation."
}

function pushError(value,name,...)
	local extras = {...}
	local str = dxGUIErrors[value]
	for k, repl in ipairs(extras) do
		str = string.gsub(str, "#", repl, 1)
	end
	outputDebugString("("..name.."): "..str, 0,55,167,220)
end

function pushNote(value)
	outputDebugString(dxGUINotes[value], 0,255,0,0)
end

fileDelete("c_error.lua")