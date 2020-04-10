local composer = require( "composer" )
local scene = composer.newScene()
local sceneGroup

 
local widget = require( "widget" )
local myData = require( "mydata" )
--include load/save library from coronarob
loadsave=require("loadsave")

local onTouch=false
local pauseBackground

--BAGPACK
local bagpack
local myBagpack
local bagText
local rect


local goHomeTxt
local otherToCollectTxt

local levels

local video_icon
local bagCounter=0

local myBagpack
local toCollect

local open_bagpack

-- Declare vertices for vector stars (an image is probably preferable for an actual game).
local starVertices = { 0,-8,1.763,-2.427,7.608,-2.472,2.853,0.927,4.702,6.472,0.0,3.0,-4.702,6.472,-2.853,0.927,-7.608,-2.472,-1.763,-2.427 }
 
-- Button handler to cancel the level selection and return to the menu
local function handleCancelButtonEvent( event )
    if ( "ended" == event.phase ) then
    audio.play(_CLICK)
        composer.gotoScene( "scene.menu", { effect="crossFade", time=333} )
    end
end

-- Button handler to go to the final Animation
local function handleEndStoryButtonEvent( event )
    if ( "ended" == event.phase ) then
    audio.play(_CLICK)
        composer.gotoScene( "Fine.finaleStoria1", { effect="crossFade", time=333} )
    end
end
 

-- Button handler to go to the selected level
local function handleLevelSelect( event )
    if ( "ended" == event.phase ) then
    audio.play(_CLICK)

        -- Purge the game scene so we have a fresh start
    composer.removeScene( "scene.menu", false )
       composer.removeScene( "scene.game", false )
 
        -- Go to the game scene
     composer.gotoScene("scene.game", { effect="crossFade", time=333,params={numLiv=event.target.id}  } )

    end
end


local function onBagTouch(event)

    
if(event.phase=="began")then
event.target.alpha=0.5
else
  event.target.alpha=1
end



if(event.phase=="began")then
audio.play(_CLICK)

    if(onTouch==false)then
        onTouch=true
        
pauseBackground=display.newRect(sceneGroup,0,0,_CW*2,_CH*1.25)
pauseBackground.x=_CX; pauseBackground.y=_CY
pauseBackground:setFillColor(0)
pauseBackground.alpha=0.6


--bagpack:toFront()
bagpack.alpha=0
open_bagpack=display.newImageRect(sceneGroup,"assets/images/game/open_bagpack.png",64.7,64.3)
open_bagpack.x=bagpack.x; open_bagpack.y=bagpack.y
open_bagpack:addEventListener("touch",onBagTouch)

 bagText=display.newText(sceneGroup,"Objects",_CX,_CY*0.3,_FONT,75)
rect=display.newRoundedRect( sceneGroup,_CW*0.5, _CH*0.65, _CW*0.9, _CH*0.6,3)
rect.strokeWidth = 6
rect:setStrokeColor(1,1,1)
rect.fill={0,0,0,0}  



if(myBagpack~=nil) then
    local l=1
    local r=0
for i=1,#myBagpack do
  bagpack.objects[i]=display.newImageRect(myBagpack[i],50,50)
    sceneGroup:insert(bagpack.objects[i])
bagpack.objects[i]:toFront()
if(i%5==0)then
l=l+1
r=0
    end
 bagpack.objects[i].x=_CW*0.4+100*(r-1)
bagpack.objects[i].y=_CY*0.9+50*(l-1)
r=r+1
    end
end


if( toCollect[1]~="finished")then
   
otherToCollectTxt=display.newText(sceneGroup,#myBagpack.."/"..(#toCollect+#myBagpack),_CW*0.8,_CH*0.8,_FONT,35)
else
    goHomeTxt=display.newText(sceneGroup,"It's time to go home ",_CW*0.4,_CH*0.8,_FONT,25)

video_icon=widget.newButton{
defaultFile="assets/images/menu/animation.png",
overFile="assets/images/menu/over-animation.png",
x=_CW*0.8,
y=_CH*0.8,
width=60,
height=60,
onEvent=handleEndStoryButtonEvent


}
sceneGroup:insert(video_icon)
end

else
    onTouch=false

bagpack.alpha=1
open_bagpack.alpha=0

for i=1,#bagpack.objects do
bagpack.objects[i].alpha=0
    end
   
display.remove(pauseBackground)
display.remove(bagText)
display.remove(rect)
display.remove(otherToCollectTxt)
display.remove(goHomeTxt)
display.remove(video_icon)


end


end


end 
-- Declare the Composer event handlers
-- On scene create...
function scene:create( event )
   sceneGroup = self.view
    -- Create background
myBagpack=loadsave.loadTable("bagpack.json")
toCollect=loadsave.loadTable("objectToCollect.json")
levels=loadsave.loadTable("levelCompleted.json")




local background = display.newImage( sceneGroup,"assets/images/background_cloud.jpg",_CW*0.5,_CH*0.5)
 
    -- Use a scrollView to contain the level buttons (for support of more than one full screen).
    -- Since this will only scroll vertically, lock horizontal scrolling.
    local levelSelectGroup = widget.newScrollView({
        width = 460,
        height = 260,
        scrollWidth = 460,
        scrollHeight = 800,
        horizontalScrollDisabled = true,
        hideBackground=true
    })
 
    -- 'xOffset', 'yOffset' and 'cellCount' are used to position the buttons in the grid.
    local xOffset = 128
    local yOffset = 48
    local cellCount = 1
 
    -- Define the array to hold the buttons
    local buttons = {}

    for i = 1, #levels do
        -- Create a button
        buttons[i] = widget.newButton({
            label = tostring( i ),
            id = i,
            onEvent = handleLevelSelect,
            emboss = false,
            shape="roundedRect",
            width = 64,
            height = 64,
            font = native.systemFontBold,
            fontSize = 36,
            labelColor = { default = { 1, 1, 1 }, over = { 0.5, 0.5, 0.5 } },
            cornerRadius = 8,
            labelYOffset = -6, 
            fillColor = { default={ 0, 0.5, 1, 1 }, over={ 0.5, 0.75, 1, 1 } },
            strokeColor = { default={ 0, 0, 1, 1 }, over={ 0.333, 0.667, 1, 1 } },
            strokeWidth = 2
        })
        -- Position the button in the grid and add it to the scrollView
        buttons[i].x = xOffset
        buttons[i].y = yOffset
        levelSelectGroup:insert( buttons[i] )
 
        -- Check to see if the player has achieved (completed) this level.
        -- The '.unlockedLevels' value tracks the maximum unlocked level.
        -- First, however, check to make sure that this value has been set.
        -- If not set (new user), this value should be 1.


        if (levels[i].unlock ) then
            buttons[i]:setEnabled( true )
            buttons[i].alpha = 1.0
        else 
            buttons[i]:setEnabled( false ) 
            buttons[i].alpha = 0.5 
        end 
 
      
       -- local star = {} 
       -- if ( myData.settings.levels[i] and myData.settings.levels[i].stars and myData.settings.levels[i].stars > 0 ) then
           -- for j = 1, myData.settings.levels[i].stars do
 
          if(levels[i].keyFound)then
                star = display.newPolygon( 0, 0, starVertices )
                star:setFillColor( 1, 0.9, 0 )
                star.strokeWidth = 1
                star:setStrokeColor( 1, 0.8, 0 )
                star.x = buttons[i].x 
                star.y = buttons[i].y + 20
                levelSelectGroup:insert( star )
            end
          --  end
       -- end
 
        -- Compute the position of the next button.
        -- This tutorial draws 5 buttons across.
        -- It also spaces based on the button width and height + initial offset from the left.
        xOffset = xOffset + 75
        cellCount = cellCount + 1
        if ( cellCount > 4 ) then
            cellCount = 1
            xOffset = 128
            yOffset = yOffset + 90
        end
    end
 
    -- Place the scrollView into the scene and center it.
    sceneGroup:insert( levelSelectGroup )
    levelSelectGroup.x = display.contentCenterX
    levelSelectGroup.y = display.contentCenterY
 
    -- Create a home button for return to the menu scene.
local homeButton=widget.newButton{x=_CW,y=_CH*0.8,
width=64,
height=64,
id="home",
defaultFile="assets/images/menu/home.png",
overFile="assets/images/menu/home - over.png",
onRelease=handleCancelButtonEvent
}

    sceneGroup:insert( homeButton )


     bagpack=display.newImageRect(sceneGroup,"assets/images/game/red_bagpack.png",64.7,64.3)
bagpack.x=0; bagpack.y=_CH*0.7
bagpack.objects={}
bagpack:addEventListener("touch",onBagTouch)
bagpack.id="bag"


end
 
-- On scene show...
function scene:show( event )
    local sceneGroup = self.view
 
    if ( event.phase == "did" ) then
    end
end
 
-- On scene hide...
function scene:hide( event )
    local sceneGroup = self.view
 
    if ( event.phase == "will" ) then
    end
end
 
-- On scene destroy...
function scene:destroy( event )
    local sceneGroup = self.view   
end
 
-- Composer scene listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene