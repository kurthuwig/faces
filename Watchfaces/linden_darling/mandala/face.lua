-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Linden Darling (www.coreform.com.au)"
    result.name   = "Mandala"
    return result
end

function textLayer(canvas)
    robotoBold12:setColor(0xffffffff)
    robotoBold12:drawCentered(canvas,
                              deviceStatus:getUnreadSMS() .. "",
                              9, 44)
    robotoBold12:drawCentered(canvas,
                              deviceStatus:getMissedCalls() .. "",
                              39, 234)
    robotoBold12:drawCentered(canvas,
                              deviceStatus:getUnreadGMail() .. "",
                              200, 234)
    robotoBold12:setColor(0xff939393)

    local day = time:get(Calendar.DAY_OF_MONTH)
    local suffix
    if 1 == day / 10 then
        suffix = "th"
    else
        local one = day % 10
        if 1 == one then
            suffix = "st"
        elseif 2 == one then
            suffix = "nd"
        elseif 3 == one then
            suffix = "rd"
        else
            suffix = "th"
        end
    end

    robotoBoldItalic18:drawCentered(canvas, day .. suffix, 119, 121)
    robotoBold12:drawCentered(canvas,
        DateFormat:format("MMM", time),
        124, 132)
end

function init()
    local atlas = face:loadAtlas('all.atlas')
    face:add(atlas:createSprite("face"))

    bigHandShadow = atlas:createSprite("big_hand_shadow")
    bigHandShadow:setPivot(101, 119)
    bigHandShadow:setPosition(120, 120)
    face:add(bigHandShadow)

    bigHand = atlas:createSprite("big_hand")
    bigHand:setPivot(68, 120)
    bigHand:setPosition(120, 120)
    face:add(bigHand)

    smallHandShadow = atlas:createSprite("small_hand_shadow")
    smallHandShadow:setPivot(52, 102)
    smallHandShadow:setPosition(120, 120)
    face:add(smallHandShadow)

    smallHand = atlas:createSprite("small_hand")
    smallHand:setPivot(33, 105)
    smallHand:setPosition(120, 120)
    face:add(smallHand)

    robotoBold12 =
        face:loadFont("Roboto-Bold-12.fnt",
                      atlas:createSprite("roboto-12-text-digits"))
    robotoBoldItalic18 =
        face:loadFont("Roboto-BoldItalic-18.fnt",
                      atlas:createSprite("roboto-italic-18-digits"))
    robotoBoldItalic18:setColor(0xff4b4b4b)

    local countCircle
    countCircle = atlas:createSprite("count_circle")
    countCircle:setPosition(0, 30)
    face:add(countCircle)

    countCircle = atlas:createSprite("count_circle")
    countCircle:setPosition(30, 220)
    face:add(countCircle)

    countCircle = atlas:createSprite("count_circle")
    countCircle:setPosition(191, 220)
    face:add(countCircle)

    face:add(textLayer)

    face:addRectangleHotzone(0, 0, 60, 60,
                             function () OS:startSMSApp() end)
    face:addRectangleHotzone(0, 180, 60, 60,
                             function () OS:startCallLogApp() end)
    face:addRectangleHotzone(180, 180, 60, 60,
                             function () OS:startSendMessageApp() end)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    local bigRotation = ((hour * 60 + minute) / 30) * 15
    bigHandShadow:setRotation(bigRotation)
    bigHand:setRotation(bigRotation)

    local smallRotation = ((minute * 60 + second) / 150) * 15
    smallHandShadow:setRotation(smallRotation)
    smallHand:setRotation(smallRotation)
end