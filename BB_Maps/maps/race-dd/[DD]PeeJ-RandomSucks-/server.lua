vehicles = {602,545,496,517,401,410,518,600,527,436,589,580,419,439533,549,526,491,474,445,604,507,585,587,466,492,546,551,516,467,426,547,405,409,550,566,540,421,529,581,509,481,462,521,463,510,522,461,448,468,586,485,552,431,438,437,574,420,525,408,416,433,427,490,528,407,544,523,470,598,596,597,599,601,428,499,609,498,524,532,578,486,406,573,455,588,403,514,423,414,443,515,531,456,459,422,482,605,530,418,572,582,413,440,543,583,478,554,536,575,534,567,535,576,412,402,542,603,475,568,424,504,457,483,508,571,500,444,556,557,471,495,539,429,541,415,480,562,565,323,492,502,503,411,559,561,560,506,451,558,555,477,579,400,404,489,505,479,442,458}

function changeVehicle (state)
 if state == "Running" then
  setTimer (function ()
    local players = getAlivePlayers ()
    for playerKey, playerValue in ipairs(players) do
     setElementModel (getPedOccupiedVehicle(playerValue), vehicles[math.random(#vehicles)])

    end
   end, 1000, 1)
 end

end
addEvent("onRaceStateChanging", true)
addEventHandler ("onRaceStateChanging", getRootElement (), changeVehicle)



 function changePlayersVeh ()
 setElementModel (getPedOccupiedVehicle(source), vehicles[math.random(#vehicles)])


end
addEvent("changeVeh", true)
addEventHandler("changeVeh", getRootElement(), changePlayersVeh)