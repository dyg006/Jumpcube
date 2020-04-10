--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:7cac939c0c91c83dd2d16fdd4cf68d27:f098f4c28fbb53b8ac55f9f916947100:8872498b8347f4c6c73a0632cd923869$
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
            -- desert_pack_03
            x=1,
            y=1,
            width=64,
            height=64,

        },
        {
            -- desert_pack_05
            x=67,
            y=1,
            width=64,
            height=64,

        },
        {
            -- desert_pack_07
            x=133,
            y=1,
            width=64,
            height=64,

        },
        {
            -- desert_pack_09
            x=1,
            y=67,
            width=64,
            height=64,

        },
        {
            -- desert_pack_11
            x=67,
            y=67,
            width=64,
            height=64,

        },
        {
            -- desert_pack_13
            x=1,
            y=393,
            width=64,
            height=34,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_15
            x=1,
            y=357,
            width=64,
            height=34,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_17
            x=133,
            y=313,
            width=64,
            height=38,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_19
            x=1,
            y=317,
            width=64,
            height=38,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_21
            x=133,
            y=393,
            width=64,
            height=30,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_33
            x=133,
            y=67,
            width=64,
            height=64,

        },
        {
            -- desert_pack_34
            x=1,
            y=133,
            width=64,
            height=64,

        },
        {
            -- desert_pack_35
            x=67,
            y=133,
            width=64,
            height=64,

        },
        {
            -- desert_pack_36
            x=133,
            y=133,
            width=64,
            height=64,

        },
        {
            -- desert_pack_37
            x=1,
            y=199,
            width=64,
            height=64,

        },
        {
            -- desert_pack_38
            x=67,
            y=357,
            width=64,
            height=34,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_39
            x=67,
            y=393,
            width=64,
            height=34,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_40
            x=67,
            y=317,
            width=64,
            height=38,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_41
            x=133,
            y=353,
            width=64,
            height=38,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_51
            x=1,
            y=265,
            width=64,
            height=50,

            sourceX = 0,
            sourceY = 14,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_52
            x=67,
            y=199,
            width=64,
            height=64,

        },
        {
            -- desert_pack_53
            x=67,
            y=265,
            width=64,
            height=50,

            sourceX = 0,
            sourceY = 14,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- desert_pack_54
            x=133,
            y=199,
            width=64,
            height=64,

        },
        {
            -- desert_pack_72
            x=133,
            y=265,
            width=64,
            height=46,

            sourceX = 0,
            sourceY = 18,
            sourceWidth = 64,
            sourceHeight = 64
        },
    },
    
    sheetContentWidth = 198,
    sheetContentHeight = 428
}

SheetInfo.frameIndex =
{

    ["desert_pack_03"] = 1,
    ["desert_pack_05"] = 2,
    ["desert_pack_07"] = 3,
    ["desert_pack_09"] = 4,
    ["desert_pack_11"] = 5,
    ["desert_pack_13"] = 6,
    ["desert_pack_15"] = 7,
    ["desert_pack_17"] = 8,
    ["desert_pack_19"] = 9,
    ["desert_pack_21"] = 10,
    ["desert_pack_33"] = 11,
    ["desert_pack_34"] = 12,
    ["desert_pack_35"] = 13,
    ["desert_pack_36"] = 14,
    ["desert_pack_37"] = 15,
    ["desert_pack_38"] = 16,
    ["desert_pack_39"] = 17,
    ["desert_pack_40"] = 18,
    ["desert_pack_41"] = 19,
    ["desert_pack_51"] = 20,
    ["desert_pack_52"] = 21,
    ["desert_pack_53"] = 22,
    ["desert_pack_54"] = 23,
    ["desert_pack_72"] = 24,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
