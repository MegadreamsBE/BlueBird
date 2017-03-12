function palm ()
	palmtxd = engineLoadTXD("gta_tree_palm2.txd")
	engineImportTXD(palmtxd, 621 )
	palmdff = engineLoadDFF('veg_palm02.dff', 0)
	engineReplaceModel(palmdff, 621)
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )


 setWaterColor(112,147,219,230)

function mukkestart()
    setRadioChannel(0)
    song = playSound("music.mp3",true)
end

function turnradiooff()
    setRadioChannel(0)
    cancelEvent()
end

function toggleSong()
    if not songOff then
	    setSoundVolume(song,0)
		songOff = true
		removeEventHandler("onClientPlayerRadioSwitch",getRootElement(),turnradiooff)
	else
	    setSoundVolume(song,1)
		songOff = false
		setRadioChannel(0)
		addEventHandler("onClientPlayerRadioSwitch",getRootElement(),turnradiooff)
	end
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),mukkestart)
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),turnradiooff)
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),turnradiooff)
addCommandHandler("musicmusic",toggleSong)
bindKey("m","down","musicmusic")



function onClientResourceStart()
	setCloudsEnabled(false)

	-- Chatbox
	outputChatBox("",255,255,255,true)
	outputChatBox("#aaaaaaPress #ff9900'M' #aaaaaato toggle the music #ff9900on/off", 27, 89, 224, true)
	outputChatBox("",255,255,255,true)

	-- Markers
	marker1a = createMarker(3563.2509765625, -1852.48828125, 2.0969679355621, "corona", 4, 0, 0, 0, 0)
	marker1b = createMarker(4045.7814941406, -1137.3123779297, 43.314144134521, "corona", 4, 0, 0, 0, 0)
	marker2a = createMarker(3558.3701171875, -1766.6943359375, 2.0969679355621, "corona", 4, 0, 0, 0, 0)
	marker2b = createMarker(3971.3251953125, 1254.5849609375, 50.904388427734, "corona", 4, 0, 0, 0, 0)
	marker3a = createMarker(3633.8525390625, -1770.8125, 2.0969679355621, "corona", 4, 0, 0, 0, 0)
	marker3b = createMarker(3877.01171875, -3683.2802734375, 0.019525468349457, "corona", 4, 0, 0, 0, 0)
	marker4a = createMarker(3644.5461425781, -2208.7412109375, 6.3307948112488, "corona", 5, 0, 0, 0, 0)
	marker4b = createMarker(6901.0590820313, -1847.2486572266, 17.424543380737, "checkpoint", 3, 41, 190, 213, 153)
	marker5 = createMarker(1, 2, 3, "corona", 1, 0, 0, 0, 0)
	alreadydid1 = false
	alreadydid2 = false
	alreadydid3 = false
	object1 = createObject ( 985, 3633.6044921875, -1975.8330078125, 0.32554787397385, 0, 0, 0 )
	object2 = createObject ( 985, 3627.6767578125, -1975.8330078125, 0.32554787397385, 0, 0, 0 )
	object3 = createObject ( 985, 3621.9169921875, -1975.8330078125, 0.32554787397385, 0, 0, 0 )
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), onClientResourceStart )

function markerHit(hitPlayer, matchingDimension)
	if source == marker1a then
		local vehicle = getPedOccupiedVehicle(hitPlayer)
		if hitPlayer == getLocalPlayer() then
			if alreadydid1 == false then
				setElementRotation(vehicle, 0, 0, 270)
				setElementPosition(vehicle, 3664.0673828125, -885.93359375, 28.924831390381)
				setVehicleFrozen(vehicle, true)
				setTimer(setVehicleFrozen, 100, 1, vehicle, false)
				fadeCamera ( false, 0.0, 0, 0, 0 )
				setCameraTarget ( getLocalPlayer() )
				setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
			else
				outputChatBox("#ff9900You already did this parcour!", 255, 255, 255, true)
				setElementRotation(vehicle, 0, 0, 90)
				setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
				setVehicleFrozen(vehicle, true)
				setTimer(setVehicleFrozen, 100, 1, vehicle, false)
				fadeCamera ( false, 0.0, 0, 0, 0 )
				setCameraTarget ( getLocalPlayer() )
				setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
			end
		else
			setElementRotation(vehicle, 0, 0, 90)
			setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
		end
	elseif source == marker1b then
		local vehicle = getPedOccupiedVehicle(hitPlayer)
		if hitPlayer == getLocalPlayer() then
			if alreadydid2 == true and alreadydid3 == true then
				setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
				moveObject ( object1, 30000, 3633.6044921875, -1975.8330078125, -3.5791454315186 )
				moveObject ( object2, 30000, 3627.6767578125, -1975.8330078125, -3.5791454315186 )
				moveObject ( object3, 30000, 3621.9169921875, -1975.8330078125, -3.5791454315186 )
			else
				setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			end
			alreadydid1 = true
			outputChatBox("#ff9900You succesfully completed this parcour!", 255, 255, 255, true)
			setElementRotation(vehicle, 0, 0, 90)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
			fadeCamera ( false, 0.0, 0, 0, 0 )
			setCameraTarget ( getLocalPlayer() )
			setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
		else
			setElementRotation(vehicle, 0, 0, 90)
			setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
		end
	elseif source == marker2a then
		local vehicle = getPedOccupiedVehicle(hitPlayer)
		if hitPlayer == getLocalPlayer() then
			if alreadydid2 == false then
				setElementRotation(vehicle, 0, 0, 270)
				setElementPosition(vehicle, 3463.8984375, 543.22302246094, 45.597114562988)
				setVehicleFrozen(vehicle, true)
				setTimer(setVehicleFrozen, 100, 1, vehicle, false)
				fadeCamera ( false, 0.0, 0, 0, 0 )
				setCameraTarget ( getLocalPlayer() )
				setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
			else
				outputChatBox("#ff9900You already did this parcour!", 255, 255, 255, true)
				setElementRotation(vehicle, 0, 0, 90)
				setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
				setVehicleFrozen(vehicle, true)
				setTimer(setVehicleFrozen, 100, 1, vehicle, false)
				fadeCamera ( false, 0.0, 0, 0, 0 )
				setCameraTarget ( getLocalPlayer() )
				setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
			end
		else
			setElementRotation(vehicle, 0, 0, 90)
			setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
		end
	elseif source == marker2b then
		local vehicle = getPedOccupiedVehicle(hitPlayer)
		if hitPlayer == getLocalPlayer() then
			if alreadydid1 == true and alreadydid3 == true then
				setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
				moveObject ( object1, 30000, 3633.6044921875, -1975.8330078125, -3.5791454315186 )
				moveObject ( object2, 30000, 3627.6767578125, -1975.8330078125, -3.5791454315186 )
				moveObject ( object3, 30000, 3621.9169921875, -1975.8330078125, -3.5791454315186 )
			else
				setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			end
			alreadydid2 = true
			outputChatBox("#ff9900You succesfully completed this parcour!", 255, 255, 255, true)
			setElementRotation(vehicle, 0, 0, 90)
			setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
			fadeCamera ( false, 0.0, 0, 0, 0 )
			setCameraTarget ( getLocalPlayer() )
			setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
		else
			setElementRotation(vehicle, 0, 0, 90)
			setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
		end
	elseif source == marker3a then
		local vehicle = getPedOccupiedVehicle(hitPlayer)
		if hitPlayer == getLocalPlayer() then
			if alreadydid3 == false then
				setElementRotation(vehicle, 0, 0, 270)
				setElementPosition(vehicle, 3369.3454589844, -3384.7404785156, 7.6935997009277)
				setVehicleFrozen(vehicle, true)
				setTimer(setVehicleFrozen, 100, 1, vehicle, false)
				fadeCamera ( false, 0.0, 0, 0, 0 )
				setCameraTarget ( getLocalPlayer() )
				setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
			else
				outputChatBox("#ff9900You already did this parcour!", 255, 255, 255, true)
				setElementRotation(vehicle, 0, 0, 90)
				setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
				setVehicleFrozen(vehicle, true)
				setTimer(setVehicleFrozen, 100, 1, vehicle, false)
				fadeCamera ( false, 0.0, 0, 0, 0 )
				setCameraTarget ( getLocalPlayer() )
				setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
			end
		else
			setElementRotation(vehicle, 0, 0, 270)
			setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
		end
	elseif source == marker3b then
		local vehicle = getPedOccupiedVehicle(hitPlayer)
		if hitPlayer == getLocalPlayer() then
			if alreadydid1 == true and alreadydid2 == true then
				setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
				moveObject ( object1, 30000, 3633.6044921875, -1975.8330078125, -3.5791454315186 )
				moveObject ( object2, 30000, 3627.6767578125, -1975.8330078125, -3.5791454315186 )
				moveObject ( object3, 30000, 3621.9169921875, -1975.8330078125, -3.5791454315186 )
			else
				setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			end
			alreadydid3 = true
			outputChatBox("#ff9900You succesfully completed this parcour!", 255, 255, 255, true)
			setElementRotation(vehicle, 0, 0, 90)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
			fadeCamera ( false, 0.0, 0, 0, 0 )
			setCameraTarget ( getLocalPlayer() )
			setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
		else
			setElementRotation(vehicle, 0, 0, 90)
			setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
		end
	elseif source == marker4a then
		local vehicle = getPedOccupiedVehicle(hitPlayer)
		if hitPlayer == getLocalPlayer() then
			if (alreadydid1 == true) and (alreadydid2 == true) and (alreadydid3 == true) then
				setElementRotation(vehicle, 0, 0, 270)
				setElementPosition(vehicle, 5198.6245117188, -1809.3879394531, 1.5188682079315)
				setVehicleFrozen(vehicle, true)
				setTimer(setVehicleFrozen, 100, 1, vehicle, false)
				fadeCamera ( false, 0.0, 0, 0, 0 )
				setCameraTarget ( getLocalPlayer() )
				setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
			else
				outputChatBox("#ff9900You have to do all parcours!", 255, 255, 255, true)
				setElementRotation(vehicle, 0, 0, 90)
				setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
				setVehicleFrozen(vehicle, true)
				setTimer(setVehicleFrozen, 100, 1, vehicle, false)
				fadeCamera ( false, 0.0, 0, 0, 0 )
				setCameraTarget ( getLocalPlayer() )
				setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
			end
		else
			setElementRotation(vehicle, 0, 0, 90)
			setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
		end
	elseif source == marker4b then
		local vehicle = getPedOccupiedVehicle(hitPlayer)
		if hitPlayer == getLocalPlayer() then
			setElementRotation(vehicle, 0, 0, 270)
			setElementPosition(vehicle, 3624.0161132813, -1815.0863037109, 27.300060272217)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
			fadeCamera ( false, 0.0, 0, 0, 0 )
			setCameraTarget ( getLocalPlayer() )
			setTimer(fadeCamera, 100, 1, true, 0.0, 0, 0, 0)
		else
			setElementRotation(vehicle, 0, 0, 270)
			setElementPosition(vehicle, 3775.4228515625, -1815.0478515625, 2.393679857254)
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
		end
	elseif source == marker5 then
		local vehicle = getPedOccupiedVehicle(hitPlayer)
		if hitPlayer == getLocalPlayer() then
			x1, y1, z1 = getElementRotation(vehicle)
			getTickStart = getTickCount()
			count = 0
			setVehicleFrozen(vehicle, true)
			addEventHandler ( "onClientPreRender", getRootElement(), somethingfor )
		else
			setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 5000, 1, vehicle, false)
		end
	elseif source == jump5 then
		local vehicle = getPedOccupiedVehicle(hitPlayer)
		setElementRotation(vehicle, 0, 0, 0)
		setElementPosition(vehicle, 5941.4887695313, -1282.4050292969, 6.088677406311)
		setVehicleFrozen(vehicle, true)
		setTimer(setVehicleFrozen, 100, 1, vehicle, false)
		speedx, speedy, speedz = getElementVelocity(vehicle)
		setElementVelocity(vehicle, 1, 0, speedz+1.2)
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), markerHit )

function somethingfor()
	vehicle = getPedOccupiedVehicle(getLocalPlayer())
	if (getTickCount() - getTickStart <= 4000) then
		if count == 0 then
			--sound3 = playSound( "3.mp3", false )
			count = 1
		end
		local elapsedTime = getTickCount() - (getTickStart)
		local duration = (getTickStart+4000) - (getTickStart)
		local progress = elapsedTime / duration
		if x1 >= 180 then
			a = 360
		else
			a = 0
		end
		if y1 >= 270 then
			b = 450
		else
			b = 90
		end
		if z1 >= 90 then
			c = 270
		else
			c = -90
		end
		local x2, y2, z2 = interpolateBetween (
			x1, y1, z1,
			a, b, c,
			progress, "InOutQuad")-- 0 , 90 , 270
		setElementPosition(vehicle, 4178.7397460938, -1705.4927978516, 2989.4790039063)
		setElementRotation(vehicle, x2, y2, z2)
	elseif getTickCount() - getTickStart <= 5000 then
		setElementRotation(vehicle, 0, 90, 270)
	elseif getTickCount() - getTickStart > 5000 then
		setVehicleFrozen( vehicle, false)
		setElementVelocity(vehicle, 5, 0, 0)
		removeEventHandler ( "onClientPreRender", getRootElement(), somethingfor )
	end
end
