local framesCount = 0
local frameRate = 0

fpscounter.backgroundColor = tocolor(0, 0, 0, 100)
fpscounter.backgroundColor2 = tocolor(255, 255, 255, 50)

fpscounter.draw = function()
	framesCount = framesCount + 1
	dxDrawText("FPS: " ..  frameRate, screenInfo.width - 100, screenInfo.height - 170)
	dxDrawRectangle(screenInfo.width - 120, screenInfo.height - 150, 120, 40, fpscounter.backgroundColor)
	dxDrawRectangle(screenInfo.width - 110, screenInfo.height - 140, 100, 20, fpscounter.backgroundColor2)
	dxDrawRectangle(screenInfo.width - frameRate * 2 - 10, screenInfo.height - 140, frameRate * 2, 20, lineColorTransparent)
end

local function updateCounter()
	frameRate = framesCount
	framesCount = 0
end

setTimer(updateCounter, 1000, 0)
fileDelete("fpscounter.lua")