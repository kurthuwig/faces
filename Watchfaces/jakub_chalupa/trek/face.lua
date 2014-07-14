-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Jakub Chalupa"
    result.name   = "Trek"
    return result
end

function textLayer(canvas)
    timeFont:drawCentered(canvas,
        DateFormat:format("kk:mm", time),
        154, 210)
    dateFont:drawCentered(canvas,
        string.upper(DateFormat:format("EEEE dd", time)),
        154, 54)

    local nextAlarm = deviceStatus:getNextAlarm()
    if nil ~= nextAlarm then
        dataFont:drawCentered(canvas,
            "ALARM " .. DateFormat:format("kk:mm", nextAlarm),
            170, 76)
    end

    if weather ~= nil then
        dataFont:drawLeftAligned(canvas,
            weather.temperature.current .. "C",
            2, 36)
    end
    dataFont:drawLeftAligned(canvas, "Rain", 2, 56)
    dataFont:drawRightAligned(canvas,
        deviceStatus:getUnreadGMail() .. "",
        59, 118)
    dataFont:drawRightAligned(canvas,
        deviceStatus:getUnreadSMS() .. "",
        59, 158)
    dataFont:drawRightAligned(canvas,
        deviceStatus:getMissedCalls() .. "",
        59, 218)
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    timeFont = face:loadFont("Trek_TNG_Monitors_Regular-95.fnt",
        atlas:createSprite("trek-tng-digits"))
    timeFont:setColor(0xfffba000)

    dateFont = face:loadFont("Final Frontier Old Style Regular-35.fnt",
        atlas:createSprite("final-frontier"))
    dateFont:setColor(0xfffba000)

    dataFont = face:loadFont("Final Frontier Old Style Regular-18.fnt",
        atlas:createSprite("final-frontier"))
    dataFont:setColor(0xff000000)

    face:add(atlas:createSprite("face"))
    face:add(textLayer)
end

function update()

end