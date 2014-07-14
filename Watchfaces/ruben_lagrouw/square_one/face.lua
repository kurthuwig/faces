-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Ruben Lagrouw"
    result.name   = "Square One"
    return result
end

COLORS = {
    0xffffff,
    0x000000,
}

BACKGROUND_COLORS = {
    0xff000000,
    0xffffffff,
}

function textLayer(canvas)
    chargeBattery:setVisible(deviceStatus:getBatteryPercent() < 20)
    dataFont:drawRightAligned(
        canvas,
        string.upper(DateFormat:format("EEE MMM dd", time)),
        237, 84)
    timeFont:drawCentered(
        canvas,
        DateFormat:format("kk:mm", time),
        122, 147)
end

function init()
    local atlas = face:loadAtlas('all.atlas')
    timeFont = face:loadFont("blocked-70.fnt",
                             atlas:createSprite("font-blocked"))
    dataFont = face:loadFont("imagine_font-24.fnt",
                             atlas:createSprite("font-imagine"))

    face:add(textLayer)

    chargeBattery = atlas:createSprite("charge_battery")
    chargeBattery:setPosition(87, 12)
    face:add(chargeBattery)

    weather = atlas:createSprite("10d")
    weather:setPosition(88, 162)
    face:add(weather)
    face:setThemeCount(#COLORS)
end

function update()
    local color = COLORS[face:getCurrentThemeIndex() + 1]
    timeFont:setColor(color)
    dataFont:setColor(color)
    chargeBattery:setColor(color)
    weather:setColor(color)
    face:setBackgroundColor(BACKGROUND_COLORS[face:getCurrentThemeIndex() + 1])
end