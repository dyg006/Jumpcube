local composer = require( "composer" )
  local widget = require "widget"
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local bg
 local cube
 local text

 local goldKey
 



 local function ToMenu()
  --composer.gotoScene("Menu",{effect="crossFade"})
  composer.gotoScene("Fine.finaleStoria4to5",{effect="crossFade"})
end


function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 bg=display.newImage(sceneGroup,"Fine/ImmaginiFINE/finale4.jpg",display.contentCenterX,display.contentCenterY)
bg.width=display.contentWidth*1.18
bg.height=display.contentHeight*1

local text = display.newText( sceneGroup,  "Now I can open the door \nwith collected keys", display.contentCenterX*1.38, display.contentHeight*0.28, native.systemFont, 26 )
            text:setFillColor( 5 )


goldKey=widget.newButton({ defaultFile="Fine/ImmaginiFINE/goldKey.png", width=display.contentWidth*0.7,height=display.contentHeight*0.15,onPress=ToMenu})
goldKey.x=display.contentCenterX*1.64
goldKey.y=display.contentHeight*0.7
goldKey:scale( 0.30, 0.85)


sceneGroup:insert(text)

sceneGroup:insert(goldKey)

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