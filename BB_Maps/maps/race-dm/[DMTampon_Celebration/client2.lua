function dxDrawColorText(str, ax, ay, bx, by, color, scale, font, alignX, alignY)
	bx, by, color, scale, font = bx or ax, by or ay, color or tocolor(255,255,255,255), scale or 1, font or "default"
	if alignX then
		if alignX == "center" then
			ax = ax + (bx - ax - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font))/2
		elseif alignX == "right" then
			ax = bx - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font)
		end
	end
	if alignY then
		if alignY == "center" then
			ay = ay + (by - ay - dxGetFontHeight(scale, font))/2
		elseif alignY == "bottom" then
			ay = by - dxGetFontHeight(scale, font)
		end
	end
	local alpha = string.format("%08X", color):sub(1,2)
	local pat = "(.-)#(%x%x%x%x%x%x)"
	local s, e, cap, col = str:find(pat, 1)
	local last = 1
	while s do
		if cap == "" and col then color = tocolor(getColorFromString("#"..col..alpha)) end
		if s ~= 1 or cap ~= "" then
			local w = dxGetTextWidth(cap, scale, font)
			dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
			ax = ax + w
			color = tocolor(getColorFromString("#"..col..alpha))
		end
		last = e + 1
		s, e, cap, col = str:find(pat, last)
	end
	if last <= #str then
		cap = str:sub(last)
		dxDrawText(cap, ax, ay, ax + dxGetTextWidth(cap, scale, font), by, color, scale, font)
	end
end

addEvent("onClientMapStarting",true)
addEventHandler("onClientMapStarting",getRootElement(),
function()
	fade = 0
	width, height = guiGetScreenSize()
	setTimer(
		function()
			check = 0
		end,2000,1
	)
	addEventHandler("onClientRender",getRootElement(),renderText)
end
)



function renderText()
	if fade <= 253 and check == 0 then
		fade = fade + 2
		dxDrawColorText("#FFFFFF[#660000Warning#FFFFFF] Map could lagg", 0, 0, width, height, tocolor(255,255,255,fade), (width/960)*4, "default", "center", "center")
	elseif check == 0 then
		check = 1
		dxDrawColorText("#FFFFFF[#660000Warning#FFFFFF] Map could lagg", 0, 0, width, height, tocolor(255,255,255,255), (width/960)*4, "default", "center", "center")
		fade = 254
	elseif fade <= 254 and check == 1 and fade ~= 0 then
		fade = fade - 2
		dxDrawColorText("#FFFFFF[#660000Warning#FFFFFF] Map could lagg", 0, 0, width, height, tocolor(255,255,255,fade), (width/960)*4, "default", "center", "center")
	elseif fade == 0 and check == 1 then
		check = 2
	end
end