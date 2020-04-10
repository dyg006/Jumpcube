local composer = require( "composer" )
local scene = composer.newScene()

local loadsave=require("loadsave")

----------------------
------VARIABLES-------
----------------------



local purchase={}
local button={}

local bg --the background

local title 


local onSettings=false
local onTouch=false


local user = loadsave.loadTable("user.json")

--buttons
local btn_play
local btn_settings
local btn_exit
local shop_btn


local blackBackground
local pauseBackground

local shopText
local objectToBuy
local moneyTxt

local objectToBuy


local store={}
local button={}

local backgroundChannel

----------------------
------FUNCTIONS-------
----------------------

local function buy(event)
  menuPurchase=loadsave.loadTable("shop.json")
  audio.play(_CLICK)
  if(user.money-event.target.id>=0 and menuPurchase[event.target.id].bought==false)then
user.money=user.money-menuPurchase[event.target.id].price
moneyTxt.text="money: "..user.money.." $"
loadsave.saveTable(user,"user.json")
button[event.target.id].alpha=0.5
menuPurchase[event.target.id].bought=true
loadsave.saveTable(menuPurchase,"shop.json")
end
  end

local function onTouch_shopBtn(event)
    
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



 shopText=display.newText(sceneGroup,"Shop",_CX,_CY*0.3,_FONT,75)
  
     objectToBuy = widget.newScrollView({
        width = 460,
        height = 260,
        scrollWidth = 460,
        scrollHeight = 800,
        horizontalScrollDisabled = true,
        hideBackground=true
    })

moneyTxt=display.newText(sceneGroup,"money: "..user.money.." $",0,_CH*0.9,_FONT,30)
moneyTxt.anchorX=0



menuPurchase=loadsave.loadTable("shop.json")


for n=1,#menuPurchase do

  --   for i=1,3 do
local xOffset=150
store[n]=display.newRoundedRect(60+xOffset*(n-1),shopText.y+100+150*(n-1),100,100,8)
store[n]:setFillColor(0)
store[n].alpha=0.6

purchase[n]=display.newImageRect(menuPurchase[n].image,36,36)
purchase[n].x=store[n].x
 purchase[n].y=store[n].y
purchase[n]:toFront()
purchase[n].price=display.newText(menuPurchase[n].price.."$",purchase[n].x,purchase[n].y+40,_FONT,20)

button[n]=widget.newButton({x=store[n].x,y=store[n].y+70,width=store[n].width,height=20,label="BUY",id=n,onPress=buy})
if(menuPurchase[n].bought)then button[n].alpha=0.5 button[n]:setEnabled(false) end



objectToBuy:insert(store[n]) 
objectToBuy:insert(purchase[n])
objectToBuy:insert(button[n]) 
objectToBuy:insert(purchase[n].price) 

 end

--end




else
    onTouch=false

display.remove(pauseBackground)
display.remove(shopText)
display.remove(objectToBuy)
display.remove(moneyTxt)


end

end

end


local function onTouch_playBtn(event)
    audio.play(_CLICK)

if(user.firstStart)then
composer.gotoScene("Intro.intro",{effect="crossFade"})

else
composer.gotoScene("scene.levelSelect",{effect="crossFade"})
end

end

local function onTouch_Settings(event)





    if(event.phase=="began")then
      audio.play(_CLICK)
         if(onSettings == false)then 
             onSettings=true

     
blackBackground=display.newRect(sceneGroup,0,0,_CW*2,_CH*1.25)
blackBackground.x=_CX; blackBackground.y=_CY
blackBackground:setFillColor(0)
blackBackground.alpha=0.6

settingText=display.newText(sceneGroup,"SETTINGS",_CX,_CY*0.4,_FONT,50)

btn_exit=display.newImageRect(sceneGroup,"assets/images/menu/exit.png",40,40)
btn_exit.x=_CW*0.5; btn_exit.y=_CH*0.9

btn_settings:removeEventListener("touch",onTouch_Settings)
btn_exit:toFront()
btn_exit:addEventListener("touch",onTouch_Settings)

btn_play:setEnabled(false)
shop_btn:setEnabled(false)

user=loadsave.loadTable("user.json")

btn1=widget.newButton({x=_CW*0.5-100,
y=_CH*0.5,
width=80,
height=80,
shape="roundedRect",
--onPress=function() if(user.playmusic)then user.playmusic=false audio.stop() else  user.playmusic=false end loadsave.saveTable(user,"user.json")  end,
fillColor= { default={ 1, 1, 1, 0.5 }, over={ 1, 0.2, 0.5, 1 } }
  })

btn2=widget.newButton({x=_CW*0.5+100,
y=_CH*0.5,
width=80,
height=80,
shape="roundedRect",
fillColor= { default={ 1, 1, 1, 0.5 }, over={ 1, 0.2, 0.5, 1 } }
  })


sceneGroup:insert(btn2)
sceneGroup:insert(btn1)

music_btn=display.newImageRect(sceneGroup,"assets/images/menu/settings/music.png",80,80)
music_btn.x=_CW*0.5-100 ; music_btn.y=_CH*0.5

sound_btn=display.newImageRect(sceneGroup,"assets/images/menu/settings/sound.png",80,80)
sound_btn.x=_CW*0.5+100 ; sound_btn.y=_CH*0.5



else
onSettings=false
btn_play:setEnabled(true)
shop_btn:setEnabled(true)

btn_exit:removeEventListener("touch",onTouch_Settings)
btn_settings:addEventListener("touch",onTouch_Settings)

display.remove(btn1)
display.remove(btn2)


display.remove(music_btn)
display.remove(sound_btn)



    
    display.remove(blackBackground)
    display.remove(settingText)
    display.remove(btn_exit)
end
end


end

-- create()
function scene:create( event )

  sceneGroup = self.view



_BACKGROUNDMUSIC = audio.loadStream("assets/music/bensound-energy.mp3")

bg=display.newImageRect(sceneGroup,"assets/images/menu/background_3.png",_CW*1.3,_CH*1.1)
bg.x=_CW*0.5; bg.y=_CH*0.5

title=display.newImageRect(sceneGroup,"assets/images/menu/title.png",200,100)
title.x=_CW*0.4; title.y=_CH*0.8


----buttons

--BUTTON TO PLAY
btn_play=widget.newButton{x=_CW*0.8,y=_CH*0.4,
width=120,
height=120,
defaultFile="assets/images/menu/play.png",
overFile="assets/images/menu/play-over.png",
onRelease=onTouch_playBtn}
sceneGroup:insert(btn_play)

--BUTTON FOR THE SHOP
shop_btn=widget.newButton{x=_CW,
  y=_CH*0.8,
width=60, height=60,
defaultFile="assets/images/menu/shop_btn.png",
onEvent=onTouch_shopBtn
}
sceneGroup:insert(shop_btn)



--BUTTON FOR SETTINGS
btn_settings=display.newImageRect(sceneGroup,"assets/images/menu/settings.png",64,64)
btn_settings.x=_CW*0.05; btn_settings.y=_CH*0.1
btn_settings:addEventListener("touch",onTouch_Settings)


--[[
local lfs = require ( "lfs" )
local path = system.pathForFile( "images", system.DocumentsDirectory )
for file in lfs.dir ( path ) do
	
	print (file) 
end
]]
end


-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    backgroundChannel= audio.play(_BACKGROUNDMUSIC,{loop=-1})


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
    audio.stop()
    audio.dispose(_BACKGROUNDMUSIC )  -- Release music handle
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


