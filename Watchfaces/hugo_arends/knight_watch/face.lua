-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Hugo Arends and myKITT.de"
    result.name   = "Knight Watch"
    return result
end

function textLayer(canvas)
    bigDigits:drawLeftAligned(canvas,
                              DateFormat:format("kk:mm", time),
                              40, 98)
    if deviceStatus:isShowSeconds() then
        smallDigits:drawLeftAligned(canvas,
                                    DateFormat:format("ss", time),
                                    165, 98)
    end
end

function init()
    local atlas = face:loadAtlas("all.atlas")
    face:add(atlas:createSprite("face"))

    bigDigits = face:loadFont("digital-7 (mono)-55.fnt",
        atlas:createSprite("font"))
    bigDigits:setColor(0x000000)
    smallDigits = face:loadFont("digital-7 (mono)-27.fnt",
        atlas:createSprite("font"))
    smallDigits:setColor(0x000000)
    face:add(textLayer)
end

function update()
end