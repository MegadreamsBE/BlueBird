cLP = getLocalPlayer()
screenWidth, screenHeight = guiGetScreenSize()

function cRStest()
	setTimer(resourcesCheck, 10000, 1)
end
addEventHandler("onClientResourceStart", getRootElement(), cRStest)

function resourcesCheck()
	if check=="done" then return
	else
		setRadioChannel(0)
		setTimer(cbinds, 1000, 1)
		textToggle=0
		check="done"
	end
end

function cRS()
	if check=="done" then return
	else
		setRadioChannel(0)
		setTimer(cbinds, 3333, 1)
		textToggle=0
		check="done"
	end
end
addEventHandler("onClientPlayerSpawn", getLocalPlayer(), cRS)

function markers(player)
	if isPedInVehicle(player) then
		local vehicle = getPedOccupiedVehicle(player)
		fixVehicle(vehicle)
	end
end
addEventHandler("onClientMarkerHit", getResourceRootElement(getThisResource()), markers)

function cbinds()
	if keys1 then
		for keyName, state in pairs(keys1) do
			bindKey("mouse", "down", cdoshoot)
		end
		bindKey("mouse1", "down", cdoshoot)
		cbindsText = ""
	end
	if keys2 then
		for keyName, state in pairs(keys2) do
			bindKey("mouse1", "down", cdoshoot)
		end
	end
	if (not keys1) and (not keys2) then
		bindKey("mouse1", "down", cdoshoot)
		cbindsText = ""
	end
	theVehicle = getPedOccupiedVehicle(cLP)
	allowShoots()
	bindKey("M", "down", toggleText)
	outputChatBox("", 255, 255, 255, true)
	outputChatBox("", 255, 255, 255, true)
	outputChatBox("", 255, 255, 255, true)
	outputChatBox("", 255, 255, 255, true)
	outputChatBox("", 255, 255, 255, true)
	outputChatBox("", 255, 255, 255, true)
    outputChatBox("#ffffffSpecial map for #ff6600SHC#ffffff!", 255, 255, 255, true)
	outputChatBox("#ffffffPress #ff6600'Left Mouse Click' #ffffffTo shoot", 255, 255, 255, true)
	outputChatBox("#ffffffPress #ff6600'M' #ffffffto toggle music on / off", 255, 255, 255, true)
	outputChatBox("#ffffffEnjoy and Have Fun! ", 255, 255, 255, true)
end

function toggleText()
	if textToggle==0 then
		addEventHandler("onClientRender", getRootElement(), bindsText)
		textToggle=1
	elseif textToggle==1 then
		removeEventHandler("onClientRender", getRootElement(), bindsText)
		textToggle=0
	end
end

function allowShoots()
	bindTrigger = 1
end

function cdoshoot()
	if bindTrigger == 1 then
		if not isPlayerDead(cLP) then
			bindTrigger = 0
			local x,y,z = getElementPosition(theVehicle)
			local rX,rY,rZ = getVehicleRotation(theVehicle)
			local x = x+4*math.cos(math.rad(rZ+90))
			local y = y+4*math.sin(math.rad(rZ+90))
			createProjectile(theVehicle, 19, x, y, z, 1.0, nil)
			setTimer(allowShoots, 3000, 1)
		end
	end
end

function bindsText()
	dxDrawText(cbindsText, screenWidth/15, screenHeight/2.5, screenWidth, screenHeight, tocolor(0, 149, 254, 255), 0.75, "bankgothic")
end