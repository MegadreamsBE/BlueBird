---------------------------------<
-- Calculator App
-- c_calculator.lua
---------------------------------<

AppWindow = {}
CalcNumber = {}
CalcChar = {}
QuickAccesTile = false


function main()
	AppWindow.Tile = createAppWindow(true)
	AppWindow.HeaderTitle = dxCreateText("CALCULATOR", 52,0,300,50, AppWindow.Tile, false,false, dxGetColor("Text",false), 1,dxGetFont("Segoe UI", 18), "left", "center")
	
	AppWindow.Calc = dxCreateEdit(290,100,220,40, AppWindow.Tile)

	AppWindow.Clear = dxCreateButton(290,160,40,40, "C", AppWindow.Tile)
	AppWindow.Erase = dxCreateButton(350,160,40,40, "<=", AppWindow.Tile)
	dxCreateButton(410,160,40,40, " ", AppWindow.Tile)
	table.insert(CalcChar,dxCreateButton(470,160,40,40, "/", AppWindow.Tile))
	
	table.insert(CalcNumber,dxCreateButton(290,220,40,40, "7", AppWindow.Tile))
	table.insert(CalcNumber,dxCreateButton(350,220,40,40, "8", AppWindow.Tile))
	table.insert(CalcNumber,dxCreateButton(410,220,40,40, "9", AppWindow.Tile))
	table.insert(CalcChar,dxCreateButton(470,220,40,40, "*", AppWindow.Tile))
	
	table.insert(CalcNumber,dxCreateButton(290,280,40,40, "4", AppWindow.Tile))
	table.insert(CalcNumber,dxCreateButton(350,280,40,40, "5", AppWindow.Tile))
	table.insert(CalcNumber,dxCreateButton(410,280,40,40, "6", AppWindow.Tile))
	table.insert(CalcChar,dxCreateButton(470,280,40,40, "-", AppWindow.Tile))

	table.insert(CalcNumber,dxCreateButton(290,340,40,40, "1", AppWindow.Tile))
	table.insert(CalcNumber,dxCreateButton(350,340,40,40, "2", AppWindow.Tile))
	table.insert(CalcNumber,dxCreateButton(410,340,40,40, "3", AppWindow.Tile))
	table.insert(CalcChar,dxCreateButton(470,340,40,40, "+", AppWindow.Tile))
	
	AppWindow.Dot = dxCreateButton(290,400,40,40, ".", AppWindow.Tile)
	table.insert(CalcNumber,dxCreateButton(350,400,40,40, "0", AppWindow.Tile))
	AppWindow.Opposite = dxCreateButton(410,400,40,40, "+/-", AppWindow.Tile)
	AppWindow.Result = dxCreateButton(470,400,40,40, "=", AppWindow.Tile)
	
	addEventHandler("onClientDXClick", getRootElement(), buttonPerform)
	addEventHandler("onClientDXEditChanged", AppWindow.Calc, onTextChanged)
	
	dxCreateAnimation(AppWindow.Tile, "RotateBackLeft", true, "OutQuad", 400, false)
end

function buttonPerform(btn, state)
	if (btn == "left") and (state == "up") then
		local CalcInfo = dxGetProperty(AppWindow.Calc, "Text")
		
		if source == AppWindow.Clear then
			dxSetProperty(AppWindow.Calc, "Text", "")
			return
		end
		
		if source == AppWindow.Erase then
			CalcInfo = string.sub(CalcInfo, 0,(#CalcInfo-1))
			local temp = string.sub(CalcInfo, -1)
			
			if temp == " " then
				CalcInfo = string.sub(CalcInfo, 0,(#CalcInfo-1))
			end
			
			dxSetProperty(AppWindow.Calc, "Text", CalcInfo)
			return
		end
		
		if source == AppWindow.Result then
			local status, result = pcall(loadstring("return "..CalcInfo))
			if tostring(result) == "1.#INF" then
				sendNotify("Divide by zero",1,"Error")	
				return
			end
			if status == false then
				local openBrackets = 0
				local closeBrackets = 0
				for i=1,#CalcInfo do
					local temp = string.sub(CalcInfo,i,i)
					if temp == "(" then openBrackets = openBrackets + 1 end
					if temp == ")" then closeBrackets = closeBrackets + 1 end
				end
				
				if openBrackets > closeBrackets then
					sendNotify("There are more opening\nParentheses than closing\nParentheses.",3,"Error")	
					return
				end
				
				if closeBrackets > openBrackets then
					sendNotify("There are more closing\n Parentheses than opening\nParentheses.",3,"Error")	
					return
				end
				
				sendNotify("Unknown error",1,"Error")	
			end
			
			local isDecimal = false
			local lastDigit = nil
			local posFirst = 0
			local numbDigits = 0
			local numbDecimals = 0
			
			for i=1,#tostring(result) do
				local cChar = string.sub(result,i,i)
				
				if cChar == "." then
					isDecimal = true
				end
				if isDecimal == true then
					if cChar == lastDigit then
						numbDigits = numbDigits + 1
						numbDecimals = numbDecimals + 1
					else
						lastDigit = cChar
						posFirst = i
						if numbDigits >= 4 then
							result = math.round(tonumber(string.sub(result,0,posFirst)),(numbDecimals+1))
							break
						end
					end
				end
			end
			
			dxSetProperty(AppWindow.Calc, "Text", tostring(result))
			return
		end
		
		if source == AppWindow.Dot then
			if #CalcInfo == 0 then
				return
			end
			if tonumber(string.sub(CalcInfo, -1)) == nil then
				return
			end
			local err, result = pcall(loadstring("return "..CalcInfo..".1"))
			if err == false then
				return
			end
			dxSetProperty(AppWindow.Calc, "Text", CalcInfo..".")
			return
		end
		
		for _,n in ipairs(CalcNumber) do -- Numbers
			if n == source then
				local Number = dxGetProperty(source, "Text")
				dxSetProperty(AppWindow.Calc, "Text", CalcInfo..Number)	
				return
			end
		end
		
		for _,n in ipairs(CalcChar) do -- Handling the chars
			if n == source then
				if #CalcInfo == 0 then
					return
				end
				if tonumber(string.sub(CalcInfo, -1)) == nil then
					return
				end
				local Char = dxGetProperty(source, "Text")
				dxSetProperty(AppWindow.Calc, "Text", CalcInfo.." "..Char.." ")
				return
			end
		end
	end
end

function onTextChanged(oldText, newText)
	for i=1,#newText do
		local temp = string.sub(newText,i,i)
		if(string.match(temp,"%a")) then
			dxSetProperty(AppWindow.Calc, "Text", oldText)
			return
		end
	end
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function updateTile(tile,mode)
	-- Note: mode can also be 0, this means that the tile has been removed.
	-- But here it doesn't matter due to the Live Tile of Calculator inactiveness.
	local bool
	if tile then
	 	bool = dxDestroyChildren(tile)
	end
	if bool then
		if mode == 1 then -- 1x1 = 100x100
			dxCreateRectangle(0,0,1,1,tile,true,true,dxGetColor("Accent",false))
			dxCreateImage(0,0,1,1,"images/icon.png",tile,true,true)
		elseif mode == 2 then -- 2x2 = 220x220
			dxCreateRectangle(0,0,1,1,tile,true,true,dxGetColor("Accent",false))
			dxCreateImage(60,60,100,100,"images/icon.png",tile,false,false)
			dxCreateText("Calculator", 20,20,180,180,tile,false,false,dxGetColor("Text",false), 1, dxGetFont("Segoe UI",12), "left", "bottom")
		elseif mode == 3 then -- 4x2 = 460x220
			dxCreateRectangle(0,0,1,1,tile,true,true,dxGetColor("Accent",false))
			dxCreateImage(180,60,100,100,"images/icon.png",tile,false,false)
			dxCreateText("Calculator", 20,20,420,180,tile,false,false,dxGetColor("Text",false), 1, dxGetFont("Segoe UI",12), "left", "bottom")
		end
	end
end

addEvent("onClientDXClick")
addEvent("onClientDXEditChanged")