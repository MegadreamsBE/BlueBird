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
table.insert(noScaleTab, createObject(8558,844.87780761719,-4974.560546875,10.562100410461,40.638427734375,0,179.99450683594))

table.insert(noScaleTab, createObject(8558,844.87701416016,-4978.412109375,13.862099647522,40.638427734375,0,179.99450683594))
table.insert(noScaleTab, createObject(8558,844.8759765625,-4982.263671875,17.162097930908,40.632934570313,0,179.99450683594))
table.insert(noScaleTab, createObject(8558,844.873046875,-4997.669921875,30.36209487915,40.632934570313,0,179.99450683594))
table.insert(noScaleTab, createObject(8558,844.873046875,-4993.818359375,27.06209564209,40.632934570313,0,179.99450683594))
table.insert(noScaleTab, createObject(8558,844.8740234375,-4989.966796875,23.762096405029,40.632934570313,0,179.99450683594))
table.insert(noScaleTab, createObject(8558,844.875,-4986.115234375,20.462097167969,40.632934570313,0,179.99450683594))
table.insert(noScaleTab, createObject(8558,844.87701416016,-4909.4233398438,10.562100410461,40.638427734375,0,359.99450683594))
table.insert(noScaleTab, createObject(8558,844.87701416016,-4905.5678710938,13.862099647522,40.638427734375,0,359.99450683594))
table.insert(noScaleTab, createObject(8558,844.876953125,-4901.7119140625,17.162097930908,40.632934570313,0,359.98901367188))
table.insert(noScaleTab, createObject(8558,844.876953125,-4897.8564453125,20.462097167969,40.632934570313,0,359.98901367188))
table.insert(noScaleTab, createObject(8558,844.876953125,-4894.0009765625,23.762096405029,40.632934570313,0,359.98901367188))
table.insert(noScaleTab, createObject(8558,844.876953125,-4890.1455078125,27.06209564209,40.632934570313,0,359.98901367188))
table.insert(noScaleTab, createObject(8558,844.876953125,-4886.2900390625,30.36209487915,40.632934570313,0,359.98901367188))
table.insert(noScaleTab, createObject(6959,671.09722900391,-4942.4858398438,7.6704144477844,20.5,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,674.82574462891,-4942.486328125,6.4409394264221,16,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,678.63922119141,-4942.4868164063,5.5077905654907,11.5,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,682.51416015625,-4942.4868164063,4.876718044281,7,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,686.42663574219,-4942.4873046875,4.5516152381897,2.5,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,690.35260009766,-4942.4877929688,4.5344858169556,358,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,694.26776123047,-4942.48828125,4.8254356384277,353.5,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,698.14807128906,-4942.4887695313,5.4226703643799,349,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,701.96954345703,-4942.4887695313,6.3225078582764,344.5,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,705.70861816406,-4942.4892578125,7.5194001197815,340,0,89.994506835938))
table.insert(noScaleTab, createObject(8838,273.181640625,-4951.9951171875,6.4419403076172,0,17.99560546875,0))
table.insert(noScaleTab, createObject(8838,273.28125,-4928.4951171875,6.4419403076172,0,17.99560546875,0))
table.insert(noScaleTab, createObject(8838,278.2255859375,-4951.99609375,5.0902824401855,0,11.9970703125,0))
table.insert(noScaleTab, createObject(8838,278.3251953125,-4928.49609375,5.0902824401855,0,11.9970703125,0))
table.insert(noScaleTab, createObject(8838,283.3837890625,-4951.998046875,4.2733192443848,0,5.99853515625,0))
table.insert(noScaleTab, createObject(8838,283.4833984375,-4928.498046875,4.2733192443848,0,5.99853515625,0))
table.insert(noScaleTab, createObject(8838,116.74652862549,-4956.9379882813,3.9757235050201,11.077026367188,359.03869628906,94.991180419922))
table.insert(noScaleTab, createObject(8838,116.74652862549,-4923.2622070313,3.9757235050201,11.077026367188,0.96127319335938,85.008850097656))
table.insert(noScaleTab, createObject(8838,106.76647949219,-4958.2495117188,5.9370174407959,10.954040527344,358.0849609375,99.979553222656))
table.insert(noScaleTab, createObject(8838,106.76647949219,-4921.9506835938,5.9370174407959,10.954040527344,1.9150085449219,80.020446777344))
table.insert(noScaleTab, createObject(8838,96.932739257813,-4919.775390625,7.8695583343506,10.750152587891,2.853759765625,75.037536621094))
table.insert(noScaleTab, createObject(8838,96.932739257813,-4960.4248046875,7.8695583343506,10.750152587891,357.14624023438,104.96243286133))
table.insert(noScaleTab, createObject(8838,87.317123413086,-4963.447265625,9.7592315673828,10.466979980469,356.22985839844,109.93725585938))
table.insert(noScaleTab, createObject(8838,87.317123413086,-4916.7529296875,9.7592315673828,10.466979980469,3.7701721191406,70.062713623047))
table.insert(noScaleTab, createObject(8838,77.989875793457,-4912.904296875,11.592237472534,10.106872558594,4.6572875976563,65.09814453125))
table.insert(noScaleTab, createObject(8838,77.989875793457,-4967.2958984375,11.592237472534,10.106872558594,355.34271240234,114.90185546875))
table.insert(noScaleTab, createObject(8838,69.019096374512,-4908.2583007813,13.355187416077,9.6726684570313,5.5083923339844,60.145812988281))
table.insert(noScaleTab, createObject(8838,69.019096374512,-4971.9418945313,13.355187416077,9.6726684570313,354.49163818359,119.85415649414))
table.insert(noScaleTab, createObject(8838,101.82679748535,-4959.2299804688,6.9077706336975,10.862091064453,357.61328125,102.47183227539))
table.insert(noScaleTab, createObject(8838,101.82679748535,-4920.9702148438,6.9077706336975,10.862091064453,2.38671875,77.528167724609))
table.insert(noScaleTab, createObject(8838,92.093231201172,-4918.369140625,8.8206253051758,10.618347167969,3.315185546875,72.548980712891))
table.insert(noScaleTab, createObject(8838,82.613143920898,-4914.9301757813,10.683665275574,10.29638671875,4.2178039550781,67.579010009766))
table.insert(noScaleTab, createObject(8838,73.455764770508,-4910.6791992188,12.483286857605,9.8988342285156,5.0877380371094,62.620361328125))
table.insert(noScaleTab, createObject(8838,92.093231201172,-4961.8310546875,8.8206253051758,10.618347167969,356.68481445313,107.45104980469))
table.insert(noScaleTab, createObject(8838,82.613143920898,-4965.2700195313,10.683665275574,10.29638671875,355.7822265625,112.42098999023))
table.insert(noScaleTab, createObject(8838,73.455764770508,-4969.5209960938,12.483286857605,9.8988342285156,354.91229248047,117.37966918945))
table.insert(noScaleTab, createObject(8838,-465.14651489258,-4937.802734375,1.0630505084991,8.8163146972656,0,269.99450683594))
table.insert(noScaleTab, createObject(8838,-470.22454833984,-4937.8022460938,0.34199726581573,7.346923828125,0,269.99450683594))
table.insert(noScaleTab, createObject(8838,-475.31942749023,-4937.8017578125,-0.24860310554504,5.8775329589844,0,269.99450683594))
table.insert(noScaleTab, createObject(8838,-480.42776489258,-4937.8012695313,-0.70836228132248,4.4081726074219,0,269.99450683594))
table.insert(noScaleTab, createObject(8838,-485.54623413086,-4937.80078125,-1.0369777679443,2.9387817382813,0,269.99450683594))
table.insert(noScaleTab, createObject(8838,-490.67141723633,-4937.8002929688,-1.2342336177826,1.4693908691406,0,269.99450683594))
table.insert(noScaleTab, createObject(6959,-901.09997558594,-4958.2001953125,5.6999998092651,0,0,180))
table.insert(noScaleTab, createObject(6959,-901.09997558594,-4918.5,5.6999998092651,0,0,179.99450683594))
table.insert(noScaleTab, createObject(8558,-1411.1484375,-4784.66796875,1.1383999586105,0,0,179.99450683594))
table.insert(noScaleTab, createObject(8558,-1411.1922607422,-5094.546875,1.1383999586105,0,0,179.99450683594))
table.insert(noScaleTab, createObject(6959,-2072.7299804688,-4943.3642578125,5.0001678466797,358.96203613281,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2056.8330078125,-4943.3657226563,5.5412368774414,357.13928222656,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2044.9260253906,-4943.3666992188,6.2787437438965,355.77209472656,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2040.9614257813,-4943.3671875,6.5876808166504,355.31646728516,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2036.9992675781,-4943.3676757813,6.928150177002,354.86083984375,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2033.0400390625,-4943.3681640625,7.3001136779785,354.40502929688,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2048.8930664063,-4943.3666992188,6.0013389587402,356.22784423828,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2052.8623046875,-4943.3662109375,5.7554969787598,356.68353271484,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2060.8056640625,-4943.365234375,5.3585548400879,357.59484863281,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2064.779296875,-4943.365234375,5.2074851989746,358.05065917969,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2068.7543945313,-4943.3647460938,5.0880165100098,358.50634765625,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2076.7062988281,-4943.3637695313,4.9439430236816,359.41772460938,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2029.0838623047,-4943.3686523438,7.7035522460938,353.94934082031,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2025.1311035156,-4943.3686523438,8.1384468078613,353.49365234375,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1894.4842529297,-4943.3813476563,41.326198577881,338,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1920.5710449219,-4943.37890625,31.621982574463,341.18988037109,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1924.3404541016,-4943.3784179688,30.35474395752,341.6455078125,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1913.0631103516,-4943.3793945313,34.246189117432,340.27844238281,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1909.3250732422,-4943.3798828125,35.602993011475,339.82275390625,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1916.8118896484,-4943.3793945313,32.91915512085,340.73413085938,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1928.1197509766,-4943.3779296875,29.117528915405,342.10131835938,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1905.5979003906,-4943.3803710938,36.989486694336,339.36706542969,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1901.8819580078,-4943.380859375,38.405578613281,338.91137695313,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1898.1772460938,-4943.380859375,39.851177215576,338.45568847656,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1931.9088134766,-4943.3779296875,27.91040802002,342.55694580078,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1935.7072753906,-4943.3774414063,26.733461380005,343.0126953125,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1939.5151367188,-4943.376953125,25.586763381958,343.46838378906,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1943.3319091797,-4943.3764648438,24.470386505127,343.92407226563,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1947.1574707031,-4943.3764648438,23.384401321411,344.37976074219,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1950.9914550781,-4943.3759765625,22.328874588013,344.83544921875,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1962.5422363281,-4943.375,19.345714569092,346.20251464844,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1958.6840820313,-4943.375,20.309467315674,345.74682617188,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1970.2808837891,-4943.3740234375,17.510414123535,347.11389160156,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1966.4079589844,-4943.3745117188,18.412677764893,346.658203125,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1974.1610107422,-4943.3735351563,16.638980865479,347.56970214844,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2021.1817626953,-4943.369140625,8.6047630310059,353.03796386719,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1954.8337402344,-4943.3754882813,21.303874969482,345.29113769531,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1978.0478515625,-4943.3735351563,15.798439025879,348.02526855469,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1981.9411621094,-4943.373046875,14.988832473755,348.48101806641,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1997.5755615234,-4943.3715820313,12.060806274414,350.30383300781,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2005.4256591797,-4943.3706054688,10.783668518066,351.21520996094,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2017.2364501953,-4943.3696289063,9.102481842041,352.58227539063,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1993.6583251953,-4943.3720703125,12.746160507202,349.84808349609,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1985.8409423828,-4943.3725585938,14.210218429565,348.93676757813,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-1989.7467041016,-4943.3720703125,13.462644577026,349.39245605469,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2013.2950439453,-4943.3701171875,9.6315574645996,352.12658691406,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2001.498046875,-4943.37109375,11.406627655029,350.75952148438,0,89.994506835938))
table.insert(noScaleTab, createObject(6959,-2009.3580322266,-4943.3701171875,10.191967010498,351.6708984375,0,89.994506835938))