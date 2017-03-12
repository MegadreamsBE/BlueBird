----------------------------------<
-- Bluebird GUI
-- elements/dxContainer.lua
----------------------------------<
-- GUI Parental system sketch
--[[------------------------------<

dxContainer = 	{["children"] = {[1] = 	{["type"] = "dxTile",
										 ["element"] = createElement("dxGUI", "dxTile"), --> Push element to dxElementsList as key, and value = element table.
										 ["creator"] = "BB_Menu",
										 ["x"] = 50,
										 ["y"] = 50,
										 ["sx"] = 200,
										 ["sy"] = 200,
										 ["alpha"] = 255,
										 ["render"] = dxCreateRenderTarget(sx,sy,true),
										 ["shader"] = dxCreateShader("shader/window.fx"),
										 ["parent"] = <points back to dxContainer>,
										 ["children"] = {[1]=	{["type"] = "dxButton",
																 ["element"] = createElement("dxGUI", "dxButton"),
																 ["creator"] = "BB_Menu",
																 ["x"] = 10,
																 ["y"] = 10,
																 ["sx"] = 180,
																 ["sy"] = 50,
																 ["text"] = "Click me!",
																 ["enabled"] = true,
																 ["parent"] = <points back to dxTile>
																}
										 				}
										},
								 [2] =	{["type"] = "dxImage",
								 		 ["element"] = createElement("dxGUI", "dxImage"),
								 		 ["creator"] = "BB_Menu",
										 ["x"] = 400,
										 ["y"] = 50,
										 ["sx"] = 300,
										 ["sy"] = 300,
										 ["path"] = "images/test.png",
										 ["color"] = tocolor(255,255,255,255),
										 ["parent"] = <points back to dxContainer>
										}
								}
				}

dxElementList =	{[<dxTileElement>] = dxContainer["children"][1], --> Gets pointed to the table pointed at assigning, not the table place/dir.
																   > Makes it possible to move the tables and stil retreive them.
				 [<dxButtonElement>] = dxContainer["children"][1]["children"][1],
				 [<dxImageElement>] = dxContainer["children"][2],	
				}

dxContainer will be from now just a container, and not an own screen.
Its children gets drawn in order of table key, as in the example above,
the dxTile gets drawn first, (then the dxButton), and then the dxImage.
This means that the dxImage is in front. To bring it to back, just move
its table to key 1, this will make the dxTile as front element.

To quickly get the table of the 'current' ["element"] where it's at,
simply use dxElementsList[<dxElement>], which points to the table.

-- Basic Indicators:

type : Contains the element type name.
element : Element pointer to the table.
creator : Name of the resource which used the function, for letting the system know if it needs to removed when the resource is stopped etc.

----------------------------------<

Having tables values pointing to upper tables which contain the 'start' table works. ;)

Simply try:

tabA = {}
tabB = {}
tabA[1] = tabB
tabB[1] = tabA

print(tostring(tabA[1][1][1][1]))
print(tostring(tabA[1][1][1][1][1]))
tabA[2] = ":o"
print(tostring(tabA[1][1][1][1][1][1]))
print(tostring(tabA[1][1][1][1][1][1][1]))

at http://www.lua.org/cgi-bin/demo

>> table: 0x18114c0
>> table: 0x1811470
-- inserts ':o' as 2nd value @ tabA
>> table: 0x18114c0
>> table: 0x1811470

--]]------------------------------<

local g_ScreenX, g_ScreenY = guiGetScreenSize()

dxContainer = {
	["type"] = "dxContainer",
	["element"] = createElement("dxGUI", "dxContainer"),
	["creator"] = getResourceName(getThisResource()),
	["x"] = 0,
	["y"] = 0,
	["sx"] = g_ScreenX,
	["sy"] = g_ScreenY,
	["children"] = {}
}

dxElementsList = {[dxContainer.element] = dxContainer}

fileDelete("elements/dxContainer.lua")

