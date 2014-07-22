-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "DSH Electronics"
    result.name   = "LedClock"
    return result
end

function init()
    local atlas = face:loadAtlas('all.atlas')
    lowerRing = atlas:createSprite("halfring")
    lowerRing:setPivot(6, 120)
    lowerRing:setPosition(120, 120)
    face:add(lowerRing)

    halfDisk = atlas:createSprite("halfdisk")
    halfDisk:setPivot(6, 120)
    halfDisk:setPosition(120, 120)
    face:add(halfDisk)

    upperRing = atlas:createSprite("halfring")
    upperRing:setPivot(6, 120)
    upperRing:setPosition(120, 120)
    face:add(upperRing)

    hourTens = atlas:createSubdividedSprite("digits_hour_minute", 10)
    hourTens:setPosition(21, 90)
    face:add(hourTens)

    hourOnes = atlas:createSubdividedSprite("digits_hour_minute", 10)
    hourOnes:setPosition(66, 90)
    face:add(hourOnes)

    colon = atlas:createSprite("colon")
    colon:setPosition(111, 89)
    face:add(colon)

    minuteTens = atlas:createSubdividedSprite("digits_hour_minute", 10)
    minuteTens:setPosition(128, 90)
    face:add(minuteTens)

    minuteOnes = atlas:createSubdividedSprite("digits_hour_minute", 10)
    minuteOnes:setPosition(173, 90)
    face:add(minuteOnes)

    secondTens = atlas:createSubdividedSprite("digits_second", 10)
    secondTens:setPosition(83, 158)
    face:add(secondTens)

    secondOnes = atlas:createSubdividedSprite("digits_second", 10)
    secondOnes:setPosition(120, 158)
    face:add(secondOnes)

    date = {}
    for i = 0, 5 do
        date[i + 1] = atlas:createSubdividedSprite("digits_date", 10)
        date[i + 1]:setPosition(34 + 23 * i
                + (3 < i and 13 * 2 or (1 < i and 13 or 0)),
            56)
        face:add(date[i + 1])
    end

    local dash = atlas:createSprite("dash")
    dash:setPosition(80, 68)
    face:add(dash)

    local dash = atlas:createSprite("dash")
    dash:setPosition(139, 68)
    face:add(dash)
end

function update()
    local hour   = time:get(Calendar.HOUR_OF_DAY)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    hourTens:setIndex(hour / 10)
    hourOnes:setIndex(hour % 10)
    colon:setVisible(0 == second % 2)
    minuteTens:setIndex(minute / 10)
    minuteOnes:setIndex(minute % 10)
    secondTens:setIndex(second / 10)
    secondOnes:setIndex(second % 10)

    local year  = time:get(Calendar.YEAR) % 100
    local month = time:get(Calendar.MONTH) + 1
    local day   = time:get(Calendar.DAY_OF_MONTH)
    date[1]:setIndex(day / 10)
    date[2]:setIndex(day % 10)
    date[3]:setIndex(month / 10)
    date[4]:setIndex(month % 10)
    date[5]:setIndex(year / 10)
    date[6]:setIndex(year % 10)

    local isShowSeconds = deviceStatus:isShowSeconds()
    lowerRing:setRotation(second < 30 and 0 or 180)
    halfDisk:setRotation(360 / 60 * (second + 1))
    upperRing:setVisible(isShowSeconds and 30 <= second)

    secondTens:setVisible(isShowSeconds)
    secondOnes:setVisible(isShowSeconds)
    lowerRing:setVisible(isShowSeconds)
end