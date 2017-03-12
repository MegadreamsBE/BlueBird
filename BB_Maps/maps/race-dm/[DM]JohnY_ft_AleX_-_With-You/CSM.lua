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
table.insert(noScaleTab, createObject(8558,4773.1811523438,-1206.3616943359,26.046251296997,25.258544921875,0,90))
table.insert(noScaleTab, createObject(8558,4768.4575195313,-1207.7821044922,28.072072982788,21.167663574219,0,90))
table.insert(noScaleTab, createObject(8558,4763.6015625,-1209.2026367188,29.755760192871,17.076751708984,0,90))
table.insert(noScaleTab, createObject(8558,4758.6376953125,-1210.623046875,31.088722229004,12.98583984375,0,90))
table.insert(noScaleTab, createObject(8558,4753.5913085938,-1212.0434570313,32.064170837402,8.8949279785156,0,90))
table.insert(noScaleTab, createObject(8558,4748.48828125,-1213.4639892578,32.677139282227,4.8040161132813,0,90))
table.insert(noScaleTab, createObject(8558,4743.3544921875,-1214.8843994141,32.924503326416,0.71310424804688,0,90))
table.insert(noScaleTab, createObject(8558,4738.2163085938,-1216.3048095703,32.804996490479,356.62219238281,0,90))
table.insert(noScaleTab, createObject(8558,4708.7416992188,-1224.8276367188,24.54753112793,332.07678222656,0,90))
table.insert(noScaleTab, createObject(8558,4713.3657226563,-1223.4071044922,26.790767669678,336.16766357422,0,90))
table.insert(noScaleTab, createObject(8558,4718.138671875,-1221.9866943359,28.698392868042,340.25854492188,0,90))
table.insert(noScaleTab, createObject(8558,4723.03515625,-1220.5662841797,30.260684967041,344.34948730469,0,90))
table.insert(noScaleTab, createObject(8558,4728.0302734375,-1219.1457519531,31.469686508179,348.4404296875,0,90))
table.insert(noScaleTab, createObject(8558,4733.099609375,-1217.7253417969,32.319232940674,352.53137207031,0,90))

table.insert(noScaleTab, createObject(3458,5022.03125,-1172.4306640625,11.789600372314,270,0,0))
table.insert(noScaleTab, createObject(8558,5022.03125,-1173.48046875,12.822199821472,0,0,0))
table.insert(noScaleTab, createObject(8558,5017.0126953125,-1173.48046875,12.907897949219,0,1.95556640625,0))
table.insert(noScaleTab, createObject(8558,5011.9990234375,-1173.48046875,13.164890289307,0,3.9111328125,0))
table.insert(noScaleTab, createObject(8558,5006.998046875,-1173.48046875,13.592880249023,0,5.86669921875,0))
table.insert(noScaleTab, createObject(8558,5002.0146484375,-1173.48046875,14.191366195679,0,7.822265625,0))
table.insert(noScaleTab, createObject(8558,4999.8349609375,-1173.4736328125,14.261699676514,0,9.77783203125,0))
table.insert(noScaleTab, createObject(8558,4524.8662109375,-1226.248046875,32.183700561523,0,30.267333984375,0))
table.insert(noScaleTab, createObject(6959,6432.98046875,-1280.83984375,57.101001739502,0,54.992065429688,0))
table.insert(noScaleTab, createObject(3458,6457.5634765625,-1258.0537109375,19.662006378174,50.064697265625,0,90))
table.insert(noScaleTab, createObject(3458,6460.986328125,-1253.943359375,15.913129806519,45.1318359375,0,90))
table.insert(noScaleTab, createObject(3458,6464.71875,-1249.833984375,12.472401618958,40.198974609375,0,90))
table.insert(noScaleTab, createObject(3458,6473.0009765625,-1241.615234375,6.614818572998,30.338745117188,0,90))
table.insert(noScaleTab, createObject(3458,6468.7333984375,-1245.724609375,9.3652954101563,35.26611328125,0,90))
table.insert(noScaleTab, createObject(3458,6477.48828125,-1237.5048828125,4.2413291931152,25.405883789063,0,90))
table.insert(noScaleTab, createObject(3458,6482.1630859375,-1233.3955078125,2.2624053955078,20.473022460938,0,90))
table.insert(noScaleTab, createObject(3458,6486.9912109375,-1229.2861328125,0.69269180297852,15.540161132813,0,90))
table.insert(noScaleTab, createObject(3458,6491.9365234375,-1225.1767578125,-0.4561824798584,10.61279296875,0,90))
table.insert(noScaleTab, createObject(3458,6502.0302734375,-1216.95703125,-1.4605846405029,0.7470703125,0,90))
table.insert(noScaleTab, createObject(3458,6496.9619140625,-1221.0673828125,-1.1757183074951,5.679931640625,0,90))
table.insert(noScaleTab, createObject(3458,6539.693359375,-1184.0810546875,11.48964881897,321.29516601563,0,90))
table.insert(noScaleTab, createObject(3458,6535.5986328125,-1188.1904296875,8.4888362884521,326.22802734375,0,90))
table.insert(noScaleTab, createObject(3458,6531.2607421875,-1192.2998046875,5.8511486053467,331.16088867188,0,90))
table.insert(noScaleTab, createObject(3458,6526.712890625,-1196.4091796875,3.596097946167,336.08825683594,0,90))
table.insert(noScaleTab, createObject(3458,6521.9873046875,-1200.51953125,1.7403907775879,341.02111816406,0,90))
table.insert(noScaleTab, createObject(3458,6517.1201171875,-1204.62890625,0.29776573181152,345.95397949219,0,90))
table.insert(noScaleTab, createObject(3458,6512.146484375,-1208.73828125,-0.72110748291016,350.88684082031,0,90))
table.insert(noScaleTab, createObject(3458,6507.1044921875,-1212.84765625,-1.3086681365967,355.81420898438,0,90))
table.insert(noScaleTab, createObject(8558,7285.119140625,-276.4296875,4.3702998161316,0,0,0))
table.insert(noScaleTab, createObject(8558,7314.0400390625,-276.4296875,4.3702998161316,0,0,0))
table.insert(noScaleTab, createObject(8558,4255.841796875,-1218.6025390625,24.568500518799,0,179.99450683594,90))
table.insert(noScaleTab, createObject(8558,4255.841796875,-1217.8525390625,20.211999893188,0,0,90))