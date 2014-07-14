-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Jakub Chalupa"
    result.name   = "Simple"
    return result
end

COLOR_INACTIVE = 0xff399D9D
COLOR_ACTIVE = 0xffec6617

function textLayer(canvas)
    hourFont:drawLeftAligned(canvas, DateFormat:format("kk", time), 0, 105)
    minuteFont:drawLeftAligned(canvas, DateFormat:format("mm", time), 0, 211)
    infoFont:drawCentered(canvas,
        string.upper(DateFormat:format("EEE", time)),
        195, 28)
    infoFont:drawCentered(canvas, DateFormat:format("MM", time), 195, 50)
    if weather ~= nil then
        infoFont:drawCentered(canvas,
            weather.temperature.current .. " C",
            195, 88)
    end
    local missedCalls = deviceStatus:getMissedCalls()
    missedCallFont = 0 == missedCalls and infoFontInactive or infoFontActive
    missedCallFont:drawCentered(canvas, missedCalls .. "", 221, 135)

    local unreadGMail = deviceStatus:getUnreadGMail()
    unreadGmailFont = 0 == unreadGMail and infoFontInactive or infoFontActive
    unreadGmailFont:drawCentered(canvas, unreadGMail .. "", 221, 179)

    local unreadSMS = deviceStatus:getUnreadSMS()
    unreadSMSFont = 0 == unreadSMS and infoFontInactive or infoFontActive
    unreadSMSFont:drawCentered(canvas, unreadSMS .. "", 221, 218)
end

function init()
    local atlas = face:loadAtlas('all.atlas')
    face:add(atlas:createSprite("backdrop"))

    local dejavue118 = atlas:createSprite("dejavue-digits-118")
    hourFont = face:loadFont("DejaVuSans-118.fnt", dejavue118)
    hourFont:setColor(COLOR_INACTIVE)

    minuteFont = face:loadFont("DejaVuSans-118.fnt", dejavue118)
    minuteFont:setColor(COLOR_ACTIVE)

    local dejavue21 = atlas:createSprite("dejavue-alpha-21")
    infoFont = face:loadFont("DejaVuSans-21.fnt", dejavue21)
    infoFontActive = face:loadFont("DejaVuSans-21.fnt", dejavue21)
    infoFontActive:setColor(COLOR_ACTIVE)
    infoFontInactive = face:loadFont("DejaVuSans-21.fnt", dejavue21)
    infoFontInactive:setColor(COLOR_INACTIVE)
    face:add(textLayer)
end

function update()
    -- empty
end