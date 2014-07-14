-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Mak Mark"
    result.name   = "X-Ray"
    return result
end

function init()
    local atlas = face:loadAtlas('all.atlas')
    face:add(atlas:createSprite('bottom_layer'))

    bigGear = atlas:createIndexedSprite('big_gear')
    bigGear:setPosition(115, 79)
    face:add(bigGear);

    middleGear = atlas:createIndexedSprite('middle_gear')
    middleGear:setPosition(47, 128)
    face:add(middleGear)

    littleGear = atlas:createIndexedSprite('little_gear')
    littleGear:setPosition(81, 35)
    face:add(littleGear)

    face:add(atlas:createSprite('top_layer'))

    hourHand = atlas:createSprite('hour_hand')
    hourHand:setPivot(11.4, 106)
    hourHand:setPosition(120, 120)
    face:add(hourHand)

    minuteHand = atlas:createSprite('minute_hand')
    minuteHand:setPivot(11.4, 106)
    minuteHand:setPosition(120, 120)
    face:add(minuteHand)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    bigGear   :setIndex(second % 3)
    middleGear:setIndex(second % 3)
    littleGear:setIndex((second / 2) % 3)

    hourHand  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHand:setRotation(360 / 60 * (minute + second / 60))
end