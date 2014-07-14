-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Hugo Arends"
    result.name   = "Timicon"
    return result
end

COLOR = 0xff0099cc
COLOR_ACTIVE = COLOR
COLOR_INACTIVE = 0xffffffff

function textLayer(canvas)
    robotoBoldItalic18:drawRightAligned(
        canvas,
        string.upper(DateFormat:format("EEE dd", time)),
        228, 121)

    callIcon:setColor(0 == deviceStatus:getMissedCalls()
                      and COLOR_INACTIVE or COLOR_ACTIVE)
    alarmIcon:setColor(nil == deviceStatus:getNextAlarm()
                       and COLOR_INACTIVE or COLOR_ACTIVE)
    smsIcon:setColor(0 == deviceStatus:getUnreadSMS()
                     and COLOR_INACTIVE or COLOR_ACTIVE)
    mailIcon:setColor(0 == deviceStatus:getUnreadGMail()
                      and COLOR_INACTIVE or COLOR_ACTIVE)
end

function init()
    local atlas = face:loadAtlas("all.atlas")

    local tmp = atlas:createSprite("10_device_access_screen_rotation")
    tmp:setPosition(104, 7)
    face:add(tmp)

    local tmp = atlas:createSprite("11_alerts_and_states_airplane_mode_off")
    tmp:setPosition(154, 15)
    face:add(tmp)

    local tmp = atlas:createSprite("10_device_access_volume_muted")
    tmp:setPosition(190, 56)
    face:add(tmp)

    face:add(textLayer)

    smsIcon = atlas:createSprite("6_social_chat")
    smsIcon:setPosition(192, 148)
    face:add(smsIcon)

    mailIcon = atlas:createSprite("5_content_email")
    mailIcon:setPosition(154, 192)
    face:add(mailIcon)

    alarmIcon = atlas:createSprite("10_device_access_alarms")
    alarmIcon:setPosition(104, 202)
    face:add(alarmIcon)

    local tmp = atlas:createSprite("10_device_access_bluetooth")
    tmp:setPosition(53, 190)
    face:add(tmp)

    callIcon = atlas:createSprite("10_device_access_ring_volume")
    callIcon:setPosition(15, 153)
    face:add(callIcon)

    local tmp = atlas:createSprite("10_device_access_location_found")
    tmp:setPosition(2, 102)
    face:add(tmp)

    local tmp = atlas:createSprite("10_device_access_network_cell")
    tmp:setPosition(17, 49)
    face:add(tmp)

    local tmp = atlas:createSprite("10_device_access_network_wifi")
    tmp:setPosition(51, 14)
    face:add(tmp)

    minuteHand = atlas:createSprite("minute_hand")
    minuteHand:setPivot(4.5, 110)
    minuteHand:setPosition(119.5, 119.5)
    minuteHand:setColor(COLOR)
    face:add(minuteHand)

    hourHand = atlas:createSprite("hour_hand")
    hourHand:setPivot(4.5, 50)
    hourHand:setPosition(119.5, 119.5)
    hourHand:setColor(COLOR)
    face:add(hourHand)

    robotoBoldItalic18 = face:loadFont("Roboto-BoldItalic-18.fnt",
                                       atlas:createSprite("font"))
    robotoBoldItalic18:setColor(COLOR)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    hourHand  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHand:setRotation(360 / 60 * (minute + second / 60))
end
