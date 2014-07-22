-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Roland J. Veen"
    result.name   = "Future Retro"
    return result
end

SHADOW_COLOR = 0x80000000

function init()
    local atlas = face:loadAtlas('all.atlas')
    face:add(atlas:createSprite("face"))

    dateTens = atlas:createSubdividedSprite("date_digits", 10)
    dateTens:setPosition(168, 115)
    face:add(dateTens)

    dateOnes = atlas:createSubdividedSprite("date_digits", 10)
    dateOnes:setPosition(177, 115)
    face:add(dateOnes)

    batteryStatus = atlas:createSubdividedSprite("battery_status", 2)
    batteryStatus:setPosition(170, 112)
    face:add(batteryStatus)

    secondHandShadow = atlas:createSprite('second_hand')
    secondHandShadow:setPivot(11.5, 113.5)
    secondHandShadow:setPosition(122.5, 122.5)
    secondHandShadow:setColor(SHADOW_COLOR)
    face:add(secondHandShadow)

    secondHand = atlas:createSprite('second_hand')
    secondHand:setPivot(11.5, 113.5)
    secondHand:setPosition(119.5, 119.5)
    secondHand:setColor(0xffc2c2c2)
    face:add(secondHand)

    minuteHandShadow = atlas:createSprite("minute_hand")
    minuteHandShadow:setPivot(15.5, 93.5)
    minuteHandShadow:setPosition(124.5, 124.5)
    minuteHandShadow:setColor(SHADOW_COLOR)
    face:add(minuteHandShadow)

    minuteHand = atlas:createSprite('minute_hand')
    minuteHand:setPivot(15.5, 93.5)
    minuteHand:setPosition(119.5, 119.5)
    minuteHand:setColor(0xff31b4af)
    face:add(minuteHand)

    hourHandShadow = atlas:createSprite("hour_hand")
    hourHandShadow:setPivot(19.5, 81.5)
    hourHandShadow:setPosition(126.5, 126.5)
    hourHandShadow:setColor(SHADOW_COLOR)
    face:add(hourHandShadow)

    hourHand = atlas:createSprite('hour_hand')
    hourHand:setPivot(19.5, 81.5)
    hourHand:setPosition(119.5, 119.5)
    hourHand:setColor(0xffff6a07)
    face:add(hourHand)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    hourHand  :setRotation(360 / 12
                           * (hour + math.floor(minute / 12) * 12 / 60))
    minuteHand:setRotation(360 / 60 * minute)
    secondHand:setRotation(360 / 60 * second)
    hourHandShadow  :setRotation(360 / 12
                                 * (hour + math.floor(minute / 12) * 12 / 60))
    minuteHandShadow:setRotation(360 / 60 * minute)
    secondHandShadow:setRotation(360 / 60 * second)

    local day = time:get(Calendar.DAY_OF_MONTH)
    dateTens:setIndex(math.floor(day / 10))
    dateOnes:setIndex(day % 10)
    dateTens:setVisible(10 <= day)

    local batteryPercent = deviceStatus:getBatteryPercent()
    if 30 < batteryPercent then
        batteryStatus:setVisible(false)
        dateTens:setVisible(true)
        dateOnes:setVisible(true)
    else
        batteryStatus:setVisible(true)
        dateTens:setVisible(false)
        dateOnes:setVisible(false)
    end

    secondHand      :setVisible(deviceStatus:isShowSeconds())
    secondHandShadow:setVisible(deviceStatus:isShowSeconds())
end