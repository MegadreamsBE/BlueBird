---------------------------------<
-- Login System
-- c_login.lua
---------------------------------<
-- *~ Variables ~*
---------------------------------<

g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

setElementData(g_Me, "UAG.Account.Logged", false)

dxElements = {}

---------------------------------<
-- *~ Export ~* 
---------------------------------<

function main()
	ShowIntro()
end

---------------------------------<
-- *~ Functions ~* 
---------------------------------<

function ShowIntro()
	dxElements.IntroScreen = exports.BB_Menu:createAppWindow(false) -- Use true as argument 1 to make an invisible application window. (Since there's a 1 second delay first)
	exports.BB_GUI:dxCreateText("Bluebird Beta v0.3.2 [STABLE]", 50,50,700,500, dxElements.IntroScreen,false,false, -16744961, 1, exports.BB_GUI:dxGetFont("Segoe UI", 13), "left", "bottom")

	
	local font =  exports.BB_GUI:dxGetFont("Segoe UI Semibold", 50)
	local height = dxGetFontHeight(1, font)

	dxElements.BlockB = exports.BB_GUI:dxCreateTile(275, 150, 450,height, dxElements.IntroScreen,false,false,0)
	exports.BB_GUI:dxCreateText("Ultimate AIR", 0,0,1,1, dxElements.BlockB, true,true, -1, 1, font, "left", "center")
	dxElements.BlockC = exports.BB_GUI:dxCreateTile(275, 160+height, 450,height,dxElements.IntroScreen,false,false,0)
	exports.BB_GUI:dxCreateText("Gamers", 0,0,1,1, dxElements.BlockC,true,true, -1, 1, font, "left", "center")

	-- Note: The text goes first, because it's 'further' away when using the animation intro, else the text goes in front.

	dxElements.BlockA = exports.BB_GUI:dxCreateTile(150, 180, 100,100,dxElements.IntroScreen,false,false,0)
	exports.BB_GUI:dxCreateRectangle(0,0,1,1, dxElements.BlockA,true,true, tocolor(27,161,226,255))
	exports.BB_GUI:dxCreateText("UAG", 0,0,1,1, dxElements.BlockA,true,true, -1, 1, exports.BB_GUI:dxGetFont("Segoe UI Semibold", 26), "center", "center")

	setTimer(function()
		exports.BB_GUI:dxCreateAnimation(dxElements.BlockA, "ApproachLeft", false, "InQuad",1300, true)
	end, 1000, 1)

	setTimer(function()
		exports.BB_GUI:dxCreateAnimation(dxElements.BlockB, "ApproachLeft", false, "InQuad",1300, true)
	end, 1100, 1)

	setTimer(function()
		exports.BB_GUI:dxCreateAnimation(dxElements.BlockC, "ApproachLeft", false, "InQuad",1300, true)
	end, 1200, 1)

	setTimer(DoIntro, 3000, 1)
end

function DoIntro()
	dxElements.BlockD = exports.BB_GUI:dxCreateTile(320, 360, 160,160, dxElements.IntroScreen,false,false,255)
	exports.BB_GUI:dxCreateLoadingIcon(0,0, 160,160, dxElements.BlockD, false,false,1)
	AttemptAutoLogin()

	setTimer(function()
		exports.BB_GUI:dxCreateAnimation(dxElements.IntroScreen, "RotateFrontLeft", false, "InQuad", 700, false)
		setTimer(ShowLoginMenu, 700, 1)
	end, 5000, 1)

	setTimer(function()
		exports.BB_GUI:dxDestroyElement(dxElements.IntroScreen)
		dxElements.IntroScreen = nil
	end, 8000, 1)
end

function ShowLoginMenu()
	Logged = getElementData(g_Me, "UAG.Account.Logged", false) -- Check if player logged in by serial.
	if not Logged then
		dxElements.LoginScreen = exports.BB_Menu:createAppWindow(true)
		local fontA = exports.BB_GUI:dxGetFont("Segoe UI Semibold", 20)

		exports.BB_GUI:dxCreateImage(125,150,200,200, ":BB_Menu/images/icons/defaultuser.png",dxElements.LoginScreen,false,false, 0,0,0,-1)
		exports.BB_GUI:dxCreateText("Login", 350, 150, 0, 0, dxElements.LoginScreen, false,false, -1, 1, fontA, "left","top")

		dxElements.Login_Nick = exports.BB_GUI:dxCreateEdit(350, 200, 325, 30, dxElements.LoginScreen, false, false, "Nickname")
		dxElements.Login_Pass = exports.BB_GUI:dxCreateEdit(350, 250, 325, 30, dxElements.LoginScreen, false, false, "Password")
		exports.BB_GUI:dxSetProperty(dxElements.Login_Pass, "Masked", true)

		dxElements.Login_BLogin = exports.BB_GUI:dxCreateButton(350,300,135,30, "Login" 			,dxElements.LoginScreen,false,false)
		dxElements.Login_BGuest = exports.BB_GUI:dxCreateButton(535,300,135,30, "Play as Guest" 	,dxElements.LoginScreen,false,false)

		dxElements.Login_Description = exports.BB_GUI:dxCreateText("To login on our servers you'll have to sign up at #1BA1E2http://ultimateairgamers.com/#FFFFFF\nWhen you've signed up succesfully, you'll be able to login on our servers directly.",125,400,550,50,dxElements.LoginScreen, false,false,tocolor(255,255,255,255),
			1, exports.BB_GUI:dxGetFont("Segoe UI", 12), "left", "center", false,false,true)


		exports.BB_GUI:dxCreateAnimation(dxElements.LoginScreen, "RotateBackLeft", true, "InQuad",700, true)

		addEventHandler("onClientDXClick", dxElements.Login_BLogin, PerformLogIn)
		addEventHandler("onClientDXClick", dxElements.Login_BGuest, PerformGuest)
	end
end

function PerformLogIn(btn, state)
	if (btn == "left") and (state == "up") then
		local nick = exports.BB_GUI:dxGetRawData(dxElements.Login_Nick, "Text")
		local pass = exports.BB_GUI:dxGetRawData(dxElements.Login_Pass, "Text")
		if (nick == "") or (pass == "") then
			exports.BB_Notify:Notify("You've forgot to fill in a field", 1, "Error")
			return
		end
		exports.BB_GUI:dxSetProperty(dxElements.Login_BLogin, "Enabled", false)
		exports.BB_GUI:dxSetProperty(dxElements.Login_BGuest, "Enabled", false)
		exports.BB_Notify:Notify("Attempting to log-in.", 1, "Wait")
		triggerServerEvent("onAttemptToLogin", g_Me,"fill", nick,pass)
	end
end

function PerformGuest(btn, state)
	if (btn == "left") and (state == "up") then
		exports.BB_Notify:Notify("You cannot play as a guest yet.", 1, "Error")
	end
end

function AttemptAutoLogin()
	local node = xmlLoadFile("@autologin.xml")
	if not node then return false end
	
	local usernode = xmlNodeGetChildren(node, 0)
	local nick = xmlNodeGetAttribute(usernode, "nick")
	local pass = xmlNodeGetAttribute(usernode, "pass")
	xmlUnloadFile(node)
	triggerServerEvent("onAttemptToLogin", g_Me, "auto", nick,pass)
end

function loadPlayer(how,nick,pass)
	-- dxGUI Elements of the intro are already destroyed, if dxElements.LoginScreen exists, then destroy also.
	if dxElements.LoginScreen then exports.BB_GUI:dxCreateAnimation(dxElements.LoginScreen, "RotateFrontLeft", false, "OutQuad",700, true) end

	showChat(true)
	
	if how == "fill" then 
		saveAccount(nick,pass)
	end

	local waitTime = 1000
	if dxElements.IntroScreen then
		waitTime = 7000
	end

	setTimer(function()
		setElementData(localPlayer,"bb.forcejoin",true)
		exports.BB_Rooms:joinRoom(1)
		exports.BB_Menu:setMenuEnabled(false)
		
		-- Player has been logged in, stats are getting loaded server-sided.
		if dxElements.LoginScreen then
			exports.BB_GUI:dxDestroyElement(dxElements.LoginScreen)
		end
		dxElements.LoadingScreen = exports.BB_Menu:createAppWindow(true)

		local fontA = exports.BB_GUI:dxGetFont("Segoe UI", 18)
		dxElements.LoadingScreen_Text = exports.BB_GUI:dxCreateText("", 0, 220, 800, 100, dxElements.LoadingScreen, false,false, -1, 1, fontA, "center","center",false,false,true)
		dxElements.LoadingScreen_Bar = exports.BB_GUI:dxCreateLoadingBar(200,300,400,40, dxElements.LoadingScreen)

		exports.BB_GUI:dxCreateAnimation(dxElements.LoadingScreen, "MoveToBack", true, "Linear",700, true)

		setTimer(triggerServerEvent, 1000, 1, "onPlayerGoesLoading", g_Me)

		Loading.start = getTickCount()
		addEventHandler("onClientRender", root, updateLoadingScreen)
	end,waitTime,1)
end

function errorPlayer()
	exports.BB_Notify:Notify("Unable to log-in.\nInvalid user name or password.", 2, "Error")

	if dxElements.LoginScreen then
		exports.BB_GUI:dxSetProperty(dxElements.Login_BLogin, "Enabled", true)
		exports.BB_GUI:dxSetProperty(dxElements.Login_BGuest, "Enabled", true)
	end
end

function saveAccount(nick,pass)
	local node = xmlCreateFile("@autologin.xml", "AutoLogin")
	
	local usernode = xmlCreateChild(node, "User")
	xmlNodeSetAttribute(usernode, "nick", nick)
	xmlNodeSetAttribute(usernode, "pass", pass)

	xmlSaveFile(node)
end

---------------------------------<
-- *~ Events/Handlings ~*
---------------------------------<

addEvent("onClientDXClick")

addEvent("onLoginSucces", true)
addEvent("onLoginFailed", true)
addEvent("onLoadingUpdate", true)
addEventHandler("onLoginFailed", g_Me, errorPlayer)
addEventHandler("onLoginSucces", g_Me, loadPlayer)

fileDelete("c_login.lua")