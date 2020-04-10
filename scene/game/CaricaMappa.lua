




local json = require( "json" )

local tiled = require "com.ponywolf.ponytiled"


function loadMap(nomelivello)
local mapData = json.decodeFile(system.pathForFile("assets/maps/"..nomelivello..".json", system.ResourceDirectory))  
--Indica la directory in cui si trova la mappa
map = tiled.new(mapData,"assets/maps") 


return map
end