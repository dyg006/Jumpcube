local composer = require( "composer" )
  local widget = require "widget"
local scene = composer.newScene()


local loadsave=require("loadsave")
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local bg
 local cube
 local text
 local green_arrow 
 



 local function ToMenu()
  composer.gotoScene("scene.levelSelect",{effect="crossFade"})
end


function scene:create( event )
 
    local sceneGroup = self.view


local user=loadsave.loadTable("user.json")
user.firstStart=false
    loadsave.saveTable(user, "user.json")


    -- Code here runs when the scene is first created but has not yet appeared on screen
 bg=display.newImage(sceneGroup,"Intro/ImmaginiIntro/intro6.jpg",display.contentCenterX,display.contentCenterY)
bg.width=display.contentWidth*1.18
bg.height=display.contentHeight*1

local text = display.newText( sceneGroup,  "To get back home, collect \nthe keys during a fantastic \nadventure! \n                     Good journey!", display.contentCenterX*1, display.contentHeight*0.41, native.systemFont, 32 )
            text:setFillColor( 5 )

green_arrow=widget.newButton({ defaultFile="Intro/ImmaginiIntro/green-arrow.png", width=display.contentWidth*0.7,height=display.contentHeight*0.15,onPress=ToMenu})
green_arrow.x=display.contentCenterX*1.8
green_arrow.y=display.contentHeight*0.84
green_arrow:scale( 0.15, 0.8)

cube=display.newImage(sceneGroup,"assets/images/game/player0.png",0,1)
cube.sizex = 200
cube.sizey = 5
cube.x=display.contentCenterX*0.35
cube.y=display.contentHeight*0.88
cube:scale(0.8,0.8)
cube.rotate =45

sceneGroup:insert(text)
sceneGroup:insert(green_arrow)

end



-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
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