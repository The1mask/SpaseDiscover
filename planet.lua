local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local touchX = 0
local touchY = 0
local CURRPLANET = 0

local button = {}
local planetGroup = {}
local map

 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
planetGroup = display.newGroup()
 local function handleButtonEvent1( event )
 
	if ( "ended" == event.phase ) then
		print( "Button was pressed and released" )
			composer.gotoScene("menu")
	end
end


local function handleMove( event )
    if event.phase == "began" then
        touchX=event.x
			elseif(event.phase == "moved") then
				if(map.x-160>-320 and touchX - event.x>0)then
					map.x = map.x - 2
					print(map.x)
					
					elseif(map.x+160<650 and touchX - event.x<0) then
					map.x = map.x + 2
					print(map.x)
						
				end

			end
end
			

Runtime:addEventListener( "touch", handleMove )
-- create()
function scene:create( event )
	CURRPLANET = event.params["CURRPLANE"]
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
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
			planetGroup:insert(2,button[1])
			
		map  = display.newImageRect("STARSMAP.png", 1024, 693)
		map.x = display.contentCenterX
		map.y = display.contentCenterY
		planetGroup:insert(1,map )
		
		local score = display.newText("Текущая планета: ".. CURRPLANET , display.contentCenterX, display.contentCenterY + 225, native.systemFont, 14)
		planetGroup:insert(3,score )
		score:setFillColor(0,0,0)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		planetGroup.isVisible = true
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
			planetGroup.isVisible = false
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