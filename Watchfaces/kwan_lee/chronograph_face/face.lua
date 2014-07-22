-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Kwan Lee"
    result.name   = "Chronograph Face"
    return result
end

COLOR_BATTERY_LOW  = 0xfff72124
COLOR_BATTERY_MED  = 0xffee7a24
COLOR_BATTERY_HIGH = 0xff69ba44
COLOR_NOTIFICATION = 0xff28bbeb

function init()
    local atlas = face:loadAtlas('all.atlas')
    backdrop = atlas:createSprite("backdrop")
    face:add(backdrop)
    face:add(atlas:createSprite("clockface"))

    stopwatchMinute = atlas:createSprite("small_hand")
    stopwatchMinute:setPivot(5, 24)
    stopwatchMinute:setPosition(164, 89)
    face:add(stopwatchMinute)

    stopwatchSecond = atlas:createSprite("small_hand")
    stopwatchSecond:setPivot(5, 24)
    stopwatchSecond:setPosition(76, 89)
    face:add(stopwatchSecond)

    hourHandBackdrop = atlas:createSprite("hour_hand_backdrop")
    hourHandBackdrop:setPivot(8, 73)
    hourHandBackdrop:setPosition(120, 120)
    face:add(hourHandBackdrop)

    hourHand = atlas:createSprite("hour_hand")
    hourHand:setPivot(8, 73)
    hourHand:setPosition(120, 120)
    face:add(hourHand)

    minuteHandBackdrop = atlas:createSprite("minute_hand_backdrop")
    minuteHandBackdrop:setPivot(6, 103)
    minuteHandBackdrop:setPosition(120, 120)
    face:add(minuteHandBackdrop)

    minuteHand = atlas:createSprite("minute_hand")
    minuteHand:setPivot(6, 103)
    minuteHand:setPosition(120, 120)
    face:add(minuteHand)

    secondHand = atlas:createSprite("second_hand")
    secondHand:setPivot(5, 102)
    secondHand:setPosition(120, 120)
    face:add(secondHand)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    local batteryPercent = deviceStatus:getBatteryPercent()
    local color;
    if batteryPercent <= 20 then
        color = COLOR_BATTERY_LOW
    elseif batteryPercent < 80 then
        color = COLOR_BATTERY_MED
    else
        color = COLOR_BATTERY_HIGH
    end

    backdrop:setColor(color)
    hourHandBackdrop:setColor(color)
    minuteHandBackdrop:setColor(color)
    secondHand:setColor(color)
    stopwatchMinute:setColor(color)
    stopwatchSecond:setColor(color)

    hourHand  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHand:setRotation(360 / 60 * (minute + second / 60))
    secondHand:setRotation(360 / 60 * second)
    hourHandBackdrop  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHandBackdrop:setRotation(360 / 60 * (minute + second / 60))

    secondHand:setVisible(deviceStatus:isShowSeconds())
end