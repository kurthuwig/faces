-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Todd Hannemann"
    result.name   = "Minimal"
    return result
end

function textLayer(canvas)
    local format24 = deviceStatus:is24HourFormat()
    local formatString = format24 and "kk:mm" or "hh:mm"
    local timeString =
    DateFormat:format(formatString, time)


    if (not format24) and 11 < time:get(Calendar.HOUR_OF_DAY) then
        timeString = timeString .. "pm"
    end
    font:drawCentered(canvas, timeString, 120, 188)
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    local badge = atlas:createSprite("digital_badge")
    badge:setPosition(53, 165)
    face:add(badge)

    font = face:loadFont("Courier_New_Bold-24.fnt",
        atlas:createSprite("digits-apm"))
    font:setColor(0xff000000)

    face:add(textLayer)

    hourHand = atlas:createSprite("hour_hand")
    hourHand:setPivot(5, 75)
    hourHand:setPosition(120, 120)
    face:add(hourHand)

    minuteHand = atlas:createSprite("minute_hand")
    minuteHand:setPivot(5, 101)
    minuteHand:setPosition(120, 120)
    face:add(minuteHand)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)
    hourHand  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHand:setRotation(360 / 60 * (minute + second / 60))
end