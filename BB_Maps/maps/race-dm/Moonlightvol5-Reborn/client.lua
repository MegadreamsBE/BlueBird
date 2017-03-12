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
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox("",255,255,255,true)
outputChatBox ("#299F34Moonlight #aaaaaapresents his #299F34vol5 #aaaaaacalled #299F34'The Rebirth'", 27, 89, 224, true)
outputChatBox ("#aaaaaaPress #299F34'M' #aaaaaato toggle the music #299F34on/off!", 27, 89, 224, true)



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
table.insert(noScaleTab, createObject(3458,4930.6850585938,-2124.3615722656,19.03688621521,2.2271728515625,0,90))
table.insert(noScaleTab, createObject(3458,4925.5712890625,-2124.3615722656,19.32328414917,4.1837158203125,0,90))
table.insert(noScaleTab, createObject(3458,4915.3779296875,-2124.3615722656,20.279300689697,4.9675903320313,0,90))
table.insert(noScaleTab, createObject(3458,4935.8061523438,-2124.3615722656,18.925247192383,0.27066040039063,0,90))
table.insert(noScaleTab, createObject(3458,4920.4702148438,-2124.3615722656,19.784111022949,6.1402282714844,0,90))
table.insert(noScaleTab, createObject(3458,4910.2763671875,-2124.3615722656,20.670166015625,3.7949523925781,0,90))
table.insert(noScaleTab, createObject(3458,4905.16796875,-2124.3615722656,20.956550598145,2.622314453125,0,90))
table.insert(noScaleTab, createObject(3458,4900.0546875,-2124.3615722656,21.138326644897,1.44970703125,0,90))
table.insert(noScaleTab, createObject(3458,4894.9384765625,-2124.3615722656,21.215419769287,0.27703857421875,0,90))
table.insert(noScaleTab, createObject(3458,4884.7075195313,-2124.3615722656,21.055484771729,357.93176269531,0,90))
table.insert(noScaleTab, createObject(3458,4889.822265625,-2124.3615722656,21.187805175781,359.10437011719,0,90))
table.insert(noScaleTab, createObject(3458,4874.4912109375,-2124.3615722656,20.477005004883,355.58648681641,0,90))
table.insert(noScaleTab, createObject(3458,4879.5961914063,-2124.3615722656,20.818517684937,356.75915527344,0,90))
table.insert(noScaleTab, createObject(3458,4864.3071289063,-2124.3615722656,19.480949401855,353.2412109375,0,90))
table.insert(noScaleTab, createObject(3458,4869.3940429688,-2124.3615722656,20.031085968018,354.41387939453,0,90))
table.insert(noScaleTab, createObject(3458,4859.2329101563,-2124.3615722656,18.826829910278,352.06860351563,0,90))
table.insert(noScaleTab, createObject(3458,4854.1728515625,-2124.3615722656,18.068992614746,350.89587402344,0,90))
table.insert(noScaleTab, createObject(3458,4849.1293945313,-2124.3615722656,17.207763671875,349.72338867188,0,90))
table.insert(noScaleTab, createObject(3458,4844.1044921875,-2124.3615722656,16.243495941162,348.55065917969,0,90))
table.insert(noScaleTab, createObject(3458,4839.1005859375,-2124.3615722656,15.176599502563,347.37805175781,0,90))
table.insert(noScaleTab, createObject(3458,4834.119140625,-2124.3615722656,14.007518768311,346.20532226563,0,90))
table.insert(noScaleTab, createObject(3458,4829.1630859375,-2124.3615722656,12.736743927002,345.03271484375,0,90))

table.insert(noScaleTab, createObject(3458,4981.2158203125,-2124.3615722656,25.739095687866,342.66198730469,0,90))
table.insert(noScaleTab, createObject(3458,4976.3012695313,-2124.3615722656,24.296417236328,344.61853027344,0,90))
table.insert(noScaleTab, createObject(3458,4971.3403320313,-2124.3615722656,23.022369384766,346.57507324219,0,90))
table.insert(noScaleTab, createObject(8838,6430.6655273438,-2522.8312988281,64.100143432617,0,90,181.13922119141))
table.insert(noScaleTab, createObject(8838,6430.359375,-2517.7038574219,64.100143432617,0,90,185.69616699219))
table.insert(noScaleTab, createObject(8838,6430.5629882813,-2527.966796875,64.100143432617,0,90,176.58227539063))
table.insert(noScaleTab, createObject(8838,4258.1982421875,-2235.5712890625,0.36076971888542,0,90,38.842163085938))