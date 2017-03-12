txd = engineLoadTXD("palmera.txd")
engineImportTXD(txd, 622)
dff = engineLoadDFF("palmera.dff", 622)
engineReplaceModel(dff, 622)


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
 
 
setCloudsEnabled ( false )
outputChatBox("",255,255,255,true)
outputChatBox ("#aaaaaaPress #299F34'M' #aaaaaato toggle the music #299F34on/off!", 27, 89, 224, true)
outputChatBox("",255,255,255,true)



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
table.insert(noScaleTab, createObject(3458,3645.8825683594,-1952.32421875,143.6579284668,354.51733398438,0,90))
table.insert(noScaleTab, createObject(3458,3548.5888671875,-1952.32421875,189.55569458008,76.788940429688,0,90))
table.insert(noScaleTab, createObject(3458,3549.966796875,-1952.32421875,184.62452697754,71.987915039063,0,90))
table.insert(noScaleTab, createObject(3458,3551.751953125,-1952.32421875,179.82595825195,67.186889648438,0,90))
table.insert(noScaleTab, createObject(3458,3553.9326171875,-1952.32421875,175.19361877441,62.385864257813,0,90))
table.insert(noScaleTab, createObject(3458,3556.494140625,-1952.32421875,170.76002502441,57.584838867188,0,90))
table.insert(noScaleTab, createObject(3458,3559.4169921875,-1952.32421875,166.55625915527,52.789306640625,0,90))
table.insert(noScaleTab, createObject(3458,3574.2744140625,-1952.32421875,152.59628295898,33.59619140625,0,90))
table.insert(noScaleTab, createObject(3458,3578.654296875,-1952.32421875,149.9441986084,28.795166015625,0,90))
table.insert(noScaleTab, createObject(3458,3583.240234375,-1952.32421875,147.66789245605,23.994140625,0,90))
table.insert(noScaleTab, createObject(3458,3588.0009765625,-1952.32421875,145.78332519531,19.193115234375,0,90))
table.insert(noScaleTab, createObject(3458,3592.90234375,-1952.32421875,144.3037109375,14.39208984375,0,90))
table.insert(noScaleTab, createObject(3458,3597.9111328125,-1952.32421875,143.23945617676,9.5965576171875,0,90))

table.insert(noScaleTab, createObject(3458,3658.578125,-1952.32421875,145.96492004395,201.58264160156,179.99450683594,270))
table.insert(noScaleTab, createObject(3458,3658.4494628906,-1952.32421875,146.03688049316,342.81530761719,359.99462890625,90.00048828125))
table.insert(noScaleTab, createObject(3458,3663.3720703125,-1952.32421875,147.76271057129,199.52270507813,179.99450683594,270))
table.insert(noScaleTab, createObject(3458,3668.2275390625,-1952.32421875,149.38725280762,197.46826171875,179.99450683594,270))
table.insert(noScaleTab, createObject(3458,3673.1376953125,-1952.32421875,150.83645629883,195.40832519531,179.99450683594,270))
table.insert(noScaleTab, createObject(3458,3678.09765625,-1952.32421875,152.10845947266,193.35388183594,179.99450683594,270))
table.insert(noScaleTab, createObject(3458,3683.099609375,-1952.32421875,153.20161437988,191.2939453125,179.99450683594,270))
table.insert(noScaleTab, createObject(3458,3688.13671875,-1952.32421875,154.11451721191,189.23950195313,179.99450683594,270))
table.insert(noScaleTab, createObject(3458,3693.205078125,-1952.32421875,154.8459777832,187.18505859375,179.99450683594,270))
table.insert(noScaleTab, createObject(8838,4007.892578125,-1952.3095703125,100.5923538208,329.55688476563,0,90))
table.insert(noScaleTab, createObject(8838,4003.43359375,-1952.3095703125,98.073257446289,331.51245117188,0,90))
table.insert(noScaleTab, createObject(3458,4007.892578125,-1952.3095703125,100.59057617188,329.55688476563,0,90))
table.insert(noScaleTab, createObject(3458,4003.43359375,-1952.3095703125,98.071479797363,331.51245117188,0,90))
table.insert(noScaleTab, createObject(3458,3998.890625,-1952.3095703125,95.706100463867,333.47351074219,0,90))
table.insert(noScaleTab, createObject(3458,3994.2685546875,-1952.3095703125,93.497215270996,335.42907714844,0,90))
table.insert(noScaleTab, createObject(3458,3989.5751953125,-1952.3095703125,91.447380065918,337.38464355469,0,90))
table.insert(noScaleTab, createObject(8838,3984.814453125,-1952.3095703125,89.560768127441,339.34020996094,0,90))
table.insert(noScaleTab, createObject(3458,3984.814453125,-1952.3095703125,89.55899810791,339.34020996094,0,90))
table.insert(noScaleTab, createObject(8838,3979.9912109375,-1952.3095703125,87.836029052734,341.29577636719,0,90))
table.insert(noScaleTab, createObject(3458,3979.9912109375,-1952.3095703125,87.834259033203,341.29577636719,0,90))
table.insert(noScaleTab, createObject(3458,3975.1123046875,-1952.3095703125,86.275192260742,343.25134277344,0,90))
table.insert(noScaleTab, createObject(3458,3970.18359375,-1952.3095703125,84.883590698242,345.21240234375,0,90))
table.insert(noScaleTab, createObject(3458,3965.208984375,-1952.3095703125,83.661102294922,347.16796875,0,90))
table.insert(noScaleTab, createObject(6959,4162.8994140625,-2395.4348144531,44.321643829346,0,90,150.08972167969))
table.insert(noScaleTab, createObject(6959,4182.5986328125,-2361.193359375,44.321643829346,0,90,150.08972167969))
table.insert(noScaleTab, createObject(6959,4202.50390625,-2326.5908203125,44.321643829346,0,90,150.08972167969))
