---------------------------------<
-- Logout App
-- s_logout.lua
---------------------------------<

-- Saving is @ BB_Login/s_save.lua

addEventHandler("onPlayerQuit", root,
	function()
		if (getElementData(source, "UAG.Account.Logged",false)) then
			triggerEvent("onUserSaveAllTheThings", source)
		end
	end
)
