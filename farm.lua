local socket = require("socket")
local widget = require( "widget" )
            



local composer = require( "composer" )
 
local scene = composer.newScene()

local farmGroup = {}
local button = {}
local text = {}



farmGroup = display.newGroup()
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function checkConnect()

	local test = socket.tcp()

	test:settimeout(1000)                   -- Set timeout to 1 second
            
local testResult = test:connect("www.google.com", 80)        -- Note that the test does not work if we put http:// in front
 
if not(testResult == nil) then
    print("Internet access is available")
		text[1].text = "Internet access is available"
else
    print("Internet access is not available")
		text[1].text = "Internet access is not available"
end
            
test:close()
test = nil

end 


 local function handleButtonEvent1( event )
 
	if ( "ended" == event.phase ) then
		print( "Button was pressed and released" )
			composer.gotoScene("menu")
	end
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	text[1] = display.newText("Соединение: ".. 0 , display.contentCenterX, display.contentCenterY + 225, native.systemFont, 14)
	
	button[1] = widget.newButton(
			{
				left      = 75,
				top       = 300,
				id        = "button1",
				label     = "В меню",
				onEvent   = handleButtonEvent1,
				fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.2, 0.5, 0 } }
			}
		)
			farmGroup:insert(2,button[1])
			farmGroup:insert(2,text[1])
 
end
 
 
-- show()
function scene:show( event )
		checkConnect()
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
				farmGroup.isVisible = true
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
				farmGroup.isVisible = false
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene