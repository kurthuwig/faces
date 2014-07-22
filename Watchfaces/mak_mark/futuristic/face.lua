-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Mak Mark"
    result.name   = "Futuristic"
    return result
end

COLOR = 0xff17eded

function customLayer(canvas)
    font:drawCentered(canvas, DateFormat:format("kk:mm", time), 120, 127)
    if deviceStatus:isShowSeconds() then
        font:drawCentered(canvas, DateFormat:format("ss", time), 120, 164)
    end
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    face:add(face:loadSprite('face.jpg'))

    font = face:loadFont('digital-7 (mono)-45.fnt', atlas:createSprite('font'))
    font:setColor(COLOR)
    face:add(customLayer)

    hourHand = atlas:createSprite('hour_hand')
    hourHand:setPivot(59.5, 72.5)
    hourHand:setPosition(119.5, 119.5)
    hourHand:setColor(COLOR)
    face:add(hourHand)

    minuteHand = atlas:createSprite('minute_hand')
    minuteHand:setPivot(59.5, 97.5)
    minuteHand:setPosition(119.5, 119.5)
    minuteHand:setColor(COLOR)
    face:add(minuteHand)

    secondHand = atlas:createSprite('second_hand')
    secondHand:setPivot(59.5, 119.5)
    secondHand:setPosition(119.5, 119.5)
    secondHand:setColor(COLOR)
    face:add(secondHand)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    hourHand  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHand:setRotation(360 / 60 * (minute + second / 60))
    secondHand:setRotation(360 / 60 * second)

    secondHand:setVisible(deviceStatus:isShowSeconds())
end