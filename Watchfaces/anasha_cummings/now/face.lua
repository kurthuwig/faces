-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Anasha Cummings"
    result.name   = "Now"
    return result
end

HOUR_COLORS = {
    0xffbc1700,
    0xffbb258e,
    0xffa52dc3,
    0xff5e1b9d,
    0xff003d9b,
    0xff01aeec,
    0xff06b1ac,
    0xff2c8500,
    0xff9fd642,
    0xffeeed00,
    0xffdba13e,
    0xffb95f0e
}

function init()
    local atlas = face:loadAtlas("all.atlas")
    border = atlas:createSprite("border")
    face:add(border)
    minuteHand = atlas:createSprite("minute_hand")
    minuteHand:setPivot(8, 170)
    minuteHand:setPosition(120, 120)
    face:add(minuteHand)

    local now = atlas:createSprite("now")
    now:setPosition(8, 90)
    face:add(now)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    minuteHand:setRotation(360 / 60 * (minute + second / 60))
    border:setColor(HOUR_COLORS[(hour  % 12) + 1]);
end