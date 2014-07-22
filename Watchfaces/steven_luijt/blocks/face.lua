-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Steven Luijt"
    result.name   = "Blocks"
    return result
end

PIXELS_PER_SECOND = 171
UPPER_POSITION    = 22
LOWER_POSITION    = 203

COLOR_BLUE   = 0xff4a77fa
COLOR_RED    = 0xfff84848
COLOR_ORANGE = 0xfffec760
COLOR_GREEN  = 0xff8aff61

function textLayer(canvas)
    dateFont:drawCentered(canvas,
        DateFormat:format("dd-MM-yyyy", time),
        180, 36)
    local weather = deviceStatus:getWeather()
    if weather ~= nil then
        temperatureFont:drawRightAligned(
            canvas,
            math.floor(weather.temperature.current + 0.5) .. "°C",
            225, 66)
    end
end

function createBlocks(atlas, count, startX, startY, deltaX, deltaY)
    local result = {}
    local x = startX
    local y = startY
    for i = 0, count - 1 do
        local sprite = atlas:createSprite("block")
        sprite:setPosition(x, y)
        face:add(sprite)
        result[i] = sprite
        x = x + deltaX
        y = y + deltaY
    end
    return result
end

function setColor(sprites, color)
    for i = 0, #sprites do
        sprite = sprites[i]
        sprite:setColor(color)
    end
end

function setVisibility(sprites, pivot)
    for i = 0, #sprites do
        sprite = sprites[i]
        sprite:setVisible(i < pivot)
    end
end

function setDropPosition(drop, millisecond, digit, x, max, dropEnabled)
    local position = LOWER_POSITION - digit * 15
                     - PIXELS_PER_SECOND * (1 - millisecond / 1000)
    if max == digit or not dropEnabled or position < UPPER_POSITION then
        drop:setVisible(false)
        return
    end

    drop:setVisible(true)
    drop:setPosition(x, position)
end

function init()
    local atlas = face:loadAtlas('all.atlas')
    local fontSprite = atlas:createSprite('font')
    dateFont = face:loadFont("Roboto-Regular-15.fnt", fontSprite)
    temperatureFont = face:loadFont("Roboto-Regular-21.fnt", fontSprite)
    face:add(textLayer)

    batteryBlocks = createBlocks(atlas, 5, 144, 88, 15, 0)

    hourTens = createBlocks(atlas, 2, 37, 203, 0, -15)
    setColor(hourTens, COLOR_BLUE)
    hourTensDrop = atlas:createSprite("block")
    hourTensDrop:setColor(COLOR_BLUE)
    face:add(hourTensDrop)

    hourOnes = createBlocks(atlas, 10, 52, 203, 0, -15)
    setColor(hourOnes, COLOR_BLUE)
    hourOnesDrop = atlas:createSprite("block")
    hourOnesDrop:setColor(COLOR_BLUE)
    face:add(hourOnesDrop)

    minuteTens = createBlocks(atlas, 5, 67, 203, 0, -15)
    setColor(minuteTens, COLOR_RED)
    minuteTensDrop = atlas:createSprite("block")
    minuteTensDrop:setColor(COLOR_RED)
    face:add(minuteTensDrop)

    minuteOnes = createBlocks(atlas, 10, 82, 203, 0, -15)
    setColor(minuteOnes, COLOR_RED)
    minuteOnesDrop = atlas:createSprite("block")
    minuteOnesDrop:setColor(COLOR_RED)
    face:add(minuteOnesDrop)

    secondTens = createBlocks(atlas, 5, 97, 203, 0, -15)
    setColor(secondTens, COLOR_GREEN)
    secondTensDrop = atlas:createSprite("block")
    secondTensDrop:setColor(COLOR_GREEN)
    face:add(secondTensDrop)

    secondOnes = createBlocks(atlas, 10, 112, 203, 0, -15)
    setColor(secondOnes, COLOR_GREEN)
    secondOnesDrop = atlas:createSprite("block")
    secondOnesDrop:setColor(COLOR_GREEN)
    face:add(secondOnesDrop)

    local frame = atlas:createSprite("face")
    frame:setPosition(12, 20)
    face:add(frame)

    face:setUpdateInterval(20)
end

function update()
    local hour   = time:get(Calendar.HOUR_OF_DAY)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)
    local millisecond = time:get(Calendar.MILLISECOND)

    local isShowSeconds = deviceStatus:isShowSeconds()
    setVisibility(hourTens, math.floor(hour / 10))
    setVisibility(hourOnes, hour % 10)
    setVisibility(minuteTens, math.floor(minute / 10))
    setVisibility(minuteOnes, minute % 10)
    setVisibility(secondTens, isShowSeconds and math.floor(second / 10) or 0)
    setVisibility(secondOnes, isShowSeconds and second % 10 or 0)

    hourTensDrop:setVisible(isShowSeconds)
    hourOnesDrop:setVisible(isShowSeconds)
    minuteTensDrop:setVisible(isShowSeconds)
    minuteOnesDrop:setVisible(isShowSeconds)
    secondTensDrop:setVisible(isShowSeconds)
    secondOnesDrop:setVisible(isShowSeconds)

    setDropPosition(hourTensDrop,
                    millisecond,
                    hour / 10,
                    37, 2,
                    9 == hour % 10 and 59 == minute and 59 == second)
    setDropPosition(hourOnesDrop,
                    millisecond,
                    hour % 10,
                    52, 9,
                    23 ~= hour and 59 == minute and 59 == second)
    setDropPosition(minuteTensDrop,
                    millisecond,
                    minute / 10,
                    67, 5,
                    9 == minute % 10 and 59 == second)
    setDropPosition(minuteOnesDrop,
                    millisecond,
                    minute % 10,
                    82, 9,
                    59 == second)
    setDropPosition(secondTensDrop,
                    millisecond,
                    second / 10,
                    97, 5,
                    9 == second % 10)
    setDropPosition(secondOnesDrop,
                    millisecond,
                    second % 10,
                    112, 9,
                    true)

    local batteryPercent = deviceStatus:getBatteryPercent()
    local blockCount = batteryPercent / 20 + 1
    if 5 < blockCount then
        blockCount = 5
    end
    setVisibility(batteryBlocks, blockCount)

    local batteryColor
    if 1 == blockCount then
        batteryColor = COLOR_RED
    elseif 2 == blockCount then
        batteryColor = COLOR_ORANGE
    else
        batteryColor = COLOR_GREEN
    end
    setColor(batteryBlocks, batteryColor)
end