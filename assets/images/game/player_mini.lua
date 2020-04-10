--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:ed553233b87dc3f2978b4533cc918307:c7fafa18a60e6eb7e4a95342225f4bc1:83c97f1efacbdcb106a71ecf5d84cb55$
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
            -- happy
            x=1,
            y=1,
            width=38,
            height=38,

        },
        {
            -- jump
            x=41,
            y=1,
            width=38,
            height=38,

        },
        {
            -- player0
            x=81,
            y=1,
            width=38,
            height=38,

        },
        {
            -- sad
            x=121,
            y=1,
            width=38,
            height=38,

        },
        {
            -- satisfied
            x=161,
            y=1,
            width=38,
            height=38,

        },
    },
    
    sheetContentWidth = 200,
    sheetContentHeight = 40
}

SheetInfo.frameIndex =
{

    ["happy"] = 1,
    ["jump"] = 2,
    ["player0"] = 3,
    ["sad"] = 4,
    ["satisfied"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
