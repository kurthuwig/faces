-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Andreas Wettl and Daniel Ortiz"
    result.name   = "Pac"
    return result
end

function textLayer(canvas)
    batteryFont:drawCentered(canvas,
        deviceStatus:getBatteryPercent() .. "%",
        120, 64)
    dateFont:drawCentered(canvas,
        DateFormat:format("dd.MM.yyyy", time),
        120, 100)
    timeFont:drawCentered(canvas,
        DateFormat:format("kk:mm", time),
        120, 129)
    local weather = deviceStatus:getWeather()
    if weather ~= nil then
        temperatureFont:drawCentered(
            canvas,
            math.floor(weather.temperature.current + 0.5) .. "C",
            122, 159)
    end
end

function init()
    local atlas = face:loadAtlas('all.atlas')
    rightPellets = atlas:createIndexedSprite("pellets")
    rightPellets:setPosition(121, 25)
    face:add(rightPellets)

    rightPellets1 = atlas:createIndexedSprite("pellets")
    rightPellets1:setIndex(1)
    rightPellets1:setPosition(21, 25)
    face:add(rightPellets1)

    halfDisc = atlas:createSprite("half_disc")
    halfDisc:setPivot(0, 104)
    halfDisc:setPosition(120, 120)
    face:add(halfDisc)

    leftPellets = atlas:createIndexedSprite("pellets")
    leftPellets:setIndex(1)
    leftPellets:setPosition(21, 25)
    face:add(leftPellets)

    face:add(atlas:createSprite("face"))

    local blueGhost = atlas:createSprite("blue_ghost")
    blueGhost:setPosition(113, 19)
    face:add(blueGhost)

    pacmanClosed = atlas:createIndexedSprite("pacsec")
    pacmanClosed:setPivot(14, 106)
    pacmanClosed:setPosition(120, 120)
    face:add(pacmanClosed)

    pacmanOpen = atlas:createIndexedSprite("pacsec")
    pacmanOpen:setIndex(1)
    pacmanOpen:setPivot(14, 106)
    pacmanOpen:setPosition(120, 120)
    face:add(pacmanOpen)

    local font = atlas:createSprite("font")

    batteryFont = face:loadFont("atari full-12.fnt", font)
    batteryFont:setColor(0x42b064)

    dateFont = face:loadFont("atari full-12.fnt", font)
    dateFont:setColor(0x5ad7ff)

    temperatureFont = face:loadFont("atari full-12.fnt", font)

    timeFont = face:loadFont("atari full-20.fnt", font)
    timeFont:setColor(0xfff500)

    face:add(textLayer)
end

function update()
    local isShowSeconds = deviceStatus:isShowSeconds()
    local second = time:get(Calendar.SECOND)
    pacmanClosed:setRotation(360 / 60 * second)
    pacmanOpen:setRotation(360 / 60 * second)
    pacmanClosed:setVisible(isShowSeconds and 0 == second % 2)
    pacmanOpen:setVisible(isShowSeconds and 1 == second % 2)
    halfDisc:setRotation(360 / 60 * second + 180)
    rightPellets:setVisible(isShowSeconds and second < 30)
    leftPellets:setVisible(isShowSeconds and second < 30)
    rightPellets1:setVisible(isShowSeconds)
end