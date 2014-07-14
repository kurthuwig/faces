-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Mike Tolly"
    result.name   = "Binary"
    return result
end

COLORS = {
    0x05fe05,
    0x0505fe,
    0xcc0505,
    0xf2760f,
}

function drawBinary(canvas, value, numDigits, x)
    for i = 1, numDigits do
        local bit = bit32.band(value, 0x01)
        value = bit32.rshift(value, 1)
        canvas:drawBitmap((0 == bit and zero or one):getBitmap(),
            x, 240 - i * 40,
            paint)
    end
end

function binaryLayer(canvas)
    local hour   = time:get(Calendar.HOUR_OF_DAY)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)
    drawBinary(canvas, hour   / 10, 2,   2)
    drawBinary(canvas, hour   % 10, 4,  42)
    drawBinary(canvas, minute / 10, 3,  82)
    drawBinary(canvas, minute % 10, 4, 122)
    drawBinary(canvas, second / 10, 3, 162)
    drawBinary(canvas, second % 10, 4, 202)
end

function init()
    local atlas = face:loadAtlas('all.atlas')
    zero = atlas:createSprite("zero")
    one = atlas:createSprite("one")
    face:add(binaryLayer)
    face:setThemeCount(#COLORS)
end

function update()
    local COLOR = COLORS[face:getCurrentThemeIndex() + 1]
    paint = face:createColoredPaint(COLOR)
end