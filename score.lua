----------------Инициализация------------------------------------------------------------
local composer = require( "composer" )
local widget = require( "widget" )

----------------Переменные---------------------------------------------------------------
local SCORE = {}
local scoreGroup = {}

local score = {}



scoreGroup = display.newGroup()

local scene = composer.newScene()
local path = system.pathForFile( "savescore.txt" )


local function handleButtonEvent2( event )
 

end

local function handleButtonEvent1( event )
 
	if ( "ended" == event.phase ) then
		print( "Button was pressed and released" )
			composer.gotoScene("menu")
	end
end



-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	button1 = widget.newButton(
		{
			left      = 75,
			top       = 300,
			id        = "button1",
			label     = "В меню",
			onEvent   = handleButtonEvent1,
			fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.2, 0.5, 0 } }
		}
	)
	sceneGroup:insert(2,button1)
	
		button2 = widget.newButton(
		{
			left      = 75,
			top       = 200,
			id        = "button1",
			label     = "Загрузить",
			onEvent   = handleButtonEvent2,
			fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.2, 0.5, 0 } }
		}
	)
	sceneGroup:insert(2,button2)
	
		
	score[1] = display.newText("GLOBALSCORE: " , display.contentCenterX, display.contentCenterY + 225, native.systemFont, 14)
	score[2] = display.newText("LASTSCORE: "
    , display.contentCenterX, display.contentCenterY + 200, native.systemFont, 14)
	score[3] = display.newText("TOTALFUEL: "
    , display.contentCenterX, display.contentCenterY + 175, native.systemFont, 14)
	score[4] = display.newText("GLOBALPATH: "
    , display.contentCenterX, display.contentCenterY + 150, native.systemFont, 14)
	score[5] = display.newText("LASTPATH: "
    , display.contentCenterX, display.contentCenterY + 125, native.systemFont, 14)
	sceneGroup:insert(3,score[1])
	sceneGroup:insert(3,score[2])
	sceneGroup:insert(3,score[3])
	sceneGroup:insert(3,score[4])
	sceneGroup:insert(3,score[5])
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		sceneGroup.isVisible = true
		
		local file, errorString = io.open( path, "r" )
		
		if not file then
			
			print( "File error: " .. errorString )
		else
    local i = 1
			for line in file:lines() do
				
					SCORE[i] = line
					i = i + 1
			end
			
			score[1].text = ("GLOBALSCORE:"..SCORE[1])
			score[2].text = ("LASTSCORE:"..SCORE[2])
			score[3].text = ("TOTALFUEL:"..SCORE[3])
			score[4].text = ("GLOBALPATH:"..SCORE[4])
			score[5].text = ("LASTPATH:"..SCORE[5])
			
   
		io.close( file )
		end
		
		
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
		sceneGroup.isVisible = false
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