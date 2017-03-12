-- AFK Detector script
-- Made by Dr.CrazY

-- CONSTANTS (Settings) 
local UPDATE_DELAY = 1000
-- Time before warning
local MAX_WARNING_TIME = 20 -- In seconds
-- Time before killing/kicking
local MAX_AFK_TIME = 30 -- In seconds
local MAX_AFK_ROUNDS = 3 
--
local localPlayer = getLocalPlayer()
local rootElement = getRootElement()
-- 
local stayCount = 0
local killedCount = 0
--
local screenWidth, screenHeight = guiGetScreenSize()
local showWarning = false
--
local autoKillEnabled = false
local killed = false
--
local usedTip = false

function checkMoving()
	local accelerateState = getPedControlState ( localPlayer, "accelerate" )
	local brakeState = getPedControlState ( localPlayer, "brake_reverse" )
	local leftState = getPedControlState ( localPlayer, "vehicle_left" )
	local rightState = getPedControlState ( localPlayer, "vehicle_right" )
	
	local state = true
	if((accelerateState == false) and (brakeState == false) and (leftState == false) and (rightState == false)) then
		state = false
	end
	return state
end

-- AFK checking function
function updateMyState()
	if(getElementData(localPlayer,"state") ~= "alive") then
		showWarning = false
		stayCount = 0
		killed = false
		return
	end
	-- If player frozen or not in a car, we wont detect his AFK state
	if ( not(getPedOccupiedVehicle( localPlayer )) ) then
		showWarning = false
		stayCount = 0
		killed = false
		return
	else
		if ( isVehicleFrozen ( getPedOccupiedVehicle( localPlayer ) ) ) then
			showWarning = false
			stayCount = 0
			killed = false
			return
		end
	end
	if(killed)then
		return
	end
	
	local state = checkMoving()
	
	if ( state == false) then
		stayCount = stayCount + 1
	else
		showWarning = false
		stayCount = 0
	end
	if (autoKillEnabled == true) then
		killedCount = killedCount + 1
		setElementHealth ( localPlayer, 0 )
		killed = true
		triggerServerEvent ( "onAutoKilled", localPlayer, killedCount ) 
		return
	end
	if (stayCount >= MAX_WARNING_TIME) then
		showWarning = true
		if (stayCount >= MAX_AFK_TIME) then
			killedCount = killedCount + 1
			if (killedCount >= MAX_AFK_ROUNDS) then
				triggerServerEvent ( "onKickedForAFK", localPlayer, MAX_AFK_ROUNDS) 
				return
			end
			if (setElementHealth (localPlayer, 0)) then
				showWarning = false
				triggerServerEvent ( "onKilledForAFK", localPlayer, killedCount, MAX_AFK_ROUNDS ) 
				killed = true
				stayCount = 0
			end
		end
	else
		showWarning = false
	end
end

-- AFK checking timer
setTimer ( updateMyState, UPDATE_DELAY, 0 )

function updateScreen()
	if (showWarning) then
		dxDrawText( "* You're AFK *", 0, screenHeight-500, screenWidth, screenHeight, tocolor ( 255, 255, 255, 200 ), 6, "arial", "center", "center" )
		if (killedCount < MAX_AFK_ROUNDS - 1) then
			dxDrawText( "You will get killed after "..(MAX_AFK_TIME - stayCount).." sec.", 0, screenHeight-400, screenWidth, screenHeight, tocolor ( 27,161,226, 200 ), 2, "arial", "center", "center" )
		else
			dxDrawText( "You will get kicked after "..(MAX_AFK_TIME - stayCount).." sec.", 0, screenHeight-400, screenWidth, screenHeight, tocolor ( 27,161,226, 200 ), 2, "arial", "center", "center" )
		end
		
		local state = checkMoving()
		if ( state == true) then
			stayCount = 0
			showWarning = false
		end
	elseif(autoKillEnabled)then
	--screenWidth, screenHeight
		dxDrawText( "* AFK *", 0, screenHeight-500, screenWidth, screenHeight, tocolor ( 255, 255, 255, 160 ), 6, "arial", "center", "center" )
		dxDrawText( "Auto-kill enabled", 0, screenHeight-400, screenWidth, screenHeight, tocolor ( 15,192,252, 255 ), 2, "arial", "center", "center" )
	end
end
addEventHandler ( "onClientRender", rootElement, updateScreen)

function toggleAFKStats()
	autoKillEnabled = not autoKillEnabled
	if(autoKillEnabled)then
		outputChatBox ("#FF0000*#FFFFFF AFK auto-kill is now #939EABenabled" , 255, 255, 255, true )
	else
		outputChatBox ("#FF0000*#FFFFFF AFK auto-kill is now #939EABdisabled" , 255, 255, 255, true )
		killedCount = 0
	end
end
addCommandHandler ( "afk", toggleAFKStats, false )

function outputTip()
	outputChatBox ("#FF0000*#FFFFFF Use the #939EAB/afk #FFFFFFcommand to enable/disable AFK auto-kill" , 255, 255, 255, true )
	usedTip = false
end

setTimer(outputTip, 600000, 0)

addEvent( "onTipTriggered", true )
addEventHandler( "onTipTriggered", getRootElement(), function()
	if(not usedTip)then
		outputChatBox("#FF0000*#FFFFFF Use the #939EAB/afk #FFFFFFcommand to enable/disabled AFK auto-kill",  255, 255, 255, true)
		usedTip = true
	end
end)