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
table.insert(noScaleTab, createObject(8558,7130.11328125,-2065.2092285156,7.700975894928,344.99816894531,0,90))
table.insert(noScaleTab, createObject(8558,7135.0727539063,-2065.2092285156,9.0574216842651,344.40893554688,0,90))
table.insert(noScaleTab, createObject(8558,7140.0180664063,-2065.2092285156,10.464796066284,343.81982421875,0,90))
table.insert(noScaleTab, createObject(8558,7144.9487304688,-2065.2092285156,11.922950744629,343.23059082031,0,90))
table.insert(noScaleTab, createObject(8558,7149.8642578125,-2065.2092285156,13.431730270386,342.64135742188,0,90))
table.insert(noScaleTab, createObject(8558,7154.763671875,-2065.2092285156,14.990976333618,342.05218505859,0,90))
table.insert(noScaleTab, createObject(8558,7159.6469726563,-2065.2092285156,16.600522994995,341.46295166016,0,90))
table.insert(noScaleTab, createObject(8558,7164.513671875,-2065.2092285156,18.260202407837,340.87377929688,0,90))
table.insert(noScaleTab, createObject(8558,7169.3627929688,-2065.2092285156,19.969835281372,340.28454589844,0,90))
table.insert(noScaleTab, createObject(8558,7174.1938476563,-2065.2092285156,21.729244232178,339.69543457031,0,90))
table.insert(noScaleTab, createObject(8558,7179.0068359375,-2065.2092285156,23.538240432739,339.10620117188,0,90))
table.insert(noScaleTab, createObject(8558,7188.5756835938,-2065.2092285156,27.304229736328,337.92779541016,0,90))
table.insert(noScaleTab, createObject(8558,7193.3305664063,-2065.2092285156,29.260824203491,337.33862304688,0,90))
table.insert(noScaleTab, createObject(8558,7183.80078125,-2065.2092285156,25.396635055542,338.51696777344,0,90))
table.insert(noScaleTab, createObject(8558,7198.0869140625,-2065.2092285156,31.199022293091,338.31958007813,0,90))
table.insert(noScaleTab, createObject(8558,7202.8754882813,-2065.2092285156,33.055511474609,339.30053710938,0,90))
table.insert(noScaleTab, createObject(8558,7207.6953125,-2065.2092285156,34.829742431641,340.28143310547,0,90))
table.insert(noScaleTab, createObject(8558,7212.544921875,-2065.2092285156,36.521202087402,341.26232910156,0,90))
table.insert(noScaleTab, createObject(8558,7217.4228515625,-2065.2092285156,38.12939453125,342.24328613281,0,90))
table.insert(noScaleTab, createObject(8558,7222.3276367188,-2065.2092285156,39.653839111328,343.22418212891,0,90))
table.insert(noScaleTab, createObject(8558,7227.2573242188,-2065.2092285156,41.094100952148,344.205078125,0,90))
table.insert(noScaleTab, createObject(8558,7232.2114257813,-2065.2092285156,42.449752807617,345.18603515625,0,90))
table.insert(noScaleTab, createObject(8558,7237.1879882813,-2065.2092285156,43.720394134521,346.1669921875,0,90))
table.insert(noScaleTab, createObject(8558,7242.1850585938,-2065.2092285156,44.905654907227,347.14788818359,0,90))
table.insert(noScaleTab, createObject(8558,7247.2021484375,-2065.2092285156,46.005187988281,348.12878417969,0,90))
table.insert(noScaleTab, createObject(8558,7308.3916015625,-2065.2092285156,52.420974731445,359.89990234375,0,90))
table.insert(noScaleTab, createObject(8558,7303.255859375,-2065.2092285156,52.368034362793,358.9189453125,0,90))
table.insert(noScaleTab, createObject(8558,7298.1220703125,-2065.2092285156,52.227188110352,357.93804931641,0,90))
table.insert(noScaleTab, createObject(8558,7287.8647460938,-2065.2092285156,51.681930541992,355.97619628906,0,90))
table.insert(noScaleTab, createObject(8558,7292.9907226563,-2065.2092285156,51.998462677002,356.95715332031,0,90))
table.insert(noScaleTab, createObject(8558,7282.7446289063,-2065.2092285156,51.277687072754,354.99523925781,0,90))
table.insert(noScaleTab, createObject(8558,7277.6318359375,-2065.2092285156,50.785850524902,354.01440429688,0,90))
table.insert(noScaleTab, createObject(8558,7272.5288085938,-2065.2092285156,50.206565856934,353.03344726563,0,90))
table.insert(noScaleTab, createObject(8558,7267.4360351563,-2065.2092285156,49.539993286133,352.05249023438,0,90))
table.insert(noScaleTab, createObject(8558,7262.3559570313,-2065.2092285156,48.786338806152,351.07159423828,0,90))
table.insert(noScaleTab, createObject(8558,7257.2890625,-2065.2092285156,47.945816040039,350.09069824219,0,90))
table.insert(noScaleTab, createObject(8558,7252.2373046875,-2065.2092285156,47.018676757813,349.10974121094,0,90))
table.insert(noScaleTab, createObject(8355,8119.013671875,-1723.953125,17.13240814209,0,49.998779296875,323.80004882813))
table.insert(noScaleTab, createObject(8355,8019.4755859375,-2055.060546875,17.731700897217,0,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(8355,8019.4755859375,-2028.0576171875,17.731700897217,179.99450683594,0,0))
table.insert(noScaleTab, createObject(8355,8057.8173828125,-2104.5146484375,17.731700897217,0.0054931640625,180,270))
table.insert(noScaleTab, createObject(8355,8039.3852539063,-2098.8107910156,-44.996383666992,90,0,90))
table.insert(noScaleTab, createObject(8355,7758.78515625,-2118.51171875,1.4785715341568,0,179.99450683594,190.45349121094))
table.insert(noScaleTab, createObject(8355,8119.013671875,-1723.953125,17.13240814209,0,49.998779296875,323.8000793457))
table.insert(noScaleTab, createObject(8355,8019.4755859375,-2028.0576171875,17.731700897217,179.99450683594,0,0))
table.insert(noScaleTab, createObject(8355,8019.4755859375,-2055.060546875,17.731700897217,0,179.99450683594,179.99450683594))
table.insert(noScaleTab, createObject(8355,8057.8173828125,-2104.5146484375,17.731700897217,0,179.99450683594,270))
table.insert(noScaleTab, createObject(8355,8039.384765625,-2098.810546875,-44.996383666992,90,0,90))
table.insert(noScaleTab, createObject(8355,7758.78515625,-2118.51171875,1.4785715341568,0,179.99450683594,190.45349121094))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1705.0026855469,86.195541381836,0,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1699.8668212891,86.151573181152,359.01904296875,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1694.732421875,86.019691467285,358.03814697266,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1689.6010742188,85.799934387207,357.05725097656,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1684.4742431641,85.49235534668,356.07629394531,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1679.3533935547,85.097061157227,355.09533691406,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1674.2401123047,84.614151000977,354.11444091797,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1669.1358642578,84.04377746582,353.13348388672,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1664.0421142578,83.386100769043,352.15258789063,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1658.9603271484,82.641319274902,351.17163085938,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1653.8920898438,81.809646606445,350.19067382813,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1648.8387451172,80.891334533691,349.20983886719,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1643.8018798828,79.886650085449,348.22888183594,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1633.7835693359,77.619346618652,346.26702880859,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1628.8049316406,76.357391357422,345.2861328125,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1623.8486328125,75.010398864746,344.30517578125,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1614.0089111328,72.062873840332,342.34332275391,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1609.1282958984,70.463203430176,341.36242675781,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1604.2758789063,68.780220031738,340.38146972656,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1599.4528808594,67.014404296875,339.40051269531,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1594.6608886719,65.166282653809,338.41961669922,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1589.9011230469,63.236396789551,337.43872070313,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1585.1357421875,61.397808074951,340.36553955078,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1580.2828369141,59.804943084717,343.29235839844,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1570.3646240234,57.372333526611,349.14599609375,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1565.3253173828,56.538940429688,352.07287597656,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1560.2501220703,55.963943481445,354.99975585938,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1555.1520996094,55.64884185791,357.92651367188,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1550.0446777344,55.594459533691,0.85336303710938,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1544.9411621094,55.800933837891,3.7801818847656,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1539.8547363281,56.267730712891,6.70703125,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1529.7866210938,57.976741790771,12.560668945313,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1524.8311767578,59.214496612549,15.487518310547,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1519.9453125,60.703666687012,18.414337158203,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1515.1419677734,62.440364837646,21.341186523438,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1510.4334716797,64.420059204102,24.268005371094,0,0))
table.insert(noScaleTab, createObject(8558,7941.3676757813,-1505.8322753906,66.637596130371,27.19482421875,0,0))
table.insert(noScaleTab, createObject(8558,7981.1630859375,-1839.982421875,86.195541381836,0,0,289.98413085938))
table.insert(noScaleTab, createObject(8558,7976.3671875,-1841.7275390625,86.195541381836,0,0,289.98962402344))
table.insert(noScaleTab, createObject(8355,7829.5810546875,-1238.42578125,0.82326376438141,0,0,26.224365234375))
table.insert(noScaleTab, createObject(8355,7841.47265625,-1231.9931640625,0.82326376438141,0,0,22.30224609375))
table.insert(noScaleTab, createObject(1633,7923.1474609375,-1427.6865234375,8.7297477722168,339.99938964844,0,286.90795898438))
table.insert(noScaleTab, createObject(1633,7924.2822265625,-1431.3935546875,8.7297477722168,339.99938964844,0,286.90795898438))
table.insert(noScaleTab, createObject(8171,7968.4052734375,-1490.892578125,17.092060089111,90,309.99572753906,0))

function ClientStarted ()
 setWaterColor(112,147,219,230)
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )
table.insert(noScaleTab, createObject(1633,7924.2822265625,-1431.3935546875,8.7297477722168,339.99938964844,0,286.90795898438))
table.insert(noScaleTab, createObject(1633,7923.1474609375,-1427.6865234375,8.7297477722168,339.99938964844,0,286.90795898438))