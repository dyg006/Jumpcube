
local M = {}
M.settings = {}
--M.settings.currentLevel = 1

M.settings.soundOn = true
M.settings.musicOn = true
M.settings.levels = {} 
 
-- These lines are just here to pre-populate the table.
-- In reality, your app would likely create a level entry when each level is unlocked and the score/stars are saved.
-- Perhaps this happens at the end of your game level, or in a scene between game levels.

M.settings.levels[1] = {}
M.settings.levels[1].map="JungleMap"
M.settings.levels[1].music="assets/music/jungle_music.mp3"
M.settings.levels[1].specialObjects={
	{image="assets/images/game/object/banana.png",width=45,height=45,money=25},
{image="assets/images/game/object/coconut.png",width=64,height=40,money=35},
{image="assets/images/game/object/paint_can_red.png",color="red",width=45,height=45}
}
M.settings.levels[1].enemies={"assets/images/game/enemies/monkey.png"}





M.settings.levels[2] = {}
M.settings.levels[2].map="CastleMap"
M.settings.levels[2].music="assets/music/enigmatic.mp3"
M.settings.levels[2].specialObjects={
	{image="assets/images/game/object/flash.png",type="flash",width=45,height=45},

	--{image="assets/images/game/object/paint_can_red.png",color="red",width=45,height=45},
--	{image="assets/images/game/accessories/black_hat.png",type="accessory",yOffset=-23,width=35.5,height=30,rotation=-45},

}
M.settings.levels[2].enemies={"assets/images/game/enemies/ghost.png"}



M.settings.levels[3] = {}
M.settings.levels[3].map="KenneyMap"
M.settings.levels[3].music="assets/music/bensound-buddy.mp3"
M.settings.levels[3].specialObjects={
{image="assets/images/game/object/paint_can_blue.png",color="blue",width=45,height=45,numMax=3},
--{image="assets/images/game/accessories/sunglasses.png",type="accessory",yOffset=-3,width=30,height=30,numMax=2}, 
{image="assets/images/game/object/paint_can_red.png",color="red",width=45,height=45},
{image="assets/images/game/object/flash.png",type="flash",width=45,height=45},
}
M.settings.levels[3].enemies={}



M.settings.levels[4] = {}
M.settings.levels[4].map = "TestMap"
M.settings.levels[4].music="assets/music/tribal.mp3"
M.settings.levels[4].specialObjects={{image="assets/images/game/object/paint_can_blue.png",color="blue",width=45,height=45,numMax=3}}
M.settings.levels[4].enemies={"assets/images/game/enemies/mummy.png"}


M.settings.levels[5] = {}
M.settings.levels[5].map = "LaboratoryMap"
M.settings.levels[5].music="assets/music/bensound-funkyelement.mp3"
M.settings.levels[5].specialObjects={}
M.settings.levels[5].enemies={"assets/images/game/enemies/virus.png",
"assets/images/game/enemies/virus2.png"}


M.settings.levels[6] = {}
M.settings.levels[6].map = "MysteryMap"
M.settings.levels[6].music="assets/music/LaDaDaGuitar.mp3"
M.settings.levels[6].specialObjects={{image="assets/images/game/object/paint_can_blue.png",color="blue",width=45,height=45,numMax=2},
{image="assets/images/game/object/paint_can_red.png",color="red",width=45,height=45}
}
M.settings.levels[6].enemies={"assets/images/game/enemies/evil.png","assets/images/game/enemies/evil_1.png"}


M.settings.levels[7] = {}
M.settings.levels[7].map = "SnowMap"
M.settings.levels[7].music="assets/music/christmas_music.mp3"
M.settings.levels[7].specialObjects={
--{image="assets/images/game/accessories/snow_hat.png",type="accessory",yOffset=-26,width=40,height=30,rotation=-45},
{image="assets/images/game/object/paint_can_red.png",color="red",width=45,height=45},
{image="assets/images/game/object/flash.png",type="flash",width=45,height=45},
}
M.settings.levels[7].enemies={"assets/images/game/enemies/evil penguin 2.png",
"assets/images/game/enemies/evil snowman.png"}



M.settings.levels[8] = {}
M.settings.levels[8].map = "MoonMap"
M.settings.levels[8].music="assets/music/virtual_guitar.mp3"
M.settings.levels[8].specialObjects={}
M.settings.levels[8].enemies={}


M.settings.levels[9] = {}
M.settings.levels[9].map = "CastleRoom"
M.settings.levels[9].music="assets/music/rpg.mp3"
M.settings.levels[9].specialObjects={}
M.settings.levels[9].enemies={"assets/images/game/enemies/bat.png"}

M.settings.levels[10] = {}
M.settings.levels[10].map = "GrassMap"
M.settings.levels[10].music="assets/music/bensound-tenderness.mp3"
M.settings.levels[10].specialObjects={}
M.settings.levels[10].enemies={}

M.settings.levels[11] = {}
M.settings.levels[11].map = "CandyMap"
M.settings.levels[11].music="assets/music/bensound-funnysong.mp3"
M.settings.levels[11].specialObjects={}
M.settings.levels[11].enemies={}

M.settings.levels[12] = {}
M.settings.levels[12].map = "NightMap"
M.settings.levels[12].music="assets/music/bensound-instinct.mp3"
M.settings.levels[12].specialObjects={}
M.settings.levels[12].enemies={}



-- levels data members:
--      .stars -- Stars earned per level
--      .score -- Score for the level
return M

--[[
{image="assets/images/game/object/paint_can_red.png",color="red",width=45,height=45},
{image="assets/images/game/object/paint_can_blue.png",color="blue",width=45,height=45},
{image="assets/images/game/object/heart.png",width=40,height=40},
{image="assets/images/game/accessories/black_hat.png",type="accessory",yOffset=-23,width=35.5,height=30,rotation=-45},
{image="assets/images/game/accessories/sunglasses.png",type="accessory",yOffset=-3,width=30,height=30} ]]