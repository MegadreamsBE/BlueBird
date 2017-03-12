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
table.insert(noCollsTab, createObject(6959,2096.7517089844,-1617.2177734375,2001.5577392578,0,0,0))
table.insert(noCollsTab, createObject(8558,2073.5339355469,-1617.1689453125,2000,0,0,90))
table.insert(noCollsTab, createObject(6959,2050.3151855469,-1617.2177734375,2001.5577392578,0,0,0))
table.insert(noCollsTab, createObject(8558,2027.0999755859,-1617.1689453125,2000,0,0,90))
table.insert(noCollsTab, createObject(8558,2016.8636474609,-1617.1689453125,2000.3497314453,3.9130554199219,0,90))
table.insert(noCollsTab, createObject(8558,2021.9787597656,-1617.1689453125,2000.0874023438,1.9565124511719,0,90))
table.insert(noCollsTab, createObject(8558,2011.7603759766,-1617.1689453125,2000.7863769531,5.8695678710938,0,90))
table.insert(noCollsTab, createObject(8558,2006.6749267578,-1617.1689453125,2001.3970947266,7.8260803222656,0,90))
table.insert(noCollsTab, createObject(8558,2001.6134033203,-1617.1689453125,2002.1810302734,9.7825927734375,0,90))

table.insert(noScaleTab, createObject(6959,1969.2004394531,-1616.5615234375,1968.3376464844,0,338.28002929688,0))
table.insert(noScaleTab, createObject(6959,1926.5168457031,-1616.5615234375,1951.3376464844,0,338.28002929688,0))
table.insert(noScaleTab, createObject(6959,1884.53515625,-1616.5615234375,1934.6158447266,0,338.28002929688,0))
table.insert(noScaleTab, createObject(6959,1842.1550292969,-1616.5615234375,1917.7258300781,0,338.28002929688,0))
table.insert(noScaleTab, createObject(6959,1800.0511474609,-1616.5615234375,1900.9542236328,0,338.28002929688,0))
table.insert(noScaleTab, createObject(3458,442.43951416016,-1997.6923828125,20.710514068604,19.432159423828,0,90))
table.insert(noScaleTab, createObject(3458,437.61236572266,-1997.6923828125,22.438808441162,19.966278076172,0,90))
table.insert(noScaleTab, createObject(3458,452.14108276367,-1997.6923828125,17.389301300049,18.363922119141,0,90))
table.insert(noScaleTab, createObject(3458,457.0146484375,-1997.6923828125,15.79666519165,17.829772949219,0,90))
table.insert(noScaleTab, createObject(3458,447.28253173828,-1997.6923828125,19.027297973633,18.898040771484,0,90))
table.insert(noScaleTab, createObject(3458,461.90286254883,-1997.6923828125,14.249531745911,17.295654296875,0,90))
table.insert(noScaleTab, createObject(3458,471.72149658203,-1997.6923828125,11.292301177979,16.227416992188,0,90))
table.insert(noScaleTab, createObject(3458,476.65106201172,-1997.6923828125,9.8824615478516,15.693298339844,0,90))
table.insert(noScaleTab, createObject(3458,466.80529785156,-1997.6923828125,12.74803352356,16.761535644531,0,90))
table.insert(noScaleTab, createObject(3458,481.59356689453,-1997.6923828125,8.5186376571655,15.1591796875,0,90))
table.insert(noScaleTab, createObject(3458,486.5485534668,-1997.6923828125,7.2009477615356,14.625061035156,0,90))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5563.2138671875,75.156509399414,90,0,180))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5564.927734375,85.150703430176,70.540557861328,0,180))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5563.6455078125,80.226531982422,80.270263671875,0,180))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5567.0234375,89.787353515625,60.810821533203,0,180))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5569.8725585938,94.003112792969,51.0810546875,0,180))
table.insert(noScaleTab, createObject(8558,1402.19140625,-5559.173828125,97.918731689453,0,90,179.99450683594))
table.insert(noScaleTab, createObject(8558,1402.19140625,-5564.2905273438,97.918731689453,0,90,179.99450683594))
table.insert(noScaleTab, createObject(8558,1397.875,-5559.173828125,97.918731689453,0,90,0))
table.insert(noScaleTab, createObject(8558,1397.875,-5564.2905273438,97.918731689453,0,90,0))
table.insert(noScaleTab, createObject(8558,1402.19140625,-5584.7568359375,97.918731689453,0,90,179.99450683594))
table.insert(noScaleTab, createObject(8558,1402.19140625,-5579.640625,97.918731689453,0,90,179.99450683594))
table.insert(noScaleTab, createObject(8558,1402.19140625,-5574.5234375,97.918731689453,0,90,179.99450683594))
table.insert(noScaleTab, createObject(8558,1397.875,-5574.5234375,97.918731689453,0,90,0))
table.insert(noScaleTab, createObject(8558,1402.19140625,-5569.4072265625,97.918731689453,0,90,179.99450683594))
table.insert(noScaleTab, createObject(8558,1397.875,-5569.4072265625,97.918731689453,0,90,0))
table.insert(noScaleTab, createObject(8558,1397.875,-5579.640625,97.918731689453,0,90,0))
table.insert(noScaleTab, createObject(8558,1397.875,-5584.7568359375,97.918731689453,0,90,0))
table.insert(noScaleTab, createObject(8558,1402.19140625,-5589.8740234375,97.918731689453,0,90,179.99450683594))
table.insert(noScaleTab, createObject(8558,1402.19140625,-5594.990234375,97.918731689453,0,90,179.99450683594))
table.insert(noScaleTab, createObject(8558,1402.19140625,-5600.107421875,97.918731689453,0,90,179.99450683594))
table.insert(noScaleTab, createObject(8558,1397.875,-5600.107421875,97.918731689453,0,90,0))
table.insert(noScaleTab, createObject(8558,1397.875,-5594.990234375,97.918731689453,0,90,0))
table.insert(noScaleTab, createObject(8558,1397.875,-5589.8740234375,97.918731689453,0,90,0))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5582.0283203125,102.99317932129,21.891906738281,0,180))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5577.4848632813,100.70238494873,31.621612548828,0,180))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5573.3935546875,97.676681518555,41.351348876953,0,180))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5586.8935546875,104.48316955566,12.162170410156,0,180))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5591.9404296875,105.12947845459,2.4324340820313,0,180))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5597.0244140625,104.91352844238,352.70269775391,0,180))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5597.595703125,110.95929718018,353.99597167969,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5592.576171875,111.13458251953,1.99951171875,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5587.5810546875,110.60958862305,9.99755859375,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5582.7080078125,109.39454650879,17.99560546875,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5578.0517578125,107.51309204102,25.999145507813,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5573.7021484375,105.00186157227,33.997192382813,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5566.2548828125,98.296859741211,49.998779296875,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5563.302734375,94.233604431152,57.996826171875,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5569.744140625,101.90972137451,41.995239257813,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5559.2275390625,85.079452514648,73.998413085938,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5560.9453125,89.799026489258,65.994873046875,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5558.18359375,80.16674041748,81.996459960938,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(3458,1400.10546875,-5557.8330078125,75.156509399414,90,0,0))
table.insert(noScaleTab, createObject(8558,832.6015625,-2327.09765625,1.7079999446869,349.57946777344,0,0))
table.insert(noCollsTab, createObject(3437,2239.7138671875,-5463.7529296875,4.1665000915527,10.819122314453,255.12023925781,198.60534667969))
table.insert(noCollsTab, createObject(3437,1394.8393554688,-4933.8837890625,38.682598114014,0,299.76403808594,90))
table.insert(noCollsTab, createObject(3437,1394.8388671875,-4924.1337890625,33.099700927734,0,299.76196289063,90))
table.insert(noScaleTab, createObject(6959,1775.2490234375,-5227.4990234375,-12.209400177002,90,0,0))
table.insert(noScaleTab, createObject(6959,1775.2493896484,-5222.353515625,-12.209400177002,90,0,0))
table.insert(noScaleTab, createObject(6959,1739.3155517578,-5227.4990234375,-12.209400177002,90,0,0))
table.insert(noScaleTab, createObject(6959,1739.1197509766,-5222.353515625,-12.209400177002,90,0,0))
table.insert(noScaleTab, createObject(6959,113.35870361328,-1990.0616455078,12.552300453186,90,0,0))
table.insert(noScaleTab, createObject(6959,74.215698242188,-1990.0616455078,12.552300453186,90,0,0))
table.insert(noScaleTab, createObject(6959,53.2294921875,-1990.0615234375,45.275798797607,90,0,0))
table.insert(noScaleTab, createObject(6959,18.349609375,-1990.0615234375,45.275798797607,90,0,0))
table.insert(noScaleTab, createObject(6959,37.809501647949,-1990.0616455078,13.552300453186,90,0,0))
table.insert(noScaleTab, createObject(6959,8.1527996063232,-1990.0616455078,24.802299499512,90,0,0))
table.insert(noScaleTab, createObject(6959,-21.517599105835,-1990.0616455078,45.275798797607,90,0,0))
table.insert(noScaleTab, createObject(6959,-21.517599105835,-1990.0617675781,112.65640258789,90,0,0))
table.insert(noScaleTab, createObject(6959,-21.517599105835,-1990.0616455078,75.986000061035,90,0,0))