-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function textLayer(canvas)
    local screenIndex = screens:getSelectedCollectionIndex()
    if 0 == screenIndex then
        systemFont:drawCenteredWrapped(canvas,
            "Fling sideways to switch faces",
            120, 120,
            240)
    elseif 1 == screenIndex then
        systemFont:drawCenteredWrapped(canvas,
            "Fling up and down to switch themes",
            142, 60,
            195)
    elseif 2 == screenIndex then
        systemFont:drawCenteredWrapped(canvas,
            "Double tap to open options",
            122, 110,
            230)
    end
end

function init()
    local atlas = face:loadAtlas('all.atlas')

    screens = face:createLayerCollection()
    face:add(screens)

    local horizontalArrow = atlas:createSprite("horizontalArrow")
    horizontalArrow:setPosition(20, 20)
    screens:add(0, horizontalArrow)

    local verticalArrow = atlas:createSprite("verticalArrow")
    verticalArrow:setPosition(5, 20)
    screens:add(1, verticalArrow)

    screens:ensureSize(3)

    systemFont = face:loadFont("RobotoCondensed-Light-40.fnt",
        atlas:createSprite("fonts"))

    face:add(textLayer)
    face:setBackgroundColor(0xa0000000)
end

function update()
    screens:selectCollection(face:getCurrentThemeIndex())
end