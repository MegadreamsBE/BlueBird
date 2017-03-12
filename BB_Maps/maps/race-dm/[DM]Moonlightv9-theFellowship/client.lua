local startAnimationMarker = createMarker(4214.0034179688, -1895.083984375, 15.778568267822, "corona", 10, 0, 0, 0, 0)
local stopAnimationMarker = createMarker(4311.3544921875, -1895.083984375, 39.955215454102, "corona", 10, 0, 0, 0, 0)

local plane = createObject(1681, 4222.890625, -1801.6436767578, 63, 353.95645141602, 359.56072998047, 260.84350585938)
setObjectScale(plane, 2)

local tower = createObject(4570, 4375.435546875, -1822.1572265625, 35.360569000244)

addEventHandler("onClientMarkerHit", root,
function(hitElement, sameDimension)
	if(hitElement ~= localPlayer or not sameDimension)then return end
	if(source == startAnimationMarker)then
		destroyElement(source)
		setGameSpeed(0.5)
		local rotX, rotY, rotZ = getElementRotation(plane)
		moveObject(plane, 2000, 4340.900390625, -1821.11328125, 49.849555969238, 1, 50.267944335938, -2, "Linear")
		setTimer(function()
			createExplosion(4340.900390625, -1821.11328125, 49.849555969238, 7, true, 1.0, false)
			createExplosion(4345.900390625, -1821.11328125, 49.849555969238, 7, true, 1.0, false)
			createExplosion(4350.900390625, -1821.11328125, 49.849555969238, 7, true, 1.0, false)
			createExplosion(4355.900390625, -1821.11328125, 49.849555969238, 7, true, 1.0, false)
			createExplosion(4360.900390625, -1821.11328125, 49.849555969238, 7, true, 1.0, false)
			
			createExplosion(4250.86328125, -1894.41015625, 12, 7, true, 1.0, false)
			setTimer(function()
				createExplosion(4255.86328125, -1894.41015625, 12, 7, true, 1.0, false)
			end, 500, 1)
			setTimer(function()
				createExplosion(4260.86328125, -1894.41015625, 12, 7, true, 1.0, false)
			end, 1000, 1)
			setTimer(function()
				createExplosion(4261.86328125, -1894.41015625, 12, 7, true, 1.0, false)
			end, 2000, 1)
			destroyElement(plane)
		end, 2000, 1)
		setTimer(function()
			createExplosion(4355.900390625, -1821.11328125, 49.849555969238, 7, true, 1.0, false)
			createExplosion(4360.900390625, -1821.11328125, 49.849555969238, 7, true, 1.0, false)
			local x, y, z = getElementPosition(tower)
			moveObject(tower, 4000, x, y, -27.384418487549, 0, 0, 0, "InQuad")
		end, 2100, 1)
	elseif(source == stopAnimationMarker)then
		destroyElement(source)
		setGameSpeed(1.0)
	end
end)

setWaterColor(112,147,219,230)

setCloudsEnabled ( false )
outputChatBox("",255,255,255,true)
outputChatBox ("#aaaaaaPress #299F34'M' #aaaaaato toggle the music #299F34on/off!", 27, 89, 224, true)
outputChatBox("",255,255,255,true)


function markers()
	marker1 = createMarker(4870.86328125, -1492.1285400391, 7.0876779556274,"corona",5, 0, 0, 0, 0)
	marker2 = createMarker(4870.86328125, -1361.1727294922, 1.5876779556274,"corona",5, 0, 0, 0, 0)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), markers)

function MarkerHit ( hitPlayer, matchingDimension )
	vehicle = getPedOccupiedVehicle ( hitPlayer )
	if hitPlayer ~= localPlayer then return end
	if source == marker1 then
		setGameSpeed(0.5)
	elseif source == marker2 then
		setGameSpeed(1)
	end

end

addEventHandler("onClientMarkerHit", root, MarkerHit)


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


-- * Collision/Scale object Manager * --
noCollsTab = {}
noScaleTab = {}
addEventHandler("onClientResourceStart", resourceRoot, function()
	local i = 1
	while(i <= #noCollsTab)do
		setElementCollisionsEnabled(noCollsTab[i], false)
		i=i+1
	end
	local j = 1
	while(j <= #noScaleTab)do
		setObjectScale(noScaleTab[j], 0)
		j=j+1
	end
end
)
table.insert(noScaleTab, createObject(8558,5302.3237304688,87.553436279297,22.338851928711,0,270,4.3591613769531))
table.insert(noScaleTab, createObject(8558,5301.7866210938,92.665405273438,22.338851928711,0,270,7.6318969726563))
table.insert(noScaleTab, createObject(8558,5300.958984375,97.738395690918,22.338851928711,0,270,10.904632568359))
table.insert(noScaleTab, createObject(8558,5299.8427734375,102.75584411621,22.338851928711,0,270,14.177368164063))
table.insert(noScaleTab, createObject(8558,5298.4418945313,107.70140075684,22.338851928711,0,270,17.450103759766))
table.insert(noScaleTab, createObject(8558,5296.7612304688,112.55891418457,22.338851928711,0,270,20.722808837891))
table.insert(noScaleTab, createObject(8558,5294.8061523438,117.31256103516,22.338851928711,0,270,23.995483398438))
table.insert(noScaleTab, createObject(8558,5302.5678710938,82.419151306152,22.338851928711,0,270,1.08642578125))
table.insert(noScaleTab, createObject(8558,5287.3608398438,130.79718017578,22.338851928711,0,270,33.813720703125))
table.insert(noScaleTab, createObject(8558,5284.3793945313,134.98440551758,22.338851928711,0,270,37.086456298828))
table.insert(noScaleTab, createObject(8558,5290.0981445313,126.44659423828,22.338851928711,0,270,30.540985107422))
table.insert(noScaleTab, createObject(8558,5292.5825195313,121.94682312012,22.338851928711,0,270,27.268280029297))
table.insert(noScaleTab, createObject(8558,5281.1640625,138.99459838867,22.338851928711,0,270,40.359191894531))
table.insert(noScaleTab, createObject(8558,5277.7250976563,142.81469726563,22.338851928711,0,270,43.631896972656))
table.insert(noScaleTab, createObject(8558,5274.0732421875,146.43225097656,22.338851928711,0,270,46.904632568359))
table.insert(noScaleTab, createObject(8558,5270.2211914063,149.83540344238,22.338851928711,0,270,50.177368164063))
table.insert(noScaleTab, createObject(8558,5266.1811523438,153.01312255859,22.338851928711,0,270,53.450073242188))
table.insert(noScaleTab, createObject(8558,5233.8090820313,168.17404174805,22.338851928711,0,270,76.359161376953))
table.insert(noScaleTab, createObject(8558,5238.767578125,166.81970214844,22.338851928711,0,270,73.08642578125))
table.insert(noScaleTab, createObject(8558,5243.640625,165.18447875977,22.338851928711,0,270,69.813720703125))
table.insert(noScaleTab, createObject(8558,5248.4125976563,163.2737121582,22.338851928711,0,270,66.540985107422))
table.insert(noScaleTab, createObject(8558,5253.0673828125,161.09368896484,22.338851928711,0,270,63.268249511719))
table.insert(noScaleTab, createObject(8558,5257.5903320313,158.65144348145,22.338851928711,0,270,59.995544433594))
table.insert(noScaleTab, createObject(8558,5261.9663085938,155.95498657227,22.338851928711,0,270,56.722808837891))
table.insert(noScaleTab, createObject(8558,5228.7817382813,169.24313354492,22.338851928711,0,270,79.631927490234))
table.insert(noScaleTab, createObject(8558,5223.701171875,170.0234375,22.33885383606,0,270,82.904663085938))
table.insert(noScaleTab, createObject(8558,5218.583984375,170.5124206543,22.33885383606,0,270,86.177368164063))
table.insert(noScaleTab, createObject(8558,5213.4477539063,170.70852661133,22.33885383606,0,270,89.450073242188))
table.insert(noScaleTab, createObject(8558,5208.30859375,170.6110534668,22.33885383606,0,270,92.722808837891))

table.insert(noScaleTab, createObject(8171,3217.380859375,1345.9990234375,16.605598449707,2.8070068359375,162.509765625,92.120361328125))
table.insert(noScaleTab, createObject(8171,3207.748046875,1381.0615234375,28.213766098022,2.8070068359375,162.509765625,92.120361328125))
table.insert(noScaleTab, createObject(3458,3756.2202148438,2241.1494140625,3.7799999713898,0,0,0))
table.insert(noScaleTab, createObject(3458,3784.9223632813,2241.1494140625,4.3130044937134,0,357,0))
table.insert(noScaleTab, createObject(3458,3788.671875,2241.1494140625,4.3130044937134,0,353.74523925781,0))
table.insert(noScaleTab, createObject(3458,3797.671875,2241.1494140625,4.8005990982056,0,348.49328613281,0))
table.insert(noScaleTab, createObject(3458,3805.7797851563,2241.1494140625,5.7310028076172,0,343.74182128906,0))
table.insert(noScaleTab, createObject(3458,3814.8447265625,2241.1494140625,7.8498001098633,0,340.740234375,0))
table.insert(noScaleTab, createObject(3458,3822.1435546875,2241.1494140625,9.7554130554199,0,336.98547363281,0))
table.insert(noScaleTab, createObject(3458,3832.8935546875,2241.1494140625,14.284021377563,0,332.73364257813,0))
table.insert(noScaleTab, createObject(3458,3845.1435546875,2241.1494140625,20.595609664917,0,330.48193359375,0))
table.insert(noScaleTab, createObject(3458,3852.1694335938,2241.1494140625,23.72261428833,0,325.72973632813,0))
table.insert(noScaleTab, createObject(3458,3948.4182128906,2267.6047363281,74.761276245117,333.33984375,112.37927246094,132.54110717773))
table.insert(noScaleTab, createObject(3458,3943.7026367188,2266.267578125,85.996528625488,0,325.72814941406,0))
table.insert(noScaleTab, createObject(3458,3937.3271484375,2261.2202148438,81.68091583252,0,325.72814941406,0))
table.insert(noScaleTab, createObject(3458,3945.0024414063,2264.580078125,72.433670043945,332.60949707031,111.45330810547,130.50347900391))
table.insert(noScaleTab, createObject(3458,3941.5034179688,2261.6982421875,70.049270629883,331.9091796875,110.49243164063,128.43927001953))
table.insert(noScaleTab, createObject(3458,3925.7287597656,2256.1643066406,73.78328704834,0,325.72814941406,0))
table.insert(noScaleTab, createObject(3458,3937.9250488281,2258.9626464844,67.610847473145,331.24005126953,109.49713134766,126.3486328125))
table.insert(noScaleTab, createObject(3458,3930.5471191406,2253.9426269531,62.583404541016,330.00091552734,107.40643310547,122.08877563477))
table.insert(noScaleTab, createObject(3458,3934.271484375,2256.3764648438,65.12126159668,330.60357666016,108.46817016602,124.23165893555))
table.insert(noScaleTab, createObject(3458,3926.7563476563,2251.6643066406,60.00023651123,329.43334960938,106.31289672852,119.92044067383))
table.insert(noScaleTab, createObject(3458,3922.9035644531,2249.5437011719,57.374771118164,328.90222167969,105.18878173828,117.72741699219))
table.insert(noScaleTab, createObject(3458,3918.9931640625,2247.5837402344,54.710067749023,328.40856933594,104.03555297852,115.51065063477))
table.insert(noScaleTab, createObject(3458,3915.0297851563,2245.7863769531,52.00923538208,327.95355224609,102.85470581055,113.27117919922))
table.insert(noScaleTab, createObject(3458,3906.9624023438,2242.6879882813,46.511817932129,327.16387939453,100.41741943359,108.7294921875))
table.insert(noScaleTab, createObject(3458,3898.7390136719,2240.2629394531,40.908142089844,326.54089355469,97.893280029297,104.11511230469))
table.insert(noScaleTab, createObject(3458,3911.0178222656,2244.1538085938,49.275421142578,327.53833007813,101.64801025391,111.01025390625))
table.insert(noScaleTab, createObject(3458,3902.8676757813,2241.3903808594,43.721641540527,326.83111572266,99.165100097656,106.43048095703))
table.insert(noScaleTab, createObject(3458,3890.3979492188,2238.5227050781,35.224342346191,326.09106445313,95.301208496094,99.443267822266))
table.insert(noScaleTab, createObject(3458,3886.1955566406,2237.9118652344,32.360664367676,325.9326171875,93.986297607422,97.09130859375))
table.insert(noScaleTab, createObject(3458,3877.7512207031,2237.212890625,26.606447219849,325.75091552734,91.332733154297,92.367156982422))
table.insert(noScaleTab, createObject(3458,3873.5192871094,2237.1254882813,23.72261428833,325.72814941406,90,90))
table.insert(noScaleTab, createObject(3458,3881.9782714844,2237.4750976563,29.486917495728,325.81909179688,92.662475585938,94.731781005859))
table.insert(noScaleTab, createObject(3458,3894.5808105469,2239.306640625,38.074607849121,326.2939453125,96.6044921875,101.78530883789))
table.insert(noScaleTab, createObject(3458,3911.8505859375,2251.1240234375,64.326232910156,0,325.72814941406,0))
table.insert(noScaleTab, createObject(3458,3898.9775390625,2246.0817871094,55.563068389893,0,325.72814941406,0))
table.insert(noScaleTab, createObject(3458,3885.4775390625,2241.1494140625,46.404926300049,0,325.72814941406,0))