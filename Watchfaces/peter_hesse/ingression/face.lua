-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Peter Hesse"
    result.name   = "Ingression"
    return result
end

COLOR_RESISTANCE  = 0xff00d8ff
COLOR_ENLIGHTENED = 0xff21ea00

function textLayer(canvas)
    local hour = time:get(Calendar.HOUR_OF_DAY)

    local color = COLOR_RESISTANCE
    local color = 0 == face:getCurrentThemeIndex() and COLOR_RESISTANCE
                                                    or COLOR_ENLIGHTENED
    coda26:setColor(color)
    coda57:setColor(color)

    local format24 = deviceStatus:is24HourFormat()
    local formatString = format24 and "kk:mm:ss" or "hh:mm:ss"
    local timeString = DateFormat:format(formatString, time)
            .. (((not format24) and 12 < hour) and "." or "")
    coda26:drawCentered(canvas,
        DateFormat:format("EEE d. MMM yyyy", time),
        120, 20)
    coda57:drawCentered(canvas, timeString,  120, 120)
    coda26:drawCentered(canvas, "LinuxChef", 120, 220)
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    switcher = face:createLayerCollection()
    switcher:add(0, atlas:createSprite("resistance"))
    switcher:add(1, atlas:createSprite("enlightened"))
    face:add(switcher)
    face:setThemeCount(switcher:getCollectionCount())

    local coda = atlas:createSprite("coda")
    coda26 = face:loadFont("Coda-Regular-26.fnt", coda)
    coda57 = face:loadFont("Coda-Regular-57.fnt", coda)
    face:add(textLayer)
end

function update()
    switcher:selectCollection(face:getCurrentThemeIndex())
end