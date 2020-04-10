local composer = require( "composer" )
  local widget = require "widget"
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local bg
 local text
 local green_arrow 
 



 local function ToMenu()
  composer.gotoScene("Intro.intro2",{effect="crossFade"})
end


function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 bg=display.newImage(sceneGroup,"Intro/ImmaginiIntro/intro1.jpg",display.contentCenterX,display.contentCenterY)
bg.width=display.contentWidth*1.18
bg.height=display.contentHeight*1.1

local text = display.newText( sceneGroup,  "Where am I?\n", display.contentCenterX, display.contentCenterY, native.systemFont, 32 )
            text:setFillColor( 5 )

green_arrow=widget.newButton({ defaultFile="Intro/ImmaginiIntro/green-arrow.png", width=display.contentWidth*0.7,height=display.contentHeight*0.15,onPress=ToMenu})
green_arrow.x=display.contentCenterX
green_arrow.y=display.contentHeight*0.9
green_arrow:scale( 0.15, 0.8)

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