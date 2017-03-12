g_Root = getRootElement()
g_Resource = getThisResource()
g_ResourceRoot = getResourceRootElement(g_Resource)
g_Me = getLocalPlayer()

local currentState = "classic"
local lastRoom = nil
local colSphere = createColSphere(0,0,0,55)

function toggleFade()
	if(currentState == "disabled") then
		currentState = "classic"
		outputChatBox("[CARFADE]: #91FFFFYou have changed the fade mode to #64a6ffCLASSIC#91FFFF.",27,161,226,true)
		return
	end
	if(currentState == "classic") then
		currentState = "hidden"
		outputChatBox("[CARFADE]: #91FFFFYou have changed the fade mode to #64a6ffSEMI-HIDDEN#91FFFF.",27,161,226,true)
		return
	end
	if(currentState == "hidden") then
		currentState = "totalhidden"
		outputChatBox("[CARFADE]: #91FFFFYou have changed the fade mode to #64a6ffTOTAL-HIDDEN#91FFFF.",27,161,226,true)
		return
	end
	if(currentState == "totalhidden") then
		currentState = "disabled"
		outputChatBox("[CARFADE]: #91FFFFYou have changed the fade mode to #64a6ffDISABLED#91FFFF.",27,161,226,true)
		return
	end
end
bindKey("f3", "down", toggleFade)

function doFade()	
	showPlayerHudComponent("ammo", false)
	showPlayerHudComponent("area_name", false)
	showPlayerHudComponent("armour", false)
	showPlayerHudComponent("breath", false)
	showPlayerHudComponent("clock", false)
	showPlayerHudComponent("health", false)
	showPlayerHudComponent("money", false)
	showPlayerHudComponent("vehicle_name", false)
	showPlayerHudComponent("weapon", false)
	showPlayerHudComponent("wanted", false)
	
	local plrRoom = getElementData(localPlayer,"bb.room")
	
	if getElementData(localPlayer,"BB.Fade") == false then
		for _,v in ipairs(exports.BB_Rooms:getClientPlayersInRoom()) do
			if((getElementData(v,"bb.room") == plrRoom) and getPedOccupiedVehicle(v) ~= false) then
				if(getElementData(v,"state") == "alive") then
					setElementAlpha(getPedOccupiedVehicle(v),255)
					setElementAlpha(v,255)
					setElementDimension(getPedOccupiedVehicle(v),plrRoom)
					setElementDimension(v,plrRoom)
				end
			end
		end
		return
	end
	
	if(getElementData(localPlayer,"state") ~= "alive") then
		for _,v in ipairs(exports.BB_Rooms:getClientPlayersInRoom()) do
			if((getElementData(v,"bb.room") == plrRoom) and getPedOccupiedVehicle(v) ~= false) then
				if(getElementData(v,"state") == "alive") then
					setElementAlpha(getPedOccupiedVehicle(v),255)
					setElementAlpha(v,255)
					setElementDimension(getPedOccupiedVehicle(v),plrRoom)
					setElementDimension(v,plrRoom)
				end
			end
		end
	else
	
		if(currentState == "hidden") then
			local x,y,z = getElementPosition(localPlayer)
			setElementPosition(colSphere,x,y,z)
		end
	
		for _,v in ipairs(exports.BB_Rooms:getClientPlayersInRoom()) do
			if(getElementData(v,"bb.room") == plrRoom) then
				if ((getElementData(v,"state") == "alive") and (v ~= localPlayer) and getPedOccupiedVehicle(v) ~= false) then
					fadeVehicle(v,getPedOccupiedVehicle(v))
				end
			end
		end
	end
end
addEventHandler("onClientRender",getRootElement(),doFade)

function fadeVehicle(thePed,theVehicle)
	local plrRoom = getElementData(localPlayer,"bb.room")
	
	if(currentState == "disabled" or getElementModel(getPedOccupiedVehicle(localPlayer)) == 425 or getElementModel(theVehicle) == 425) then
		setElementAlpha(thePed,255)
		setElementAlpha(theVehicle,255)
		setElementDimension(thePed,getElementDimension(localPlayer))
		setElementDimension(theVehicle,getElementDimension(localPlayer))
	end
	
	if(getElementModel(theVehicle) == 425 or getElementModel(getPedOccupiedVehicle(localPlayer)) == 425) then
		return
	end
	
	if(currentState == "classic") then
		setElementAlpha(thePed,50)
		setElementAlpha(theVehicle,50)
		setElementDimension(thePed,getElementDimension(localPlayer))
		setElementDimension(theVehicle,getElementDimension(localPlayer))
	end
	
	if(currentState == "hidden") then
		if(isElementWithinColShape(theVehicle,colSphere)) then
			setElementDimension(thePed,(plrRoom+100))
			setElementDimension(theVehicle,(plrRoom+100))
		else
			setElementDimension(thePed,getElementDimension(localPlayer))
			setElementDimension(theVehicle,getElementDimension(localPlayer))
		end
	end
	
	if(currentState == "totalhidden") then
		setElementDimension(thePed,(plrRoom+100))
		setElementDimension(theVehicle,plrRoom+100)
	end
end

fileDelete("c_fade.lua")