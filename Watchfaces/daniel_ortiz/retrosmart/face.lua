-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Daniel Ortiz"
    result.name   = "Retrosmart"
    return result
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    switcher = face:createLayerCollection()
    switcher:add(0, atlas:createSprite("face_casio"))
    switcher:add(1, atlas:createSprite("face_night"))
    switcher:add(2, atlas:createSprite("face_indigo"))
    switcher:add(3, atlas:createSprite("face_red"))
    face:add(switcher)
    face:setThemeCount(switcher:getCollectionCount())

    hourTens = atlas:createSubdividedSprite("digits_big", 10)
    hourTens:setPosition(31, 112)
    face:add(hourTens)

    hourOnes = atlas:createSubdividedSprite("digits_big", 10)
    hourOnes:setPosition(63, 112)
    face:add(hourOnes)

    colon = atlas:createSprite("colon")
    colon:setPosition(97, 121)
    face:add(colon)

    minuteTens = atlas:createSubdividedSprite("digits_big", 10)
    minuteTens:setPosition(106, 112)
    face:add(minuteTens)

    minuteOnes = atlas:createSubdividedSprite("digits_big", 10)
    minuteOnes:setPosition(138, 112)
    face:add(minuteOnes)

    secondTens = atlas:createSubdividedSprite("digits_medium", 10)
    secondTens:setPosition(170, 131)
    face:add(secondTens)

    secondOnes = atlas:createSubdividedSprite("digits_medium", 10)
    secondOnes:setPosition(188, 131)
    face:add(secondOnes)

    date = {}
    for i = 1, 8 do
        date[i] = atlas:createSubdividedSprite("digits_small", 11)
        date[i]:setPosition(17 + 16 * i, 82)
        face:add(date[i])
    end
    date[3]:setIndex(10)
    date[6]:setIndex(10)
end

function update()
    local hour   = time:get(Calendar.HOUR_OF_DAY)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)

    hourTens:setIndex(hour / 10)
    hourOnes:setIndex(hour % 10)
    colon:setVisible(0 == second % 2)
    minuteTens:setIndex(minute / 10)
    minuteOnes:setIndex(minute % 10)
    secondTens:setIndex(second / 10)
    secondOnes:setIndex(second % 10)

    local year  = time:get(Calendar.YEAR) % 100
    local month = time:get(Calendar.MONTH) + 1
    local day   = time:get(Calendar.DAY_OF_MONTH)
    date[1]:setIndex(month / 10)
    date[2]:setIndex(month % 10)
    date[4]:setIndex(day / 10)
    date[5]:setIndex(day % 10)
    date[7]:setIndex(year / 10)
    date[8]:setIndex(year % 10)

    switcher:selectCollection(face:getCurrentThemeIndex())
end