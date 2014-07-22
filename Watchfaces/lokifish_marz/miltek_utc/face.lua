-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Lokifish Marz"
    result.name   = "Miltek UTC"
    return result
end

COLOR_INACTIVE = 0x80ffffff
COLOR_ACTIVE   = 0x80ff3d3d

function init()
    local atlas = face:loadAtlas('all.atlas')
    face:add(atlas:createSprite("face"))
    utcHand = atlas:createSprite("utc_hand")
    utcHand:setPivot(11, 99)
    utcHand:setPosition(120, 120)
    face:add(utcHand)

    minuteHand = atlas:createSprite("minute_hand")
    minuteHand:setPivot(9, 91)
    minuteHand:setPosition(120, 120)
    face:add(minuteHand)

    hourHand = atlas:createSprite("hour_hand")
    hourHand:setPivot(8, 51.5)
    hourHand:setPosition(120, 120)
    face:add(hourHand)

    secondHand = atlas:createSprite("second_hand")
    secondHand:setPivot(0.5, 100)
    secondHand:setPosition(120, 120)
    face:add(secondHand)

    callNotification = atlas:createSprite("call")
    callNotification:setPosition(9, 9)
    callNotification:setColor(COLOR_INACTIVE)
    face:add(callNotification)

    textsNotification = atlas:createSprite("texts")
    textsNotification:setPosition(200, 10)
    textsNotification:setColor(COLOR_INACTIVE)
    face:add(textsNotification)

    emailNotification = atlas:createSprite("email")
    emailNotification:setPosition(11, 210)
    emailNotification:setColor(COLOR_INACTIVE)
    face:add(emailNotification)

    alarmNotification = atlas:createSprite("alarm")
    alarmNotification:setPosition(112, 153)
    alarmNotification:setColor(COLOR_INACTIVE)
    face:add(alarmNotification)

    calendarNotification = atlas:createSprite("calendar")
    calendarNotification:setPosition(108, 67)
    calendarNotification:setColor(COLOR_INACTIVE)
    face:add(calendarNotification)

    face:addRectangleHotzone(0, 0, 60, 60,
        function () OS:startCallLogApp() end)

    face:addRectangleHotzone(180, 0, 60, 60,
        function () OS:startSMSApp() end)

    face:addRectangleHotzone(0, 180, 60, 60,
        function () OS:startSendMessageApp() end)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    hourHand  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHand:setRotation(360 / 60 * (minute + second / 60))
    secondHand:setRotation(360 / 60 * second)

    local z = time:getTimeZone()
    local offset = z:getRawOffset()
    if z:inDaylightTime(time:getTime()) then
        offset = offset + z:getDSTSavings()
    end

    local offsetHrs = offset / 1000 / 60 / 60
    local offsetMins = offset / 1000 / 60 % 60

    local utcTime = time:clone()
    utcTime:add(Calendar.HOUR_OF_DAY, -offsetHrs)
    utcTime:add(Calendar.MINUTE,      -offsetMins)
    local utcHour   = utcTime:get(Calendar.HOUR_OF_DAY)
    local utcMinute = utcTime:get(Calendar.MINUTE)
    utcHand:setRotation(360 / 24 * (utcHour + utcMinute / 60))

    alarmNotification:setColor(nil ~= deviceStatus:getNextAlarm()
            and COLOR_ACTIVE or COLOR_INACTIVE)
    callNotification:setColor(0 == deviceStatus:getMissedCalls()
            and COLOR_INACTIVE or COLOR_ACTIVE)
    textsNotification:setColor(0 == deviceStatus:getUnreadSMS()
            and COLOR_INACTIVE or COLOR_ACTIVE)
    emailNotification:setColor(0 == deviceStatus:getUnreadGMail()
            and COLOR_INACTIVE or COLOR_ACTIVE)

    secondHand:setVisible(deviceStatus:isShowSeconds())
end