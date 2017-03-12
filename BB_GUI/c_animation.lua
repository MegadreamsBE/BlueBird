---------------------------------<
-- Bluebird GUI
-- c_animations.lua
---------------------------------<

addEvent("onClientDXAnimationStart")
addEvent("onClientDXTweenStart")
addEvent("onClientDXAnimationDone")
addEvent("onClientDXTweenDone")

---------------------------------<

g_ScreenX, g_ScreenY = guiGetScreenSize()

local Animations = {'Fade', 'MoveToFront', 'MoveToBack', 'RotateUp', 'RotateDown', 
'RotateLeft', 'RotateRight','RotateBackLeft', 'RotateFrontLeft', 'ApproachLeft'}
local Easings = {"Linear",
"InQuad", "OutQuad", "InOutQuad","OutInQuad",
"InElastic", "OutElastic", "InOutElastic", "OutInElastic",
"InBack", "OutBack", "InOutBack", "OutInBack",
"InBounce", "OutBounce", "InOutBounce", "OutInBounce"}
local ExtraEasings = {"SineCurve", "CosineCurve"}
local Playing = {} 

local ScreenScale = (g_ScreenX*g_ScreenY)/(1920*1080)

---------------------------------<
-- *~ Functions ~* 
---------------------------------<

-- Animations | Animation check for c_mouse.lua

function isAnimating(dxElement)
	if Playing[dxElement.element] then return true else return false end
end

-- Animations | Script defined motions

function dxCreateAnimation(dxElement, how, backwards, ease,length,centeredInScreen,fEasingPeriod, fEasingAmplitude, fEasingOvershoot)
	if (not dxElement) or (not how) or (not ease) or (backwards == nil) then
		pushError(1, "dxCreateAnimation")
		return false
	end
	if (type(dxElement) ~= 'userdata') then
		pushError(2, "dxCreateAnimation", "dxElement")
		return false
	end
	if (not dxElementsList[dxElement]) or (dxElementsList[dxElement].type ~= 'dxTile') then
		pushError(2, 'dxCreateAnimation', "dxElement")
		return false
	end
	if not table.find(Animations, how) then
		pushError(4, 'dxCreateAnimation', "Animation")
		return false
	end
	if Playing[dxElement] then
		pushNote(2, 'dxCreateAnimation')
		return false
	end

	if not table.find(Easings, ease) then
		pushError(4, 'dxCreateAnimation', "Easing")
		return false
	end

	if type(length) ~= 'number' then
		length = 3000
	else
		if length < 250 then
			pushError(4, 'dxCreateAnimation', "Length")
			return false
		end
	end

	if type(fEasingPeriod) ~= 'number' then
		fEasingPeriod = 0.3
	end
	if type(fEasingAmplitude) ~= 'number' then
		fEasingAmplitude = 1.0
	end
	if type(fEasingOvershoot) ~= 'number' then
		fEasingOvershoot = 1.701
	end

	Playing[dxElement] = {
		["AnimationClass"] = 1,
		['Tick'] = getTickCount(),
		['Animation'] = how,
		['Easing'] = ease,
		["Length"] = length,
		['Backwards'] = backwards,
		['Centered'] = centeredInScreen,
		['fEasingPeriod'] = fEasingPeriod,
		['fEasingAmplitude'] = fEasingAmplitude,
		['fEasingOvershoot'] = fEasingOvershoot
	}

	triggerEvent("onClientDXAnimationStart", dxElement, Playing[dxElement])
end

-- Animations | User defined motions
-- These animations can only change positions of elements.

function dxTweenPosition(dxElement, xAdd, yAdd, length, ease, backwards, fEasingPeriod, fEasingAmplitude, fEasingOvershoot)
	local function quickError(num, arg1, arg2) 
		if num == 1 then pushError(1, "dxTweenPosition")
		elseif num == 2 then pushError(2, "dxTweenPosition",arg1)
		elseif num == 3 then pushError(4, "dxTweenPosition", "Length")
		elseif num == 4 then pushError(4, "dxTweenPosition", "Easing")
		elseif num == 5 then pushError(3, "dxTweenPosition",arg1, arg2)
		end
	end

	if not dxElement then quickError(1) return false end
	if not xAdd then quickError(1) return false end
	if not yAdd then quickError(1) return false end
	if not length then quickError(1) return false end
	if not ease then quickError(1) return false end

	if Playing[dxElement] then
		pushNote(2, 'dxTweenPosition')
		return false
	end

	if backwards == nil then backwards = false else if type(backwards) ~= 'boolean' then backwards = false quickError(5, "backwards", "boolean") end end
	if fEasingPeriod == nil then fEasingPeriod = 0.3 else if type(fEasingPeriod) ~= 'number' then fEasingPeriod = 0.3 quickError(5, "fEasingPeriod", "number") end end
	if fEasingAmplitude == nil then fEasingAmplitude = 1.0 else if type(fEasingAmplitude) ~= 'number' then fEasingAmplitude = 1.0 quickError(5, "fEasingAmplitude", "number") end end
	if fEasingOvershoot == nil then fEasingOvershoot = 1.701 else if type(fEasingOvershoot) ~= 'number' then fEasingOvershoot = 1.701 quickError(5, "fEasingOvershoot", "number") end end

	if (not isElement(dxElement)) or (not dxElementsList[dxElement]) then quickError(2) return false end
	if type(xAdd) ~= 'number' then quickError(2 ,"X Addition") return false end
	if type(yAdd) ~= 'number' then quickError(2 ,"Y Addition") return false end
	if type(length) ~= 'number' then quickError(2, "Length") return false else if length < 250 then quickError(3) end end
	if (not table.find(Easings, ease)) and (not table.find(ExtraEasings,ease)) then quickError(4) return false end

	Playing[dxElement] = {
		["AnimationClass"] = 2,
		['Tick'] = getTickCount(),
		['xStart'] = dxElementsList[dxElement].x,
		['yStart'] = dxElementsList[dxElement].y,
		['xAdd'] = xAdd,
		['yAdd'] = yAdd,
		['Easing'] = ease,
		['Length'] = length,
		['Backwards'] = backwards,
		['fEasingPeriod'] = fEasingPeriod,
		['fEasingAmplitude'] = fEasingAmplitude,
		['fEasingOvershoot'] = fEasingOvershoot
	}

	triggerEvent("onClientDXTweenStart", dxElement, Playing[dxElement])
end

-- Animations updater

function updateAnimations()
	for dxElement, Vars in pairs(Playing) do
		if not isElement(dxElement) then Playing[dxElement] = nil end
		
		dxElement = dxElementsList[dxElement]

		local fNow = getTickCount()
		local fPlayed = fNow-Vars.Tick
		local fProgressReal = fPlayed/Vars.Length
			if fProgressReal > 1 then
			fProgressReal = 1
		end
			if Vars.Backwards then
			fProgress = 1-fProgressReal
		else
			fProgress = fProgressReal
		end
		local fEase = getEasingValue(fProgress, Vars.Easing, Vars.fEasingPeriod, Vars.fEasingAmplitude, Vars.fEasingOvershoot)
		
		if Vars.AnimationClass == 1 then
			-- Update the element's position/rotation/alpha etc.
			local name = Vars.Animation

			if name == 'Fade' then
				if fEase > 1 then fEase = 1 end
				if fEase < 0 then fEase = 0 end
				dxElement.Alpha = fEase*255
			elseif name == 'MoveToFront' then
				local totalAdd = 30*ScreenScale

				dxElement.temp = {-totalAdd*fEase,-totalAdd*fEase, totalAdd*fEase*2, totalAdd*fEase*2}

				if fEase > 1 then fEase = 1 end
				if fEase < 0 then fEase = 0 end
				dxElement.Alpha = 255-(fEase*255)
			elseif name == 'MoveToBack' then
				local totalAdd = -30*ScreenScale

				dxElement.temp = {-totalAdd*fEase,-totalAdd*fEase, totalAdd*fEase*2, totalAdd*fEase*2}

				if fEase > 1 then fEase = 1 end
				if fEase < 0 then fEase = 0 end
				dxElement.Alpha = 255-(fEase*255)
			elseif name == 'RotateUp' then
				if fEase > 1 then fEase = 1 end
				dxElement.transform = {0, -90*fEase, 0}

				if fEase == 1 then
					dxElement.Alpha = 0
				else
					dxElement.Alpha = 255
				end
			elseif name == 'RotateDown' then
				if fEase > 1 then fEase = 1 end
				dxElement.transform = {0, 90*fEase, 0}

				if fEase == 1 then
					dxElement.Alpha = 0
				else
					dxElement.Alpha = 255
				end
			elseif name == 'RotateLeft' then
				if fEase > 1 then fEase = 1 end
				dxElement.transform = {-90*fEase,0, 0}

				if fEase == 1 then
					dxElement.Alpha = 0
				else
					dxElement.Alpha = 255
				end
			elseif name == 'RotateRight' then
				if fEase > 1 then fEase = 1 end
				dxElement.transform = {90*fEase,0, 0}

				if fEase == 1 then
					dxElement.Alpha = 0
				else
					dxElement.Alpha = 255
				end
			elseif name == 'RotateBackLeft' then
				if fEase > 1 then fEase = 1 end
				dxElement.transform = {-120*fEase, 0, 0, -1}

				if fEase == 1 then
					dxElement.Alpha = 0
				else
					dxElement.Alpha = 255
				end
			elseif name == 'RotateFrontLeft' then
				if fEase > 1 then fEase = 1 end
				dxElement.transform = {120*fEase, 0, 0, -1}

				if fEase == 1 then
					dxElement.Alpha = 0
				else
					dxElement.Alpha = 255
				end
			elseif name == 'ApproachLeft' then
				if fEase > 1 then fEase = 1 end

				local varA = fEase/0.8
				if varA > 1 then varA = 1 end

				local varB = (fEase/0.7-1)*(2+1/3)
				if varB < 0 then varB = 0 end
				if varB > 1 then varB = 1 end

				varB = getEasingValue(varB, "OutQuad")

				dxElement.temp = {50-50*varB,0,0,0}
				dxElement.transform = {-120+120*varA, 0, 0, -1+1*fEase, 0,0,true}

				if fEase == 0 then
					dxElement.Alpha = 0
				else
					dxElement.Alpha = 255
				end
			end

			if (fProgressReal >= 1) then
				dxElement.transform = {0,0,0}
				dxElement.temp = {0,0,0,0}

				-- Remove the dxElement from the Playing Animations list.
				triggerEvent("onClientDXAnimationDone", dxElement.element, Playing[dxElement.element])
				Playing[dxElement.element] = nil
			end
		elseif Vars.AnimationClass == 2 then
			-- Change the dxElement's position.
			local xAdd = Vars.xAdd*fEase
			local yAdd = Vars.yAdd*fEase

			local newX = xAdd+Vars.xStart
			local newY = yAdd+Vars.yStart

			dxElement.x = newX
			dxElement.y = newY

			if fProgressReal >= 1 then
				-- Remove the dxElement from the Playing Animations list.
				triggerEvent("onClientDXTweenDone", dxElement.element, Playing[dxElement.element])
				Playing[dxElement.element] = nil
			end
		end
	end
end

---------------------------------<
-- *~ Events/Handlings ~*
---------------------------------<

addEventHandler("onClientPreRender", root, updateAnimations)

fileDelete("c_animation.lua")