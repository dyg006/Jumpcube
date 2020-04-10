local composer = require( "composer" )
local scene = composer.newScene()


local widget=require("widget")
local physics = require( "physics" )

require("scene.game.CaricaMappa")


local btn_fire=nil


--include load/save library from coronarob
local loadsave=require("loadsave")
local perspective = require("camera.perspective")
local myData=require("mydata")

require("timer2")


physics.start()
physics.setGravity(0,12)


local accessory=nil

local camera = perspective.createView()


local player={}
local playerEarnMoney=0

local myBagpack=loadsave.loadTable("bagpack.json")

local playerCount=1

local playerisBlue=false
local playerisRed=false

local level={bagpack="assets/images/game/red_bagpack.png"}


local objectData={
{image="assets/images/game/object/denaro.png", money=150,width=50,height=50},
{image="assets/images/game/object/coin.png", money=50,width=40,height=40},
}


--[[
local objectData={
{image="assets/images/game/object/paint_can_red.png",color="red",width=45,height=45}}
]]
local specialObject={}

local thisEnemies


local numFireball=0
local fireball={}



local object={}
local objectCounter=0

local MusicLevel

local thisMap  --the map used for the level
local pauseGame=false
local gameIsEnded=false

local pauseBackground
local pauseText
local hasAccessory=false

local stopGame=false

local objectToCollect

local otherToCollectTxt

local bag
local stop=false

local isBlue=false
local isRed=false

local comandi

local  numLiv

local positionForKey
local key

local bg

local scoreText
local scoreTextStroke

local front
local back

local user=loadsave.loadTable("user.json")

local bombPositions

local bomb={}
local bombCounter=0

local enemyPositions
local enemy={}
local enemyCounter=0

local lives={}
local livesMax=3
local actualLives=livesMax

local obstacles={}
local obstaclesCount=0

local enemySpeed=10

local homeButton

local backgroundMusicChannel

local otherToCollectTxt

local noColor=true

local open_bagpack --@

local timerFinished

local timerTransformation

local playerSpeed=3.9

local levels=loadsave.loadTable("levelCompleted.json")

local playerSheetData={width=60,height=60,numFrames=8, sheetContentWidth=480,sheetContentHeight=60 }
local playerSheet=graphics.newImageSheet("assets/images/game/player.png",playerSheetData)
local playerSequenceData={
  {name="finished",start=1,count=1},
   {name="jumping",start=2,count=1},
  {name="standing",start=3,count=1},
  {name="blue",start=4,count=1},
{name="redStanding",start=5,count=1},
{name="shooting",start=6,count=1},
  {name="sad",start=7,count=1},
  {name="coin",start=8,count=1}
}

--[[
local playerSheetData={width=60,height=60,numFrames=20, sheetContentWidth=1200,sheetContentHeight=60 }
local playerSheet=graphics.newImageSheet("assets/images/game/player_color.png",playerSheetData)
local playerSequenceData={
  {name="finished",start=1,count=1},
   {name="jumping",start=2,count=1},
  {name="standing",start=3,count=1},


  {name="blue",start=4,count=1},
{name="redStanding",start=5,count=1},
{name="shooting",start=6,count=1},
  {name="sad",start=7,count=1},
  {name="coin",start=8,count=1}
}
]]


local function nextLevel(event)
if(event.phase=="ended")then
transition.cancel()
audio.stop()
audio.play(_CLICK)
camera:cancel()
camera:destroy()
 composer.removeScene("scene.game")
timer.performWithDelay(500,function() composer.gotoScene("scene.game",{effect="crossFade",params={numLiv=numLiv+1}}) end)
end
end

local function returnToMenu(event)
if(event.phase=="ended")then
audio.stop()
audio.play(_CLICK)
transition.cancel()
camera:cancel()
camera:destroy()
 composer.removeScene("scene.game")
composer.gotoScene("scene.levelSelect","slideRight")
end
end

 local function restartLevel(event)

if(event.phase=="ended")then
transition.cancel()
audio.play(_CLICK)
camera:cancel()
camera:destroy()
composer.removeScene("scene.game")
composer.gotoScene("scene.game",{params={numLiv=numLiv}}) 
end
 end


local function fireballCollision(self,event)

	if(event.phase=="began")then
if(event.other.id~="player")then
--[[
  if(event.other.id=="crate")then
event.other.bodyType="dynamic"
print(event.other.bodyType)
print("boom")
  end

]]
if(event.other.id=="enemy")then

event.other:applyLinearImpulse(0.01,0.0001,event.x,event.y)
transition.cancel(event.other)
Runtime:removeEventListener("enterFrame",event.other)
display.remove(event.other)
--transition.to(event.other,{alpha=0, time=500, onComplete=function(self)  display.remove(self)end})
--poof?
--play poof
playerEarnMoney=playerEarnMoney+100
scoreText.text=playerEarnMoney.." $"
scoreTextStroke.text=playerEarnMoney.." $"
user.money=user.money+100
loadsave.saveTable(user,"user.json")
end

self:removeEventListener("collision")
display.remove(self)
end

end
end


local function playerShoot(event)

--[[
if(event.phase=="began")then
numFireball=numFireball+1


print(player[playerCount].x,event.x)
fireball[numFireball]=display.newImageRect(sceneGroup,"assets/images/game/fireball.png",36,30)

fireball[numFireball].x=event.x; fireball[numFireball].y=event.y
--local dy=math.abs(event.y+_CH*0.5+fireball[numFireball].height*0.5-player[playerCount].y)
--local dx=math.abs(event.x+_CW*0.6-player[playerCount].x)
--local distance=math.sqrt((dx*dx)+(dy*dy))

--transition.to(fireball[numFireball],{
  --time=distance*1,
--  y=event.y+_CH*0.5+fireball[numFireball].height*0.5,
  -- x=event.x+player[playerCount].width-fireball[numFireball].width*0.5
-- , onComplete=function(self)  display.remove(self) end
--} )

--camera:add(fireball[numFireball],1,false)
end]]
  if(isRed)then
  audio.play(_FIRESHOOT)
--ANIMATION OF SHOOTING
player[playerCount]:setSequence("shooting")
player[playerCount]:play()

timerTransformation= timer.performWithDelay(1000,function() 
if(isRed)then
  player[playerCount]:setSequence("redStanding") end end)
numFireball=numFireball+1


fireball[numFireball]=display.newImageRect("assets/images/game/fireball.png",36,30)
fireball[numFireball].x=player[playerCount].x; fireball[numFireball].y=player[playerCount].y



physics.addBody(fireball[numFireball],"dynamic")

fireball[numFireball].collision=fireballCollision
fireball[numFireball]:addEventListener("collision")

fireball[numFireball].isSensor=true  --??
fireball[numFireball].gravityScale=0
fireball[numFireball].id="fireball"


transition.to(fireball[numFireball],{x=fireball[numFireball].x+500,onComplete=function(self) 	display.remove(self) end})

--print(event.x,event.y)
camera:add(fireball[numFireball],1,false)

else
player[playerCount]:setSequence("standing")
player[playerCount]:play()
end

end


 local function movePlayer(self,event) 
  
  if(front)then
self.x= self.x+playerSpeed

     end

if(back)then
   self.x=  self.x-playerSpeed




if(self.accessory)then  
 self.accessory.x=self.x 
 self.accessory.y=self.y+self.accessory.yOffset


  end 

end
end


local function changeColor(color)



if(color=="blue")then 


  
  noColor=false
local timerCounter=10
local timerText=display.newText(sceneGroup,timerCounter,_CW*0.5, _CH*0.2,_FONT,25)
local timerStroke=display.newText(sceneGroup,timerCounter,_CW*0.506, _CH*0.205,_FONT,26)

player[playerCount]:setSequence("blue")
player[playerCount]:play()

isBlue=true


timer.performWithDelay(1000,function () 
  timerCounter=timerCounter-1
timerText.text=timerCounter
timerStroke.text=timerCounter
if(timerCounter<4) then timerText:setFillColor(1,0,0)  end end,timerCounter-1,"color")
timerStroke:setFillColor(0)
timerText:toFront()

timer.performWithDelay(1000*timerCounter,function ( ) display.remove(timerText) display.remove(timerStroke) 
 changeColor("") end,"color")




else if(color=="red" )then

  isRed=true
noColor=false
player[playerCount]:setSequence("redStanding")
player[playerCount]:play()


btn_fire=display.newImageRect(sceneGroup,"assets/images/game/fire_btn.png",55,50)
btn_fire.x=_CW;btn_fire.y=_CH*0.55
btn_fire:addEventListener("tap",playerShoot) 

--Runtime:addEventListener("touch",playerShoot) 

  
local timerCounter=10
local timerText=display.newText(sceneGroup,timerCounter,_CW*0.5, _CH*0.2,_FONT,25)
local timerStroke=display.newText(sceneGroup,timerCounter,_CW*0.506, _CH*0.205,_FONT,26)

timer.performWithDelay(1000,function () 
  timerCounter=timerCounter-1
timerText.text=timerCounter
timerStroke.text=timerCounter
if(timerCounter<4) then timerText:setFillColor(1,0,0)  end end,timerCounter-1,"color")
timerStroke:setFillColor(0)
timerText:toFront()

timer.performWithDelay(1000*timerCounter,function ( ) display.remove(timerText) display.remove(timerStroke) 
btn_fire:removeEventListener("tap",playerShoot) 
 changeColor("") end,"color")


else
  noColor=true
player[playerCount]:setSequence("standing")
player[playerCount]:play()
isBlue=false
isRed=false
display.remove(btn_fire)

end
end



end

local function followElevator(self,event)
player[playerCount].x=self.x


  end


 function onCollision(self,event) 



  if(event.phase=="began")then
--[[
if(event.other.isElevator)then
--print("elevator")
event.other.enterFrame=followElevator
Runtime:addEventListener("enterFrame",event.other)
end]]

  	if(event.other.id=="key")then
    
	  audio.play(_KEY)

local key=display.newImageRect(sceneGroup,event.other.image,36,36)
display.remove(event.other)
key.x=_CW*0.5; key.y=_CH*0.5
transition.to(key,{time=300,xScale=2,yScale=2})
transition.to(key,{time=1000,y=bagpack.y,x=bagpack.x,delay=1000,onComplete=function(self)display.remove(self) end})

local number_object=#myBagpack+1
 local text=display.newText(sceneGroup,number_object.."/"..(#objectToCollect+#myBagpack),bagpack.x,bagpack.y+20,_FONT,20)
 text:toFront()
transition.to(text,{time=1000,delay=1400,alpha=0,onComplete=function ( self ) display.remove(self)end})


--insert the key in the bagpack
table.insert(myBagpack,event.other.image)
loadsave.saveTable(myBagpack, "bagpack.json")
levels[numLiv].keyFound=true
loadsave.saveTable(levels,"levelCompleted.json")
--display.remove(event.other)

if(#objectToCollect>1)then
  --update the bagpack
table.remove(objectToCollect,event.other.num)
loadsave.saveTable(objectToCollect, "objectToCollect.json")

else
  loadsave.saveTable({"finished"}, "objectToCollect.json")
end

end



if(event.other.id=="object" )then
 if(event.other.money~=nil)then
if(noColor)then
player[playerCount]:setSequence("coin")
player[playerCount]:play()

timerTransformation= timer.performWithDelay(1000,function()  
 player[playerCount]:setSequence("standing") player[playerCount]:play()

  end)
end



local dtxt=display.newText(event.other.money.." $",self.x,self.y,_FONT,20)
camera:add(dtxt, 1,false)
transition.to(dtxt,{time=2000,alpha=0,y=dtxt.y+10})

--add money
playerEarnMoney=playerEarnMoney+event.other.money
scoreText.text=playerEarnMoney.." $"
scoreTextStroke.text=playerEarnMoney.." $"
user.money=user.money+event.other.money
loadsave.saveTable(user,"user.json")
if(event.other.type=="diamond")then
  audio.play(_COIN)

else
audio.play(_COIN)
end
 end

if(event.other.type=="accessory")then 
self.accessory=display.newImageRect(sceneGroup,event.other.image,event.other.width,event.other.height)
self.accessory.yOffset=event.other.yOffset
self.accessory.x=self.x
self.accessory.y=self.y+self.accessory.yOffset

camera:add(self.accessory,1,false)
audio.play(_WEAR)

end

if(event.other.type=="flash")then 
playerSpeed=8

----timer


end

if(event.other.color=="blue")then
	if(isBlue==false)then
changeColor("blue")
else
playerEarnMoney=playerEarnMoney+10
scoreText.text=playerEarnMoney.." $"
scoreTextStroke.text=playerEarnMoney.." $"
user.money=user.money+10
loadsave.saveTable(user,"user.json")

end
isRed=false
end

if(event.other.color=="red")then
	if(isRed==false)then
changeColor("red")
else 
playerEarnMoney=playerEarnMoney+10
scoreText.text=playerEarnMoney.." $"
scoreTextStroke.text=playerEarnMoney.." $"
user.money=user.money+10
loadsave.saveTable(user,"user.json")

end
isBlue=false

end

display.remove(event.other)
end


if(event.other.id=="flag" or (event.other.id=="water" and isBlue==false) or event.other.id=="peak" or event.other.id=="enemy" or event.other.id=="bomb")then

if(event.other.id=="bomb")then
  audio.play(_BOOM)
local explosion=display.newImageRect("assets/images/game/explosion.png",40,40)
explosion.alpha=1
explosion.x=event.other.x; explosion.y=event.other.y
camera:add(explosion, 2,false)


self:applyForce(10,-10, event.other.x, event.other.y)  
self.isFixedRotation=false
display.remove(event.other)
transition.to(explosion,{time=200, xScale=5,yScale=5,alpha=0})
end


if(actualLives>1)then
if(event.other.id=="enemy" or event.other.id=="peak")then 
lives[actualLives].alpha=0
actualLives=actualLives-1

local lostLife=display.newImageRect("assets/images/game/heart.png",36,36)
lostLife.x=self.x; lostLife.y=self.y
camera:add(lostLife, 1,false)
transition.to(lostLife,{time=2000,alpha=0,y=lostLife.y-100})
audio.play(_POP)

return
end
end

Runtime:removeEventListener("enterFrame",player[playerCount])
--disabled the jump button
for i=1,comandi.numChildren do
display.remove(comandi)
end

btn_pause.alpha=0


if(isRed)then
btn_fire:removeEventListener("tap",playerShoot)
end


if(accessory~=nil)then
transition.to(self.accessory,{alpha=0})
end

timer.cancel("color")

transition.to(player[playerCount],{alpha=0.5, time=1000})

player[playerCount]:removeEventListener("collision")


if(event.other.id=="flag")then
  audio.play(_END)
  if(noColor)then
  player[playerCount]:setSequence("finished")
player[playerCount]:play()
end
player[playerCount]:setLinearVelocity(10,0)
 timerFinished= timer.performWithDelay(1000,onLevelCompleted)
 return
  end

if(noColor)then
player[playerCount]:setSequence("sad")
player[playerCount]:play() end

local angel=display.newImageRect("assets/images/game/player_dead.png",85,60)
angel.x=self.x; angel.y=self.y
angel.alpha=0
camera:add(angel, 2,false)
transition.to(angel,{time=1000,alpha=1,delay=0,y=angel.y-50})
transition.to(angel,{time=500,alpha=0,delay=1000})

for i=1,actualLives do
lives[i].alpha=0

  end



timerFinished=timer.performWithDelay(1500,onGameOver)



end
else
	
--[[
if(event.other.isElevator)then
--print(" end elevator")
Runtime:removeEventListener("enterFrame",event.other)
end]]

end



if(self~=nil)then
self:setLinearVelocity(0,0) end
end





local function onPauseTouch(event)

if(event.phase=="began" )then
event.target.alpha=0.5
else
  event.target.alpha=1
end



local nameButton=event.target.id
if(event.phase=="began")then

timer.pause("color")

for i=1,comandi.numChildren do
comandi[i].alpha=0
end

if(timerFinished)then
  timer.pause(timerFinished)end


if(timerTransformation)then
timer.pause(timerTransformation)
end

    audio.pause()
    transition.pause()
     audio.play(_CLICK)
     physics.pause()

      for i=1,enemyCounter do
  Runtime:removeEventListener("enterFrame",enemy[i])
end

Runtime:removeEventListener("enterFrame",player[playerCount])

if(isRed)then
btn_fire:removeEventListener("tap",playerShoot)end



--both bagpack and pause button
if(pauseGame == false)then 
--the game is running and we need to pause it
pauseGame=true



pauseBackground=display.newRect(sceneGroup,0,0,_CW*2,_CH*1.25)
pauseBackground.x=_CX; pauseBackground.y=_CY
pauseBackground:setFillColor(0)
pauseBackground.alpha=0.6



if(nameButton=="pause")then
pauseText=display.newText(sceneGroup,"Game Pause",_CX,_CY*0.6,_FONT,75)


btn_pause:toFront()
bagpack:removeEventListener("touch",onPauseTouch)

  -- Create a home button for return to the menu scene.
 homeButton=widget.newButton{x=_CW*0.7,y=_CH*0.7,
width=85,
height=87,
id="home",
defaultFile="assets/images/menu/home.png",
overFile="assets/images/menu/home - over.png",
onRelease=returnToMenu
}

btn_replay=widget.newButton{
  width=85,
  height=87,
  defaultFile="assets/images/game/replay_btn.png",
    overFile="assets/images/game/over-replay_btn.png",

  x=_CW*0.3,
  y=homeButton.y,
  --defaultFile
    onEvent=restartLevel
}


    sceneGroup:insert( homeButton )
        sceneGroup:insert( btn_replay )



else --show inventory
 

--bagpack:toFront()
bagpack.alpha=0
open_bagpack=display.newImageRect(sceneGroup,"assets/images/game/open_bagpack.png",64.7,64.3)
open_bagpack.x=bagpack.x; open_bagpack.y=bagpack.y
open_bagpack:addEventListener("touch",onPauseTouch)
open_bagpack.id="bag"


btn_pause:removeEventListener("touch",onPauseTouch)
bagText=display.newText(sceneGroup,"Objects",_CX,_CY*0.3,_FONT,75)
rect=display.newRoundedRect( _CW*0.5, _CH*0.65, _CW*0.9, _CH*0.6,3)
rect.strokeWidth = 6
rect:setStrokeColor(1,1,1)
rect.fill={0,0,0,0}

local lastObjects=loadsave.loadTable("objectToCollect.json")

if(lastObjects[1]~="finished")then
otherToCollectTxt=display.newText(sceneGroup,#myBagpack.."/"..(#objectToCollect+#myBagpack),_CW*0.8,_CH*0.8,_FONT,35)
else
otherToCollectTxt=display.newText(sceneGroup,#myBagpack.."/"..#myBagpack,_CW*0.8,_CH*0.8,_FONT,35)

end

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

end
else
--the game is paused ,and we need to unpaused it



pauseGame=false

physics.start()
audio.resume()
transition.resume()
if(timerFinished)then
  timer.resume(timerFinished)end

  if(timerTransformation)then
timer.resume(timerTransformation)
end

timer.resume("color")


 for i=1,enemyCounter do
  Runtime:addEventListener("enterFrame",enemy[i])
end

Runtime:addEventListener("enterFrame",player[playerCount])


if(isRed)then
btn_fire:addEventListener("tap",playerShoot)end

for i=1,comandi.numChildren do
comandi[i].alpha=1
end
display.remove(pauseBackground)


if(nameButton=="bag") then
bagpack.alpha=1
open_bagpack.alpha=0

btn_pause:addEventListener("touch",onPauseTouch)

for i=1,#bagpack.objects do
bagpack.objects[i].alpha=0
	end

display.remove(bagText)
display.remove(rect)
display.remove(otherToCollectTxt)

else
bagpack:addEventListener("touch",onPauseTouch)
	display.remove(btn_play)
  display.remove(otherToCollectTxt)

display.remove(pauseText)
display.remove(homeButton)
display.remove(btn_replay)





end


  end
end
 end

 function onGameOver() 

audio.stop()
audio.play(_GAMEOVER)
physics.stop()
transition.cancel()

bagpack:removeEventListener("touch",onPauseTouch)
btn_pause:removeEventListener("touch",onPauseTouch)

Runtime:removeEventListener("enterFrame",player[playerCount])
player[playerCount]:removeEventListener("collision")


 for i=1,enemyCounter do
  Runtime:removeEventListener("enterFrame",enemy[i])
end

gameOverBackground=display.newRect(sceneGroup,0,0,_CW*2,_CH*1.25)
gameOverBackground.x=_CX; gameOverBackground.y=_CY
gameOverBackground:setFillColor(0)
gameOverBackground.alpha=0.6


gameOverText=display.newText(sceneGroup,"GAME OVER",_CX,_CY*0.55,_FONT,60)



btn_replay=widget.newButton{
  width=85,
  height=87,
  defaultFile="assets/images/game/replay_btn.png",
    overFile="assets/images/game/over-replay_btn.png",

  x=_CW*0.5,
  y=gameOverText.y+100,
  --defaultFile
    onEvent=restartLevel
}




pause_returnToMenu=widget.newButton{
    x=_CW,
     y=_CH*0.8,
width=64,
height=64,
id="home",
defaultFile="assets/images/menu/home.png",
overFile="assets/images/menu/home - over.png",
    onEvent=returnToMenu
}

  
sceneGroup:insert(pause_returnToMenu)
sceneGroup:insert(btn_replay)
end


function onLevelCompleted() 
  audio.stop(backgroundMusicChannel)
physics.stop()
transition.cancel()

--BUTTONS
bagpack:removeEventListener("touch",onPauseTouch)
btn_pause:removeEventListener("touch",onPauseTouch)
if(isRed)then
btn_fire:removeEventListener("tap",playerShoot)
end




levelCompleteBackground=display.newRect(sceneGroup,0,0,_CW*2,_CH*1.25)
levelCompleteBackground.x=_CX; levelCompleteBackground.y=_CY
levelCompleteBackground:setFillColor(0)
levelCompleteBackground.alpha=0.6


levelCompleteText=display.newText(sceneGroup,"LEVEL COMPLETED",_CX,_CY*0.6,_FONT,45)
FinalMoneyText=display.newText(sceneGroup,playerEarnMoney.."$",_CX,_CY,_FONT,50)





 for i=1,enemyCounter do
  Runtime:removeEventListener("enterFrame",enemy[i])
end





btn_returnToMenu=widget.newButton{
  x=_CW*0.1,
  y=_CH*0.8,
width=64,
height=64,
id="home",
defaultFile="assets/images/menu/home.png",
overFile="assets/images/menu/home - over.png",
    onEvent=returnToMenu
}




if(numLiv<#levels)then
levels[numLiv+1].unlock=true
levels[numLiv].isCompleted=true

btn_next=widget.newButton{
  width=85,
  height=87,
  defaultFile="assets/images/game/next.png",
  overFile="assets/images/game/next - over.png",
  --defaultFile
  --defaultFile
  --OverFile
   onEvent=nextLevel
}
btn_next.x=_CW*0.8
btn_next.y=_CH*0.6
sceneGroup:insert(btn_next)

loadsave.saveTable(levels,"levelCompleted.json")


end




player[playerCount]:removeEventListener("collision")
Runtime:removeEventListener("enterFrame",player[playerCount])


sceneGroup:insert(btn_returnToMenu)

end


local function startGame()
local startGame=display.newGroup()


local background=display.newRect(startGame,_CW*0.5,_CH*0.5,_CW*2,_CH*1.25)
background:setFillColor(0)
background.alpha=0.6


local text=display.newText(startGame,"START",_CW*0.5,_CH*0.2,_FONT,35)

local button=widget.newButton{
  
x=_CW*0.5,
y=_CH*0.5,
label="Press",
  onRelease=function() 
  display.remove(startGame)

end
}
startGame:insert(button)


end


local function newControls()

comandi=display.newGroup()

local function moveFront(event)

if(event.phase=="began")then  front=true  

end 

if(event.phase=="ended" or event.phase=="cancelled")then back=false  front=false  end 

end

local function moveBack(event)

 if(event.phase=="began")then 
  back=true  end 
   if(event.phase=="ended" or event.phase=="cancelled")then
    back=false  front=false  end 
end




local function Jump(event)

player[playerCount]:setLinearVelocity(0,-310)



 if(event.phase=="began")then 
  if(noColor)then
player[playerCount]:setSequence("jumping")
player[playerCount]:play()
timerTransformation=timer.performWithDelay(1000,function()
if(noColor)then
 player[playerCount]:setSequence("standing")
player[playerCount]:play()  end end)

end
  audio.play(_JUMP) 
end


end

back=widget.newButton {
defaultFile="assets/images/game/left.png",
overFile="assets/images/game/overLeft.png",
width=85,
height=85,
onEvent=moveBack,
x=display.contentWidth*0.01,
y=display.contentHeight*0.85,
id="back"
}
comandi:insert(back)

front=widget.newButton {
defaultFile="assets/images/game/front.png",
overFile="assets/images/game/overFront.png",
width=85,
height=85,
x=display.contentWidth*0.2,
y=display.contentHeight*0.85,
onEvent=moveFront,
id="front"
}
comandi:insert(front)

jump=widget.newButton {
defaultFile="assets/images/game/jump.png",
overFile="assets/images/game/overJump.png",
width=85,
height=85,
onEvent=Jump,

x=display.contentWidth*0.99,
y=display.contentHeight*0.85,

}
comandi:insert(jump)



return comandi
end



local function enemyMove(self) 


  function moveToRight(self)
      
         transition.to( self, { time=(self.range-self.width*0.5)/0.1,x=self.x+self.range-self.width 
          , onComplete = moveToLeft
          } )
      
             end

 function moveToLeft(self)
  
        transition.to( self, { time=(self.range-self.width*0.5)/0.1,x=self.x+self.width-self.range
        , onComplete =  moveToRight  
         } )

      end


transition.to(self,{time=(self.range*0.5)/0.1,x=self.x+self.range*0.5-self.width*0.5
 ,onComplete=moveToLeft
  } )



end



local function obstacleMove(self,direction)

if(direction=="horizontal")then 
    function moveLeft(self)

      transition.to( self, { time=1000,x=(self.x-100), y=(self.y), onComplete = moveRight } )
    end

function moveRight(self)

      transition.to( self, {time=1000, x=(self.x+100), y=(self.y), onComplete = moveLeft } )
    end

 moveRight(self)
end

if(direction=="vertical")then
  function moveUp(self)

      transition.to( self, { time=1000,x=self.x, y=(self.y-100), onComplete = moveDown } )
    end

function moveDown(self)

      transition.to( self, {time=1000, x=self.x, y=(self.y+100), onComplete = moveUp } )
    end

 moveDown(self)



  end
end



local function flying(self,event)
self.x=self.x-1
self.angle=self.angle+.1

self.y=10*math.sin(self.angle)+self.initY

end





-- create()
function scene:create( event )
 sceneGroup = self.view




numLiv=event.params.numLiv
MusicLevel=audio.loadStream(myData.settings.levels[numLiv].music)

thisMap= myData.settings.levels[numLiv].map
thisEnemies=myData.settings.levels[numLiv].enemies



if(thisMap=="JungleMap")then
bg=display.newImageRect(sceneGroup,"assets/images/game/jungle_bg.jpg",_CW*1.3,_CH*1.3)
bg.x=_CW*0.5; bg.y=_CH*0.5
end


if(thisMap=="TestMap")then
bg=display.newImageRect(sceneGroup,"assets/images/game/sky2.png",_CW*1.3,_CH*1.3)
bg.x=_CW*0.5; bg.y=_CH*0.5
end

if(thisMap=="MysteryMap")then
bg=display.newImageRect(sceneGroup,"assets/maps/MysteryMapSky.png",_CW*1.3,_CH*1.3)
bg.x=_CW*0.5; bg.y=_CH*0.5
end

map=loadMap(thisMap)



local startingPt=map:findObject("start")



--player[playerCount]=display.newImageRect("assets/images/game/player0.png",38,38)


player[playerCount]=display.newSprite(playerSheet,playerSequenceData)
player[playerCount]:setSequence("standing")
player[playerCount]:play()

local pW=player[playerCount].width*0.5*0.65

physics.addBody(player[playerCount],{
  shape={ -pW,pW, -pW,-pW, pW,-pW, pW,pW}})
player[playerCount].isFixedRotation=true
player[playerCount].id="player"

player[playerCount]:scale(0.65,0.65)


if(startingPt)then
player[playerCount].x=startingPt.x
player[playerCount].y=startingPt.y
else
  player[playerCount].y=400
  player[playerCount].x=130
end

player[playerCount].collision=onCollision
player[playerCount]:addEventListener("collision")

player[playerCount].enterFrame=movePlayer

Runtime:addEventListener("enterFrame",player[playerCount])



camera:add(player[playerCount], 1,true)





camera:add(map, 2,false)

objectToCollect=loadsave.loadTable("objectToCollect.json")
       local positionForKey=map:listTypes("key")


if(#positionForKey>0 and objectToCollect[1]~="finished" and levels[numLiv].keyFound==false)then
local n=math.random(#positionForKey)
local k=math.random(#objectToCollect)
key=display.newImageRect(objectToCollect[k],36,36)
key.num=k
key.x=positionForKey[n].x;key.y=positionForKey[n].y
key.image=objectToCollect[k]
camera:add(key, 2,false)
physics.addBody(key,"static")
key.isSensor=true
key.id="key"
  
end


   local positionOfObjects=map:listTypes("object")


if(#positionOfObjects>0)then
for i=1,#positionOfObjects do
positionOfObjects[i].isVisible=false
local n=math.random(#objectData)
  objectCounter=objectCounter+1
   object[objectCounter]=display.newImageRect(objectData[n].image,objectData[n].width,objectData[n].height)
object[objectCounter].x=positionOfObjects[i].x
object[objectCounter].y=positionOfObjects[i].y-positionOfObjects[i].height/2
physics.addBody(object[objectCounter],"static")
object[objectCounter].id="object"
object[objectCounter].image=objectData[n].image
object[objectCounter].yOffset=objectData[n].yOffset
object[objectCounter].color=objectData[n].color
object[objectCounter].type=objectData[n].type
object[objectCounter].rotation=objectData[n].rotation
object[objectCounter].money=objectData[n].money
object[objectCounter].isSensor=true
camera:add(object[objectCounter], 2,false)

end
end


--print(myData.settings.levels[numLiv].specialObjects[1].image)
specialObject=myData.settings.levels[numLiv].specialObjects

 local specialPositions=map:listTypes("special")


if(#specialPositions>0)then
for i=1,#specialPositions do

local n=math.random(#specialObject)
specialPositions[i].isVisible=false
 objectCounter=objectCounter+1
   object[objectCounter]=display.newImageRect(specialObject[n].image,specialObject[n].width,specialObject[n].height)
object[objectCounter].x=specialPositions[i].x
object[objectCounter].y=specialPositions[i].y-specialPositions[i].height/2

physics.addBody(object[objectCounter],"static")
object[objectCounter].id="object"
object[objectCounter].image=specialObject[n].image
object[objectCounter].yOffset=specialObject[n].yOffset
object[objectCounter].color=specialObject[n].color
object[objectCounter].type=specialObject[n].type
object[objectCounter].rotation=specialObject[n].rotation
object[objectCounter].money=specialObject[n].money
object[objectCounter].isSensor=true
camera:add(object[objectCounter], 2,false)

end
end



math.randomseed(os.time())
local diamondPossiblePosition=map:listTypes("diamond")
if(#diamondPossiblePosition>0)then
  local n=math.random(#diamondPossiblePosition)
  diamondPossiblePosition[n].isVisible=false
diamond=display.newImage(sceneGroup,"assets/images/game/object/diamante.png",
  diamondPossiblePosition[n].x,  diamondPossiblePosition[n].y-diamondPossiblePosition[n].width/2)
physics.addBody(diamond,"static")
diamond.id="object"
diamond.type="diamond"
diamond.money=1000
diamond.isSensor=true
camera:add(diamond, 2,false)


end


camera:setBounds(_CW*0.6,map.width-_CW*0.8,_CH*0.5,map.height-220)

camera:track()


scoreText=display.newText(playerEarnMoney.." $",_CW*0.1,_CH*0.1,_FONT,30)
scoreText:setFillColor(1)


scoreTextStroke=display.newText(playerEarnMoney.." $",_CW*0.106,_CH*0.105,_FONT,30)
scoreTextStroke:setFillColor(0)

btn_pause=display.newImageRect(sceneGroup,"assets/images/game/pause_button.png",57,50)
btn_pause.x=_CW*0.9
btn_pause.id="pause"
btn_pause.y=_T + (btn_pause.height/2)
btn_pause:addEventListener("touch",onPauseTouch)





sceneGroup:insert(camera)

sceneGroup:insert(scoreTextStroke)
sceneGroup:insert(scoreText)
sceneGroup:insert(btn_pause)



bombPositions=map:listTypes("bomb")


if(#bombPositions>0)then
  for i=1,#bombPositions do
    bombPositions[i].isVisible=false
 bombCounter=bombCounter+1
 --local n=math.random(#bombPositions)
bomb[bombCounter]=display.newImageRect(sceneGroup,"assets/images/game/bomb.png",38,38)
bomb[bombCounter].x=bombPositions[i].x
bomb[bombCounter].y=bombPositions[i].y-bombPositions[i].height*0.1

physics.addBody(bomb[bombCounter],"static")
bomb[bombCounter].id="bomb"
camera:add(bomb[bombCounter], 2,false)


end
end


enemyPositions=map:listTypes("enemy")

math.randomseed(os.time())
if(#enemyPositions>0)then
for i=1,#enemyPositions do
enemyPositions[i].isVisible=false
  enemyCounter=enemyCounter+1
  if(#thisEnemies>0)then
 local n=math.random(#thisEnemies)
  enemy[enemyCounter]=display.newImageRect(sceneGroup,thisEnemies[n],50,50)
  enemy[enemyCounter].anchorY=0
 else
enemy[enemyCounter]=display.newImageRect(sceneGroup,"assets/images/game/enemy.png",38,38)
end


enemy[enemyCounter].x=enemyPositions[i].x
enemy[enemyCounter].y=enemyPositions[i].y-enemyPositions[i].height*0.1
enemy[enemyCounter].range=enemyPositions[i].width



physics.addBody(enemy[enemyCounter])
enemy[enemyCounter].gravityScale=enemyPositions[i].gravityScale
if(enemyPositions[i].id=="flying")then
enemy[enemyCounter].angle=0
enemy[enemyCounter].enterFrame=flying
enemy[enemyCounter].initY=enemy[enemyCounter].y
Runtime:addEventListener("enterFrame",enemy[enemyCounter])
  end

enemy[enemyCounter].id="enemy"
enemy[enemyCounter].isFixedRotation=true
enemyMove(enemy[enemyCounter])
camera:add(enemy[enemyCounter], 2,false)

end
end






comandi=newControls()
front=false
back=false

sceneGroup:insert(comandi)

math.randomseed(os.time())

  obstacles=map:listTypes("obstacle")
  if(#obstacles>0)then
for i=1,#obstacles do
local direction

if(obstacles[i].direction)then
direction=obstacles[i].direction
else
  local n=math.random(0,1)   if(n==0)then  direction="horizontal" else  direction="vertical"  end
end

timer.performWithDelay(math.random(1000),function() 
  obstacleMove(obstacles[i],direction)
   end)
end
  end

local menuPurchase=loadsave.loadTable("shop.json")

if(menuPurchase[1].bought)then livesMax=livesMax+1 actualLives=livesMax end
for i=1,livesMax do
  lives[i]=display.newImageRect("assets/images/game/heart.png",36,36)
  lives[i].y=_CH*0.1
lives[i].x=_CW*0.4+40*(i-1)
sceneGroup:insert(lives[i])
end


 bagpack=display.newImageRect(level.bagpack,64.7,64.3)
bagpack.x=0; bagpack.y=_CH*0.4
bagpack:addEventListener("touch",onPauseTouch)
bagpack.id="bag"
bagpack.objects={}

--physics.setDrawMode( "hybrid" )

sceneGroup:insert(bagpack)

--[[
local function onSystemEvent2( event )
        if event.type == "applicationSuspend" then

      for i=1,comandi.numChildren do
comandi[i].alpha=0

if(timerFinished)then
  timer.pause(timerFinished)end


if(timerTransformation)then
timer.pause(timerTransformation)
end

    audio.pause()
    transition.pause()
     physics.pause()

      for i=1,enemyCounter do
  Runtime:removeEventListener("enterFrame",enemy[i])
end

Runtime:removeEventListener("enterFrame",player[playerCount])

if(btn_fire~=nil)then
btn_fire:removeEventListener("tap",playerShoot)end
pauseGame=true


pauseBackground=display.newRect(sceneGroup,0,0,_CW*2,_CH*1.25)
pauseBackground.x=_CX; pauseBackground.y=_CY
pauseBackground:setFillColor(0)
pauseBackground.alpha=0.6
pauseText=display.newText(sceneGroup,"Game Pause",_CX,_CY*0.6,_FONT,75)


btn_pause:toFront()
bagpack:removeEventListener("touch",onPauseTouch)

  -- Create a home button for return to the menu scene.
 homeButton=widget.newButton{x=_CW*0.7,y=_CH*0.7,
width=85,
height=87,
id="home",
defaultFile="assets/images/menu/home.png",
overFile="assets/images/menu/home - over.png",
onRelease=returnToMenu
}

btn_replay=widget.newButton{
  width=85,
  height=87,
  defaultFile="assets/images/game/replay_btn.png",
    overFile="assets/images/game/over-replay_btn.png",

  x=_CW*0.3,
  y=homeButton.y,
  --defaultFile
    onEvent=restartLevel
}


    sceneGroup:insert( homeButton )
        sceneGroup:insert( btn_replay )

  --   elseif event.type == "applicationResume" then

end

      end
    end

    Runtime:addEventListener( "system", onSystemEvent2) ]]--

--[[
local ballonPos=map:findObject("ballon")
ballonPos.isVisible=false

local ballon=display.newImageRect(sceneGroup,"assets/images/game/object/ballon.png",72.4,160)
ballon.x=ballonPos.x; ballon.y=ballonPos.y
ballon.angle=0
ballon.enterFrame=move
ballon.initY=ballon.y
Runtime:addEventListener("enterFrame",ballon)
--ballon.x=ballon.x-100
timer.performWithDelay(5000,function()  display.remove(ballon)
Runtime:removeEventListener("enterFrame",ballon)

 end)

]]

--startGame()
--timer.performWithDelay(3000,function() onLevelCompleted() end)

--timer.performWithDelay(1000,function() changeColor("red") end)

end--end scene Method
 


 
 
-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
  if ( phase == "will" ) then
       -- Code here runs when the scene is still off screen (but is about to come on screen)





 elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
      composer.removeScene("scene.levelSelect",false)
if(MusicLevel~=nil)then
 
backgroundMusicChannel = audio.play( MusicLevel, { loops=-1 }  ) 

  
end

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