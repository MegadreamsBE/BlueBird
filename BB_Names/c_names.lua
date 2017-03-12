-- Variables
g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

local screenX, screenY = guiGetScreenSize()

-- Events

addEventHandler("onClientRender",getRootElement(),
	function()
		if(getElementData(localPlayer,"UAG.MenuShown") == true) then
			return
		end
		
		local plrRoom = (getElementData(localPlayer,"bb.room") or -1)
		if (plrRoom == -1) then
			return
		end
		
		local cx, cy, cz = getCameraMatrix()
		
		for _,v in ipairs(getElementsByType("player")) do
			if (v ~= localPlayer) and (getElementData(v,"state") == "alive") then
				if(plrRoom == getElementData(v,"bb.room")) then
				
					setPlayerNametagShowing(v,false)
					local x,y,z = 0,0,0
					if(getPedOccupiedVehicle(v) ~= false) then
						x,y,z = getElementPosition(getPedOccupiedVehicle(v))
					else
						x,y,z = getElementPosition(v)
					end
		
					if(getElementDimension(v) == plrRoom) then
						local distance = getDistanceBetweenPoints3D(cx,cy,cz,x,y,z)
						
						if(getPedOccupiedVehicle(v) ~= false) then
							if(getElementModel(getPedOccupiedVehicle(v)) == 425) then
								maxDist = 150
							else
								maxDist = 70
							end
						end
						
						if distance < maxDist and distance > 5 then
						
							local sx = 0
							local sy = 0
							
							if getElementData(localPlayer,"BB.Fade") then
								sx,sy = getScreenFromWorldPosition (x,y,z+1,0.08)
							else
								sx,sy = getScreenFromWorldPosition (x,y,z+1.1,0.08)
							end
							
							if sx then
								local scale = 0
								if ((getElementData(localPlayer,"state") == "spectating") and (getElementData(localPlayer,"spectating") == v)) then
									scale = (70/distance)*0.3
								else
									scale = (70/distance)*0.5
								end
								
								local r,g,b = 255,255,255
								if(getPlayerTeam(v) == false) then
									r,g,b = 255,255,255
								else
									r,g,b = getTeamColor(getPlayerTeam(v))
								end
								
								if (getElementData(localPlayer,"BB.Fade") or getPedOccupiedVehicle(v) == false) then
									dxDrawText(getPlayerName(v), sx, sy, sx, sy, tocolor(r,g,b,getElementAlpha(v)), (scale/3.5), "bankgothic", "center", "bottom", false, false, false, true )
								else
									dxDrawText(getPlayerName(v), sx, sy, sx, sy, tocolor(r,g,b,255), (scale/3.5), "bankgothic", "center", "bottom", false, false, false, true )
										
									local barWidth = 0
									local barHeight = 0
									
									local offset = (scale) * 0
									
									local drawX = sx - 50*scale/2
									drawY = sy + offset
									local width,height =  50*scale, 4*scale
									local outlineThickness = conv(0.5)*(scale)
										
									dxDrawRectangle(drawX, drawY, width, height, tocolor(0,0,0,255))	
									
									sy = sy + conv(5)
									barWidth = barWidth - conv(5)
									barHeight = barHeight - 5
									
									local health = getElementHealth(getPedOccupiedVehicle(v))
									health = math.max(health - 250, 0)/750
									
									barWidth = (barWidth/1000) * health
									
									dxDrawRectangle(drawX + outlineThickness,
                                        drawY + outlineThickness,
                                        health*(width - outlineThickness*2),
                                        height - outlineThickness*2,
										tocolor(27,161,226,255))
								end
							end
						end
					end
				end
			end
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

fileDelete("c_names.lua")