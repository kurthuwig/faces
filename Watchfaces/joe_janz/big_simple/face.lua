-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Joe Janz"
    result.name   = "Big Simple"
    return result
end

COLORS = {
    0xffff004d,
    0xff01ff0d,
}

function textLayer(canvas)
    minuteFont:drawLeftAligned(canvas, ":", 9, 223)
    hourFont:drawLeftAligned(canvas, DateFormat:format("kk", time), 4, 148)
    minuteFont:drawLeftAligned(canvas, DateFormat:format("mm", time), 50, 223)
end

function init()
    local atlas = face:loadAtlas('all.atlas')
    hourFont = face:loadFont("FranklinGothicHeavy-194.fnt",
        atlas:createSprite("hour"))
    minuteFont = face:loadFont("FranklinGothicHeavy-151.fnt",
        atlas:createSprite("minute"))

    face:add(textLayer)
    face:setThemeCount(2)
end

function update()
    local themeIndex = face:getCurrentThemeIndex()
    hourFont:setColor(0 == themeIndex and COLORS[1] or COLORS[2])
    minuteFont:setColor(0 == themeIndex and COLORS[2] or COLORS[1])
end