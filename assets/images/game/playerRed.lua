--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c55ba3f981eaf213e20696976a762e2b:6abe5c75f382d3f431a8c0a55ac7570b:16617a71d9b544c82d191867f38675f4$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- playerRed
            x=1,
            y=1,
            width=58,
            height=58,

        },
        {
            -- redShooting
            x=61,
            y=1,
            width=58,
            height=58,

        },
    },
    
    sheetContentWidth = 120,
    sheetContentHeight = 60
}

SheetInfo.frameIndex =
{

    ["playerRed"] = 1,
    ["redShooting"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
