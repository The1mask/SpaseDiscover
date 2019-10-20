----------------Инициализация------------------------------------------------------------
local composer = require( "composer" )
local widget = require( "widget" )
----------------Переменные---------------------------------------------------------------


local SAVE = {}

local path = system.pathForFile( "savestat.txt" )
local scene = composer.newScene()
local menuGroup = {}
local button = {}
local background = {}
local callSpace = {}

local spaceMap={{1,2,3,4,5,6,7,8,9,10},
				{0,500,600,200,400,0,0,0,0,0},
				{500,0,0,0,400,0,500,400,0,0},
				{600,0,0,600,0,0,0,700,500,0},
				{200,0,600,0,0,700,0,0,700,500},
				{400,400,0,0,0,500,500,0,0,0},
				{0,0,0,700,500,0,900,0,0,900},
				{0,500,0,0,500,900,0,600,0,0},
				{0,400,700,0,0,0,600,0,0,0},
				{0,0,500,700,0,0,0,0,0,900},
				{0,0,0,500,0,900,0,0,900,0}}


-----------------------------------------------------------------------------------------
menuGroup = display.newGroup()

local function loadFile()

	local file, errorString = io.open( path, "r" )
	local i = 1
		if not file then
			
			print( "File error: " .. errorString )
		else

			for line in file:lines() do
					SAVE[i] = line
					i = i + 1
			end
		end
		io.close( file )
end

local function randomPlanet()
local MIN = 10000	
	for i = 1, 10 do
		if(spaceMap[SAVE[1]+1][i]~=0 and spaceMap[SAVE[1]+1][i]<MIN )then
			MIN=spaceMap[SAVE[1]+1][i]
		end
	end	
		print(MIN)
	return MIN
end

local function handleButtonEvent1( event )
 
	if ( "ended" == event.phase ) then
		print( "Button was pressed and released" )
			composer.gotoScene("score")
	end
end

local function handleButtonEvent2( event )
 
	if ( "ended" == event.phase ) then
		print( "Button was pressed and released" )
			
local options = {
    effect = "fade",
    time = 800,
    params = { CURRPLANE=SAVE[1] }
}
			composer.gotoScene("planet",options)
	end
end

local function handleButtonEvent3( event )
 
	if ( "ended" == event.phase ) then
		print( "Button was pressed and released" )
			composer.gotoScene("farm")
	end
end

local function handleButtonEvent4( event )
 
	if ( "ended" == event.phase ) then
	
local options = {
effect = "fade",
time = 800,
params = { PATH=randomPlanet() }
}
		print( "Button was pressed and released" )
			composer.gotoScene("game",options)
			
	end
end


function callSpace:timer(event)

	background[1].y = background[1].y + 0.5
	background[2].y = background[2].y + 0.5
	
	if(background[1].y>display.contentCenterY*3)then
		background[1].y = -display.contentCenterY
	end
	if(background[2].y>display.contentCenterY*3)then
		background[2].y = -display.contentCenterY
	end
end



-- create()
function scene:create( event )
 
	loadFile()
    local sceneGroup = self.view
			
	
			
			local score = display.newText("Текущая планета: ".. SAVE[1] , display.contentCenterX, display.contentCenterY + 225, native.systemFont, 14)
			
			menuGroup:insert(3,score)
			
		button[1] = widget.newButton(
			{
				left      = 140,
				top       = 300,
				id        = "button1",
				label     = "Счет",
				onEvent   = handleButtonEvent1,
				alpha = 0,
				fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.2, 0.5, 0 } }
			}
		)
		button[2] = widget.newButton(
			{
				left      = 0,
				top       = 300,
				id        = "button2",
				label     = "Планета",
				onEvent   = handleButtonEvent2,
				alpha = 0,
				fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.2, 0.5, 0 } }
			}
		)
		button[3] = widget.newButton(
			{
				left      = 70,
				top       = 380,
				id        = "button3",
				label     = "Фарм",
				onEvent   = handleButtonEvent3,
				alpha = 0,
				fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.2, 0.5, 0 } }
			}
		)
		button[4] = widget.newButton(
			{
				left      = 70,
				top       = 150,
				id        = "button4",
				label     = "Играть",
				onEvent   = handleButtonEvent4,
				alpha = 0,
				fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.2, 0.5, 0 } }
			}
		)
		menuGroup:insert(2,button[1])
		menuGroup:insert(2,button[2])
		menuGroup:insert(2,button[3])
		menuGroup:insert(2,button[4])
		
		background[3] = display.newImageRect("ship.png", display.contentWidth*1.1, display.contentHeight*0.6)
		background[3].x = display.contentCenterX
		background[3].y = display.contentCenterY
		menuGroup:insert(2,background[3])
		
		background[1] = display.newImageRect("starback.jpg", display.contentWidth*1.3, display.contentHeight*1.1)
		background[1].x = display.contentCenterX
		background[1].y = display.contentCenterY
		menuGroup:insert(1,background[1])
		background[2] = display.newImageRect("starback.jpg", display.contentWidth*1.3, display.contentHeight*1.1)
		background[2].x = display.contentCenterX
		background[2].y = -display.contentCenterY
		menuGroup:insert(1,background[2])
		timerspace = timer.performWithDelay(1,callSpace, -1)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
			print(spaceMap[2][3])
		menuGroup.isVisible = true
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
			menuGroup.isVisible = false
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