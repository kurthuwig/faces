-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Martin Holm Nielsen"
    result.name   = "Grandmaster"
    return result
end

function textLayer(canvas)
    font:setColor(0xffdddddd)
    font:drawCentered(canvas,
        string.upper(DateFormat:format("EEE dd", time)),
        119, 179)
    font:drawCentered(canvas,
        DateFormat:format("kk:mm:ss", time),
        119, 197)
    local missedCalls = deviceStatus:getMissedCalls()
    if 0 < missedCalls then
        font:drawLeftAligned(canvas,
            missedCalls .. "",
            32, 229)
    end

    local unreadSMS = deviceStatus:getUnreadSMS()
    if 0 < unreadSMS then
        font:drawCentered(canvas,
            unreadSMS .. "",
            103, 231)
    end

    local unreadGMail = deviceStatus:getUnreadGMail()
    if 0 < unreadGMail then
        font:drawCentered(canvas,
            unreadGMail .. "",
            171, 231)
    end

    if deviceStatus:getBatteryPercent() < 16 then
        font:setColor(0xffff3939)
    end

    font:drawCentered(canvas,
        deviceStatus:getBatteryPercent() .. "",
        119, 127)
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    switcher = face:createLayerCollection()
    for i = 0, 3 do
        switcher:add(i, atlas:createSprite("wallpaper", i))
    end
    face:add(switcher)
    face:setThemeCount(switcher:getCollectionCount())

    face:add(atlas:createSprite("markers"))

    notificationCall = atlas:createIndexedSprite("notification_call")
    notificationCall:setPosition(15, 209)
    face:add(notificationCall)

    notificationSMS = atlas:createIndexedSprite("notification_sms")
    notificationSMS:setPosition(73, 216)
    face:add(notificationSMS)

    notificationEmail = atlas:createIndexedSprite("notification_email")
    notificationEmail:setPosition(141, 218)
    face:add(notificationEmail)

    notificationAlarm = atlas:createIndexedSprite("notification_alarm")
    notificationAlarm:setPosition(201, 210)
    face:add(notificationAlarm)

    hourHandShadow = atlas:createSprite("hand_hour_shadow")
    hourHandShadow:setPivot(11, 76)
    hourHandShadow:setPosition(124, 125)
    face:add(hourHandShadow)

    minuteHandShadow = atlas:createSprite("hand_minute_shadow")
    minuteHandShadow:setPivot(11, 99)
    minuteHandShadow:setPosition(124, 125)
    face:add(minuteHandShadow)

    secondHandShadow = atlas:createSprite('hand_second_shadow')
    secondHandShadow:setPivot(5, 99)
    secondHandShadow:setPosition(124, 125)
    face:add(secondHandShadow)

    hourHand = atlas:createSprite('hand_hour')
    hourHand:setPivot(11, 76)
    hourHand:setPosition(119, 120)
    face:add(hourHand)

    minuteHand = atlas:createSprite('hand_minute')
    minuteHand:setPivot(11, 99)
    minuteHand:setPosition(119, 120)
    face:add(minuteHand)

    secondHand = atlas:createSprite('hand_second')
    secondHand:setPivot(5, 99)
    secondHand:setPosition(119, 120)
    face:add(secondHand)

    local center = atlas:createSprite("center")
    center:setPosition(101, 103)
    face:add(center)

    local centerShadow = atlas:createSprite("center_shadow")
    centerShadow:setPosition(106, 107)
    face:add(centerShadow)

    signal = atlas:createIndexedSprite("signal")
    signal:setPosition(104, 105)
    face:add(signal)

    local osd = atlas:createSprite("osd")
    osd:setPosition(63, 160)
    face:add(osd)

    font = face:loadFont("digital-7-20.fnt", atlas:createSprite("font"))
    face:add(textLayer)
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

    notificationCall:setIndex(0 == deviceStatus:getMissedCalls() and 0 or 1)
    notificationAlarm:setIndex(nil == deviceStatus:getNextAlarm() and 0 or 1)
    notificationSMS:setIndex(0 == deviceStatus:getUnreadSMS() and 0 or 1)
    notificationEmail:setIndex(0 == deviceStatus:getUnreadGMail() and 0 or 1)

    local cellularLevel = deviceStatus:getCellularLevel()
    if 3 < cellularLevel then
        cellularLevel = 3
    end
    if 0 == cellularLevel then
        signal:setVisible(false)
    else
        signal:setVisible(true)
        signal:setIndex(cellularLevel)
    end

    switcher:selectCollection(face:getCurrentThemeIndex())
end
