-- Variables
g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

local screenX, screenY = guiGetScreenSize()
local cTick = 0

local colorCodes = {
[0] = tocolor(27,161,226,255),
[1] = tocolor(255,0,0,255),
[2] = tocolor(0,255,0,255),
[3] = tocolor(0,0,255,255),
[4] = tocolor(255,0,255,255),
[5] = tocolor(255,255,0,255),
[6] = tocolor(255,128,0,255),
[7] = tocolor(255,0,128,255),
[8] = tocolor(128,255,0,255),
[9] = tocolor(128,0,255,255),
[10] = tocolor(0,128,255,255)
}

local premColor = colorCodes[math.random(0,(#colorCodes/2))]
local secColor = colorCodes[math.random((#colorCodes/2),#colorCodes)]

local alertX = 0.0
local cTextSelect = colorCodes[math.random(0,#colorCodes)]
local cText = 0

addEventHandler("onClientResourceStart", g_ResourceRoot,
	function()
		fadeCamera(false)
		playSound("http://www.nonstopplay.com/site/media/wmrt-asx/broadband.asx",false)
	end
)

addEventHandler("onClientRender", g_Root,
	function()
		dxDrawImage(((screenX/2)-(conv(200)/2)), ((screenY/2)-conv(200)/2), conv(200), conv(200), 'images/loading.png', 0)
		dxDrawImage(((screenX/2)-(conv(150)/2)), ((screenY/2)-conv(65)/2), conv(150), conv(65), 'images/logo.png', 0)
		dxDrawImage(0, (screenY-conv(100)), conv(100), conv(100), 'images/bluebird.png', 0)
		
		local newCTextSelect = colorCodes[math.random(0,#colorCodes)]
		while(newCTextSelect == cTextSelect) do
			newCTextSelect = colorCodes[math.random(0,#colorCodes)]
		end
		cTextSelect = newCTextSelect
		
		if(cText == 0) then
			currentText = "Maintenance Mode"
		else
			currentText = "Please Wait..."
		end
		
		local premTextWidth = dxGetTextWidth(currentText,conv(2),'bankgothic')
		dxDrawText(currentText,alertX-premTextWidth, 0.0, alertX-premTextWidth, 0.0, cTextSelect, conv(2), 'bankgothic')
		dxDrawText(currentText,alertX-premTextWidth, 0.0, alertX-premTextWidth, 0.0, cTextSelect, conv(2), 'bankgothic')
		
		local urlTextWidth = dxGetTextWidth("www.ultimateairgamers.com",conv(1.5),'bankgothic')
		local urlTextHeight = dxGetFontHeight(conv(1.5),'bankgothic')
		dxDrawText("www.ultimateairgamers.com",((screenX/2)-(urlTextWidth/2)), screenY-urlTextHeight, ((screenX/2)-(urlTextWidth/2)), screenY-urlTextHeight, tocolor(27,161,226,255), conv(1.5), 'bankgothic')
		
		if(alertX >= (screenX+premTextWidth)) then
			alertX = 0.0
			if(cText == 0) then
				cText = 1
			else
				cText = 0
			end
		else
			if (alertX > ((((screenX/2)+(premTextWidth/2))-conv(100)))) and (alertX < ((((screenX/2)+(premTextWidth/2))+conv(100)))) then
				alertX = alertX + 3
			else
				alertX = alertX + 13
			end
		end
		
		for i = 0, cTick do
			dxDrawImage(((screenX/2)-(conv(200)/2)), ((screenY/2)-conv(200)/2), conv(200), conv(200), "images/loadingborder.png", i-3, 0, 0, premColor, true)
		end
		
		for i = cTick, 360 do
			dxDrawImage(((screenX/2)-(conv(200)/2)), ((screenY/2)-conv(200)/2), conv(200), conv(200), "images/loadingborder.png", i-3, 0, 0, secColor, true)
		end
		
		if(cTick >= 360) then
			local cSelect = colorCodes[math.random(0,#colorCodes)]
			while(cSelect == premColor or cSelect == secColor) do
				cSelect = colorCodes[math.random(0,#colorCodes)]
			end
			secColor = premColor
			premColor = cSelect
			cTick = 0
		else
			cTick = cTick + 6
		end
	end
)

function conv(size)
	local newSize = size*(screenX/1366)
	
	if(screenX >= 1600) then
		return (newSize*0.8)
	elseif(screenX <= 1000) then
		return (newSize*1.4)
	else
		return (newSize*1)
	end
end

fileDelete("c_loading.lua")