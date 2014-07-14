-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Jasper Brosens"
    result.name   = "Xess"
    return result
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    face:add(atlas:createSprite('face'))

    wifi = {}
    for i = 1, 5 do
        wifi[i] = atlas:createSprite("xess_wifi", i)
        wifi[i]:setPosition(116 + i * 5, 145)
        face:add(wifi[i])
    end

    cell = {}
    for i = 1, 5 do
        cell[i] = atlas:createSprite("xess_2g3g", i)
        cell[i]:setPosition(118 - i * 5, 145)
        face:add(cell[i])
    end

    hourHandShadow = atlas:createSprite("hour_shadow")
    hourHandShadow:setPivot(3.5, 89.5)
    hourHandShadow:setPosition(121.5, 121.5)
    face:add(hourHandShadow)

    minuteHandShadow = atlas:createSprite("minute_shadow")
    minuteHandShadow:setPivot(3.5, 101.5)
    minuteHandShadow:setPosition(121.5, 121.5)
    face:add(minuteHandShadow)

    secondHandShadow = atlas:createSprite('second_shadow')
    secondHandShadow:setPivot(3.5, 117.5)
    secondHandShadow:setPosition(121.5, 121.5)
    face:add(secondHandShadow)

    hourHand = atlas:createSprite('hour_hand')
    hourHand:setPivot(3.5, 89.5)
    hourHand:setPosition(119.5, 119.5)
    face:add(hourHand)

    minuteHand = atlas:createSprite('minute_hand')
    minuteHand:setPivot(8.5, 101.5)
    minuteHand:setPosition(119.5, 119.5)
    face:add(minuteHand)

    secondHand = atlas:createSprite('second_hand')
    secondHand:setPivot(3.5, 117.5)
    secondHand:setPosition(119.5, 119.5)
    face:add(secondHand)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    hourHand  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHand:setRotation(360 / 60 * (minute + second / 60))
    secondHand:setRotation(360 / 60 * second)
    hourHandShadow  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHandShadow:setRotation(360 / 60 * (minute + second / 60))
    secondHandShadow:setRotation(360 / 60 * second)

    local cellularLevel = deviceStatus:getCellularLevel()
    for i = 1, 5 do
        cell[i]:setVisible(i <= cellularLevel)
    end

    local wifiLevel = deviceStatus:getWifiPercent() / 20 + 1
    for i = 1, 5 do
        wifi[i]:setVisible(i <= wifiLevel)
    end
end