-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Sijmen Robers"
    result.name   = "SmartChronograph"
    return result
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    switcher = face:createLayerCollection()
    for i = 0, 3 do
        switcher:add(i, atlas:createSprite("wallpaper", i))
    end
    face:add(switcher)
    face:setThemeCount(switcher:getCollectionCount())

    face:add(atlas:createSprite("clockface"))

    batteryHand = atlas:createSprite("Battery_hand_level")
    batteryHand:setPivot(5, 23)
    batteryHand:setPosition(61, 120)
    face:add(batteryHand)

    wifiSignalHand = atlas:createSprite("Signal_hand_level")
    wifiSignalHand:setPivot(3, 35)
    wifiSignalHand:setPosition(119, 62)
    face:add(wifiSignalHand)

    cellularSignalHand = atlas:createSprite("Signal_hand_level")
    cellularSignalHand:setPivot(3, 35)
    cellularSignalHand:setPosition(119, 62)
    face:add(cellularSignalHand)

    alarmHourHand = atlas:createSprite("AlarmClock_hand_hour")
    alarmHourHand:setPivot(3, 27)
    alarmHourHand:setPosition(119, 177)
    face:add(alarmHourHand)

    alarmMinuteHand = atlas:createSprite("Signal_hand_level")
    alarmMinuteHand:setPivot(3, 35)
    alarmMinuteHand:setPosition(119, 177)
    face:add(alarmMinuteHand)

    dateTens = atlas:createSubdividedSprite("Date_icon_0to9", 10)
    dateTens:setPosition(197, 114)
    face:add(dateTens)

    dateOnes = atlas:createSubdividedSprite("Date_icon_0to9", 10)
    dateOnes:setPosition(207, 114)
    face:add(dateOnes)

    hourHand = atlas:createSprite("hour_hand")
    hourHand:setPivot(8, 57)
    hourHand:setPosition(120, 120)
    face:add(hourHand)

    minuteHand = atlas:createSprite("minute_hand")
    minuteHand:setPivot(6, 92)
    minuteHand:setPosition(120, 120)
    face:add(minuteHand)

    secondHand = atlas:createSprite("second_hand")
    secondHand:setPivot(6, 92)
    secondHand:setPosition(120, 120)
    face:add(secondHand)
end

function update()
    local hour   = time:get(Calendar.HOUR)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)
    hourHand  :setRotation(360 / 12 * (hour + minute / 60))
    minuteHand:setRotation(360 / 60 * (minute + second / 60))
    secondHand:setRotation(360 / 60 * second)

    local dayOfMonth = time:get(Calendar.DAY_OF_MONTH)
    dateTens:setIndex(math.floor(dayOfMonth / 10))
    dateOnes:setIndex(dayOfMonth % 10)

    batteryHand:setRotation(
        -120 + 240 * deviceStatus:getBatteryPercent() / 100)

    wifiSignalHand:setRotation(
        -160 + 160 * deviceStatus:getWifiPercent() / 100)

    cellularSignalHand:setRotation(
        160 - (160 / 4) * deviceStatus:getCellularLevel())

    local alarmHour = deviceStatus:getNextAlarmHour()
    if deviceStatus.NO_ALARM == alarmHour then
        alarmHourHand:setVisible(false)
        alarmMinuteHand:setVisible(false)
    else
        alarmHourHand:setVisible(true)
        alarmMinuteHand:setVisible(true)
        local alarmMinute = deviceStatus:getNextAlarmMinute()
        alarmHourHand:setRotation(
            360 / 12 * ((alarmHour % 12) + alarmMinute / 60))
        alarmMinuteHand:setRotation(360 / 60 * alarmMinute)
    end

    switcher:selectCollection(face:getCurrentThemeIndex())
end