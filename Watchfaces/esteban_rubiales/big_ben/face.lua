-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Esteban Rubiales"
    result.name   = "Big Ben"
    return result
end

COLORS = {
    0x66cc33,
    0xff0000,
    0x4080ff,
    0xffff00,
}

function textLayer(canvas)
    font:drawCentered(canvas, time:get(Calendar.DAY_OF_MONTH) .. "", 21, 27)
    font:drawCentered(canvas, (time:get(Calendar.MONTH) + 1) .. "", 218, 27)
    local weather = deviceStatus:getWeather()
    if weather ~= nil then
        font:drawCentered(
            canvas,
            math.floor(weather.temperature.current + 0.5) .. "°",
            220, 224)
    end
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    background = atlas:createSprite("face")
    face:add(background)

    face:add(textLayer)

    minuteHand = atlas:createSprite("minute_hand")
    minuteHand:setPivot(5.5, 85.5)
    minuteHand:setPosition(119.5, 119.5)
    face:add(minuteHand)

    hourHand = atlas:createSprite("hour_hand")
    hourHand:setPivot(4.5, 62.5)
    hourHand:setPosition(119.5, 119.5)
    face:add(hourHand)

    font = face:loadFont("DejaVuSans-14.fnt",
        atlas:createSprite("dejavu-sans-14-digits"))

    face:setThemeCount(#COLORS)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    hourHand  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHand:setRotation(360 / 60 * (minute + second / 60))

    local COLOR = COLORS[face:getCurrentThemeIndex() + 1]
    background:setColor(COLOR)
    minuteHand:setColor(COLOR)
    hourHand:setColor(COLOR)
    font:setColor(COLOR)
end