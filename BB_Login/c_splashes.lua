---------------------------------<
-- Login System
-- s_splashes.lua
---------------------------------<
-- DEM RANDOM LOADING SPLASH TEXT
---------------------------------<

Loading = {["length"] = 20000, ["start"] = 0, ["lastNum"] = -1}


---------------------------------<

function updateLoadingScreen()
	local tick = getTickCount()
	if tick < Loading.start+Loading.length then
		local progress = (tick-Loading.start)/Loading.length
		exports.BB_GUI:dxSetRawData(dxElements.LoadingScreen_Bar, "Progress", progress)
		local num = math.floor((tick-Loading.start)/4000)
		if num ~= Loading.lastNum then
			Loading.lastNum = num
			local pick = math.random(1,#splashes)
			exports.BB_GUI:dxSetRawData(dxElements.LoadingScreen_Text, "Text", splashes[pick])
			table.remove(splashes,pick)
		end
	else
		removeEventHandler("onClientRender", root, updateLoadingScreen)
		exports.BB_GUI:dxCreateAnimation(dxElements.LoadingScreen, "MoveToFront", false, "Linear",700, true)
		setTimer(
			function()
				exports.BB_GUI:dxDestroyElement(dxElements.LoadingScreen)
				exports.BB_Menu:ShowMenuForFirstTime() -- Is basicly now "EnableMenuForTheFirstTime" :)
			end
		,1000, 1)
	end
end

---------------------------------<

splashes = {
	"Loading Spiderpig v0.9a",
	"Creating BlueScreen of Death",
	"Looking for any data to steal",
	"HUEHUEHUEHUEHUEHUE",
	"Searching scripts",
	"Ain't nobody got time for this!?",
	"Telling Megadreams to go scripting",
	"Stealing cookies",
	"Injecting s0beit-h4x",
	"Eating cookies",
	"Don't bite me!",
	"Deleting BlueBird... just kidding!",
	"\\/ Totally not for decoration \\/",
	"Baking cake",
	"Mindfuck please!",
	"No easter eggs here",
	"Loading... YOU DON'T SAY?",
	"Badluck Brian is loading the script... it stopped",
	"Please bear with yourself while this loadingbar is getting stuffed",
	"Better than your mom!",
	"ERMERGERD! LERDZINGBEHR!",
	"Mmmmh donuts...",
	"Touch me...",
	"I still can't believe they pay me for this",
	"What the hell am I doing?",
	"Don't crash into that wall... really... don't!!",
	"Look out! He got a nose!",
	"I like trains...",
	"One does not simply ignore all these messages",
	"I believe I can fly! I believe I can touch the sky!",
	"Loading dot dot dot",
	"I used to be a mainstream MTA user...",
	"Yo momma is so slow, she doesn't even notice this loading screen",
	"Bluebird: that escalated quickly.",
	"Bluebird: ceiling cat approves",
	"If loading took longer, I could go to the bathroom...",
	"You don't like loading screens? Good.",
	"Not sure if this loading text is good, or a waste of everyones time.",
	"Everything loads better than expected.",
	"Watch out, we got a loading screen over here.",
	"Insert dirty banstick joke here",
	"Did I see a rectangle?",
	"Should I say 'welcome'?",
	"Trolling is easy, you just have to ...",
	"DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH",
	"So lovely!",
	"Doesn't this loadingbar look like a cigaret?",
	"PUSH! PUSH!",
	"Like a block!",
	"All I want for Christmas is... BlueBird!",
	"As seen in the server browser!",
	"I LOVE SANDVICH!",
	"Brought to you by... this loadingbar",
	"This loading bar was sponsored by awesomeness.",
	"Loading bar at work. Do not disturb!",
	"Follow the loading screen, CJ!",
	"Works with a keyboard!",
	"Did you know... this script is owned by UAG.",
	"Less sugar!",
	"Warning! Wet water!",
	"Fat free!",
	"Premium is awesome! Donate today!",
	"Also visit 127.0.0.1!",
	"Loading plan for evil world domination.",
	"This is loading text 69, enjoy!",
	"Loadinginator sponsored by Doofenshmirtz Evil Incorporated.",
	"Fus Ro Dah",
	"This sentence was written on 05:18 A.M",
	"4c6f6164696e672e2e2e",
	"0100 1000 0110 0101 0110 1100 0110 1100 0110 1111 0010 0001",
	"Loading awesomeness...",
	"Written in LUA!",
	"Tickle my toe",
	"Don't feed the loading screen!",
	"Free awesomeness as in free beer and in freedom!",
	"When life gives you lemons, take them... free shit is AWESOME!",
	"Missingno",
	"Hit me baby one more time!",
	"Oops I did it again"
	-- Forgot to enable color-coded ^^
}

---------------------------------<

fileDelete("c_splashes.lua")