-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Olivier Utz"
    result.name   = "Digital Native"
    return result
end

COLOR_ACTIVE   = 0xff00a6df
COLOR_INACTIVE = 0xffaaaaaa
COLOR_HOUR     = COLOR_ACTIVE
COLOR_MINUTE   = 0xffffffff
COLOR_DAY      = COLOR_ACTIVE
COLOR_DATE     = COLOR_INACTIVE

function textLayer(canvas)
    local hour   = time:get(Calendar.HOUR_OF_DAY)
    local minute = time:get(Calendar.MINUTE)
    hourFont:drawLeftAligned(canvas,
        math.floor(hour / 10) .. "  " .. (hour % 10),
        7, 104)
    minuteFont:drawLeftAligned(canvas,
        math.floor(minute / 10) .. "  " .. (minute % 10),
        65, 104)
    dateFont:drawLeftAligned(canvas,
        string.upper(DateFormat:format("MMM", time)),
        34, 151)
    dayFont:drawLeftAligned(canvas,
        time:get(Calendar.DAY_OF_MONTH) .. "",
        32, 180)
    dateFont:drawLeftAligned(canvas,
        string.upper(DateFormat:format("EEE", time)),
        34, 201)
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    batteryLevel = {}
    for i = 0, 4 do
        batteryLevel[i] = atlas:createSprite("icon_battery")
        batteryLevel[i]:setPosition(10, 194 - i * 14)
        face:add(batteryLevel[i])
    end
    local arialDigits = atlas:createSprite("arial-digits")
    hourFont = face:loadFont("Arial_Bold-100.fnt", arialDigits)
    hourFont:setColor(COLOR_HOUR)

    minuteFont = face:loadFont("Arial_Bold-100.fnt", arialDigits)
    minuteFont:setColor(COLOR_MINUTE)

    dayFont = face:loadFont("Arial_Bold-30.fnt", arialDigits)
    dayFont:setColor(COLOR_DAY)
    dateFont = face:loadFont("Arial-18.fnt", atlas:createSprite("arial-text"))
    dateFont:setColor(COLOR_DATE)

    icon_telefon = atlas:createSprite("icon_telefon")
    icon_telefon:setPosition(102, 156)
    face:add(icon_telefon)

    icon_email = atlas:createSprite("icon_email")
    icon_email:setPosition(147, 160)
    face:add(icon_email)

    icon_camera = atlas:createSprite("icon_kamera")
    icon_camera:setPosition(195, 155)
    icon_camera:setColor(COLOR_INACTIVE)
    face:add(icon_camera)

    face:add(textLayer)
end

function update()
    local batteryPercent = deviceStatus:getBatteryPercent()
    for i = 0, 4 do
        batteryLevel[i]:setColor(16 + 17 * i < batteryPercent
                and COLOR_ACTIVE
                or COLOR_INACTIVE)
    end

    icon_telefon:setColor(0 == deviceStatus:getMissedCalls()
            and COLOR_INACTIVE or COLOR_ACTIVE)
    icon_email:setColor(0 == deviceStatus:getUnreadGMail()
            and COLOR_INACTIVE or COLOR_ACTIVE)
end