------------------------------------------------------------------------------------------
widget=require("widget")
widget.setTheme("widget_theme_ios")

--include composer
local composer=require "composer"
local mydata=require("mydata")



--APP OPTIONS
_APPNAME="JumpCube"
_SHOWADS=true
_PRICESHOP=100
_FONT="JoeMax.ttf"

--COSTANT VALUES
_CX=display.contentWidth*0.5
_CY=display.contentHeight*0.5
_CW=display.contentWidth
_CH=display.contentHeight
_T=display.screenOriginY --top
_L=display.screenOriginX --left
_R=display.viewableContentWidth - _L -- Right
_B=display.viewableContentHeight - _T --Bottom

--hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- SOUND EFFECT

_JUMP=audio.loadSound("assets/sounds/jump.mp3")
_COIN=audio.loadSound("assets/sounds/coin.wav")
_CLICK=audio.loadSound("assets/sounds/click2.ogg")
_GAMEOVER=audio.loadSound("assets/sounds/loose.wav")
_FIRESHOOT=audio.loadSound("assets/sounds/foom.wav")
_WEAR=audio.loadSound("assets/sounds/dustbin.ogg")
_KEY=audio.loadSound("assets/sounds/glass_bell.wav")
_END=audio.loadSound("assets/sounds/harp.mp3")
_BOOM=audio.loadSound("assets/sounds/boom.mp3")
_POP=audio.loadSound("assets/sounds/pop.mp3")



--include load/save library from coronarob
loadsave=require("loadsave")

objectToCollect={
"assets/images/game/keys/chiave.png",
"assets/images/game/keys/key2.png",
"assets/images/game/keys/key3.png",
"assets/images/game/keys/key4.png",
"assets/images/game/keys/key5.png",
"assets/images/game/keys/key6.png",
"assets/images/game/keys/key7.png",
"assets/images/game/keys/key8.png",
"assets/images/game/keys/key9.png",
"assets/images/game/keys/key10.png",
"assets/images/game/keys/key11.png",
"assets/images/game/keys/key12.png"

}



-- set up a saved file for our user
user = loadsave.loadTable("user.json")
if(user == nil) then 
	user = {}
	user.firstStart=true
	user.isFinished=false
	user.money = 0
	user.liveslevel = 0
	user.liveslevelmax = 10
	user.playmusic=true
	user.playsound = true
	loadsave.saveTable(user, "user.json")
end

levelCompleted=loadsave.loadTable("levelCompleted.json")

if(levelCompleted==nil)then
	levelCompleted={}

for i=1,#mydata.settings.levels  do
levelCompleted[i]={}
levelCompleted[i].id=i
levelCompleted[i].keyFound=false
levelCompleted[i].unlock=false
end
levelCompleted[1].unlock=true

loadsave.saveTable(levelCompleted,"levelCompleted.json")
end



if(	loadsave.loadTable("objectToCollect.json")==nil)then
loadsave.saveTable(objectToCollect,"objectToCollect.json")
end

shop = loadsave.loadTable("shop.json")
if(shop == nil) then 

shop={}
shop[1]={}
shop[1].image="assets/images/game/object/heart0.png"
shop[1].bought=false
shop[1].price=100



	loadsave.saveTable(shop, "shop.json")
end


if(loadsave.loadTable("bagpack.json")==nil)then
	myBagpack={}
loadsave.saveTable(myBagpack,"bagpack.json")
end




composer.gotoScene("scene.menu")

--Test Intro/Finale
--composer.gotoScene("Fine.finaleStoria1")