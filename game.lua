local composer = require( "composer" )
local widget = require( "widget" )
local physics = require("physics")

-- -----------------------------------------------------------------------------------
local options =
{
	width = 240,
	height = 421,
	numFrames = 4,
	sheetContentWidth = 960,
	sheetContentHeight = 421
}

local options1 =
{
	width = 165,
	height = 170,
	numFrames = 5,
	sheetContentWidth = 825,
	sheetContentHeight = 170
}
--------------------------------------------------------------------------------------

local SPEED    = 1
local WAS_SPEED = 1
local TIMER    = 3000
local PATH     = 0
local groupNum = 0
local pathBarHeight = display.contentHeight*0.8
--------------------------------------------------------------------------------------
local sheet = graphics.newImageSheet("menuanim.png", options)
local rocks = graphics.newImageSheet("rocks.png", options1)
local background = {}
local pathBar = {}
local menu      
local mask = {}
local timerspawn
local timerpatch
local gameGroup = {}
local pauseGroup = {}
local button    = {}
local destroyGroup = {}
local object = {}
local ob1ect = {}
local callSpawn = {}
local callSpace = {}
local scene     = composer.newScene()
gameGroup       = display.newGroup()
pauseGroup      = display.newGroup()
destroyGroup	= display.newGroup()
mask			= display.newGroup()

math.randomseed(os.time())
physics.start(true)
physics.setGravity(0,0)
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function patchUpdate()
	
	PATH = PATH - 1
	
end

local function speedBuff(dd)

	for i = gameGroup.numChildren, 1, -1 do
		print(gameGroup[i].collType)
		if(gameGroup[i].collType=="box")then
			if dd == 1 then
			
				gameGroup[i]:setLinearVelocity(0,16*SPEED)
				
			elseif dd == 2 then
			
				gameGroup[i]:setLinearVelocity(0)

			end

		end
	end
	
end

local function clearMap()


	
	for i = gameGroup.numChildren, 1, -1 do
		print(gameGroup[i].collType)
		if(gameGroup[i].collType=="box")then
		
				gameGroup[i]:removeSelf()
				
	
		end
	end
end

local function addToGroup(box)

	destroyGroup:insert(box)
	box:scale(1.1,1.1)
	groupNum = groupNum + 1
	print(groupNum)
	
end

local function checkNew(box)

	if(destroyGroup[1].id==box.id)then
		return true
	end
	return false
end

local function removeFormGroup(box)
	for i = box.numChildren, 1, -1 do
		box[i]:scale(0.9,0.9)
		gameGroup:insert(3,box[i])
	end
end

local function checkGroup(box)

	for i = destroyGroup.numChildren, 1, -1 do
		if(box==destroyGroup[i]) then
			return false
		end
	end
		
return true
end

local function handleMove( event, self )
		
    if event.phase == "began" then
		if(event.target.id~=1)then
			addToGroup(event.target)
		end	
	elseif(event.phase == "moved") then

		if(event.target.id~=1)then
		
		if(groupNum~=0) then
			if(checkNew(event.target)==true)then
				if(checkGroup(event.target)) then
					addToGroup(event.target)
				end
			else
				if(groupNum>1)then
					removeFormGroup(destroyGroup)
					groupNum=0
					print(groupNum)
				else
					destroyGroup[1]:scale(0.9,0.9)
					gameGroup:insert(3,destroyGroup[1])
				end
			end
			
		else
			addToGroup(event.target)
		end
		end
        elseif(event.phase == "ended") then
			if (groupNum>1) then
				for i = destroyGroup.numChildren, 1, -1 do
					if(destroyGroup[i].id == 1 and destroyGroup[i].heach == 2)then
						destroyGroup[i].heach = 1
					else
						destroyGroup[i]:removeSelf()
				end
				
				
				end
			elseif(groupNum==1)	then
				removeFormGroup(destroyGroup[1])
			end
		groupNum = 0
		print(groupNum)
	end

end    

local function tapListener( event )
    if(event.target.id==1)then
		if(event.target.heach<1) then
			event.target:removeSelf()
		else
			event.target.heach = event.target.heach - 1
		end
	end		
end  

local function spawn()
	for i = 1, 6 do
		rand = math.random(1,5)
			if(rand==2 or rand==3)then
				i = i+1
				else
			object[i] = display.newImageRect(rocks, rand, 53, 53)
			object[i].id = rand 
			object[i].x = 53*i-20
			object[i].y = -26
			object[i].collType = "box"
			physics.addBody(object[i], dynamic, {bounce = 0, hasCollided = false})
			object[i]:setLinearVelocity(0,16*SPEED)
			object[i].isFixedRotation = true
			gameGroup:insert(3,object[i])
			object[i]:addEventListener( "tap", tapListener )
			object[i]:addEventListener( "touch", handleMove )
				if(object[i].id == 1)then
					object[i].heach = 2
				end	
			end

	end
	print(PATH)
end	




--------------------Кнопки------------------------------------------------------------

local function handleButtonEvent1( event )
 
	if ( "ended" == event.phase ) then
		print( "Button was pressed and released" )
			pauseGroup.isVisible = true
			button[1].isVisible = false
			timer.pause(timerspawn)
			speedBuff(2)
			print(PATH)
			timer.cancel(timerpatch)
			timer.pause(timerspace)
	end
end

local function handleButtonEvent2( event )
 
	if ( "ended" == event.phase ) then
		print( "Button was pressed and released" )
			clearMap()
			composer.gotoScene("menu")
	end
end

local function handleButtonEvent3( event )
 
	if ( "ended" == event.phase ) then
		print( "Button was pressed and released" )
			pauseGroup.isVisible = false
			button[1].isVisible = true
			timer.resume(timerspawn)
			speedBuff(1)
			timerpatch = timer.performWithDelay(1000*SPEED,patchUpdate, -1)
			timer.resume(timerspace)
	end
end

--------------------------------------------------------------------------------------
  

function callSpawn:timer(event)
	spawn()
	print("spawn")
	if(SPEED-WAS_SPEED >=0.5)then
		
		WAS_SPEED = SPEED
		TIMER  = TIMER - 400
		timer.cancel(timerspawn)
		speedBuff(1)
		timerspawn = timer.performWithDelay(TIMER,callSpawn, -1)
	end
	end

function callSpace:timer(event)

	background[1].y = background[1].y + SPEED*0.5
	background[2].y = background[2].y + SPEED*0.5
	
	if(background[1].y>display.contentCenterY*3)then
		background[1].y = -display.contentCenterY
	end
	if(background[2].y>display.contentCenterY*3)then
		background[2].y = -display.contentCenterY
	end
	
	pathBar[1].height = pathBar[1].height + ((PATH/pathBarHeight)/10*SPEED)
	pathBar[1].y = pathBar[1].y - ((PATH/pathBarHeight)/10*SPEED)/2
	print(pathBar[1].height)
	pathBar[1]:toFront()
	print(SPEED)
	
	if(SPEED<=4)then
	SPEED = SPEED + 0.001
	end

end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
			
			PATH = event.params["PATH"]
			
			button[1] = widget.newButton(
				{
					left      = 75,
					top       = 600,
					id        = "button1",
					label     = "Пауза",
					onEvent   = handleButtonEvent1,
					fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.2, 0.5, 0 } }
				}
			)
			gameGroup:insert(2,button[1])
			
			button[2] = widget.newButton(
				{
					left      = 75,
					top       = 400,
					id        = "button2",
					label     = "Меню",
					onEvent   = handleButtonEvent2,
					fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.2, 0.5, 0 } }
				}
			)
			
			pauseGroup:insert(2,button[2])

			button[3] = widget.newButton(
				{
					left      = 75,
					top       = 300,
					id        = "button3",
					label     = "Играть",
					onEvent   = handleButtonEvent3,
					fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.2, 0.5, 0 } }
				}
			)
			pauseGroup:insert(2,button[3])
			
				
			background[1] = display.newImageRect("starback.jpg", display.contentWidth*1.3, display.contentHeight*1.1)
			background[1].x = display.contentCenterX
			background[1].y = display.contentCenterY
			gameGroup:insert(1,background[1])
			background[2] = display.newImageRect("starback.jpg", display.contentWidth*1.3, display.contentHeight*1.1)
			background[2].x = display.contentCenterX
			background[2].y = -display.contentCenterY
			gameGroup:insert(1,background[2])
			timerspace = timer.performWithDelay(1,callSpace, -1)
			
			pathBar[1] = display.newRect(10,display.contentCenterY+275, 10, 1)
			pathBar[1]:setFillColor(0.4,0.2,0.6)
	
			pathBar[2] = display.newRect(10,display.contentCenterY, 15, display.contentHeight*0.8)
			mask:insert(5,pathBar[1])
			gameGroup:insert(4,pathBar[2])
			
			menu  = display.newImageRect("menu.png", display.contentWidth*0.8, display.contentHeight*0.8)
			menu.x = display.contentCenterX
			menu.y = display.contentCenterY
			pauseGroup:insert(1,menu)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
			gameGroup.isVisible = true
			pauseGroup.isVisible = true
			button[1].isVisible = false
			timerspawn = timer.performWithDelay(TIMER,callSpawn, -1)
			timer.pause(timerspawn)
			timer.pause(timerspace)
			mask.height = 0
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
			gameGroup.isVisible = false
			pauseGroup.isVisible = false
			timer.cancel(timerspawn)
			timer.cancel(timerpatch)
			timer.cancel(timerspace)
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
