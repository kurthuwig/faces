-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Orkun Talas"
    result.name   = "Text"
    return result
end


NUMBERS = {
    "ZERO",
    "ONE",
    "TWO",
    "THREE",
    "FOUR",
    "FIVE",
    "SIX",
    "SEVEN",
    "EIGHT",
    "NINE",
    "TEN",
    "ELEVEN",
    "TWELVE",
    "THIR-",
    "FOUR-",
    "FIF-",
    "SIX-",
    "SEVEN-",
    "EIGH-",
    "NINE-"
}

TENS = {
    "ZERO",
    "",
    "TWENTY",
    "THIRTY",
    "FORTY",
    "FIFTY"
}

COLORS = {
    0xffffff,
    0x000000,
}

BACKGROUND_COLORS = {
    0xff000000,
    0xffffffff,
}

function textLayer(canvas)
    local firstLine, secondLine, thirdLine;
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)

    firstLine = NUMBERS[(0 == hour and 12 or hour) + 1];

    if 0 == minute then
        secondLine = "O'"
        thirdLine = "CLOCK"
    elseif minute < 13 then
        secondLine = "-"
        thirdLine = NUMBERS[minute + 1]
    elseif minute < 20 then
        secondLine = NUMBERS[minute + 1]
        thirdLine = "TEEN"
    else
        secondLine = TENS[math.floor(minute / 10) + 1]
        local minuteOne = minute % 10
        thirdLine = 0 == minuteOne and "-" or NUMBERS[minuteOne + 1]
    end

    font:drawCentered(canvas, firstLine,  120, 90)
    font:drawCentered(canvas, secondLine, 120, 140)
    font:drawCentered(canvas, thirdLine,  120, 190)
end

function init()
    font = face:loadFont("Arial_Black-48.fnt",
        face:loadSprite("capitaldash.png"))
    face:add(textLayer)
    face:setThemeCount(#COLORS)
end

function update()
    font:setColor(COLORS[face:getCurrentThemeIndex() + 1])
    face:setBackgroundColor(BACKGROUND_COLORS[face:getCurrentThemeIndex() + 1])
end