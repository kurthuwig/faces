-- This file is part of the Watchfaces project.
-- Read the file README.md for copyright and other information

function about()
    local result = {}
    result.author = "Kurt Huwig"
    result.name   = "Tennis"
    return result
end

COLORS = {
    0xffffff,
    0x00ff00,
    0xf2760f,
    0x000000,
}

BACKGROUND_COLORS = {
    0xff000000,
    0xff000000,
    0xff000000,
    0xffffffff,
}

PLAYFIELD_Y_MIN = 64;
PLAYFIELD_Y_MAX = 240;

LEFT_RACKET_X = 10
RIGHT_RACKET_X = 222
RACKET_WIDTH = 8
RACKET_HEIGHT = 48

BALL_SIZE = 8
MAX_RACKET_VELOCITY = 200

function init()
    local atlas = face:loadAtlas('all.atlas')
    playfield = atlas:createSprite("playfield")
    face:add(playfield)

    hourTens = atlas:createSubdividedSprite("digits", 11)
    hourTens:setPosition(30, 8)
    face:add(hourTens)

    hourOnes = atlas:createSubdividedSprite("digits", 11)
    hourOnes:setPosition(70, 8)
    face:add(hourOnes)

    minuteTens = atlas:createSubdividedSprite("digits", 11)
    minuteTens:setPosition(138, 8)
    face:add(minuteTens)

    minuteOnes = atlas:createSubdividedSprite("digits", 11)
    minuteOnes:setPosition(178, 8)
    face:add(minuteOnes)

    ball = atlas:createSprite("ball")
    face:add(ball)

    leftRacket = atlas:createSprite("racket")
    face:add(leftRacket)

    rightRacket = atlas:createSprite("racket")
    face:add(rightRacket)

    leftRacketY = 120
    rightRacketY = 120

    ballY = 64
    speedY = 40

    face:setUpdateInterval(40)

    lastUpdate = time:getTimeInMillis()
    face:setThemeCount(#COLORS)
end

function getBallPosition(minute, second, millisecond)
    if 0 == minute and second < 1 then
        return 240
    end
    if 0 == second then
        return -millisecond / 3000
    end

    local fraction = (second * 1000 + millisecond) % 6000

    if 59 == minute and 54 < second then
        return fraction / 3000
    end

    return fraction < 3000 and fraction / 3000
            or  (6000 - fraction) / 3000
end

function update()
    local hour   = time:get(Calendar.HOUR_OF_DAY)
    local minute = time:get(Calendar.MINUTE)
    local second = time:get(Calendar.SECOND)
    local millisecond = time:get(Calendar.MILLISECOND)

    hourTens:setIndex(hour / 10)
    hourOnes:setIndex(hour % 10)
    minuteTens:setIndex(minute / 10)
    minuteOnes:setIndex(minute % 10)

    now = time:getTimeInMillis()
    deltaTime = (now - lastUpdate) / 1000
    lastUpdate = now

    ballY = ballY + deltaTime * speedY
    if PLAYFIELD_Y_MAX < ballY then
        ballY = PLAYFIELD_Y_MAX - (ballY - PLAYFIELD_Y_MAX)
        speedY = -speedY
    elseif ballY < PLAYFIELD_Y_MIN then
        ballY = PLAYFIELD_Y_MIN + (PLAYFIELD_Y_MIN - ballY)
        speedY = -speedY
    end

    local ballX =
    (RIGHT_RACKET_X - LEFT_RACKET_X - RACKET_WIDTH - BALL_SIZE)
            * getBallPosition(minute, second, millisecond)
            + LEFT_RACKET_X + RACKET_WIDTH

    ball:setPosition(ballX, ballY - BALL_SIZE)

    local targetPosition
    if 0 == second or 58 < second or (59 == minute and 54 < second) then
        targetPosition = ballY - BALL_SIZE * 1.5
    else
        targetPosition = ballY + RACKET_HEIGHT / 2
    end

    if ballX < 120 then
        local difference = targetPosition - leftRacketY
        leftRacketY = leftRacketY
                + math.min(math.abs(difference),
            MAX_RACKET_VELOCITY * deltaTime)
                * (difference < 0 and -1 or 1)
    else
        local difference = targetPosition - rightRacketY
        rightRacketY = rightRacketY
                + math.min(math.abs(difference),
            MAX_RACKET_VELOCITY * deltaTime)
                * (difference < 0 and -1 or 1)
    end
    leftRacket:setPosition(LEFT_RACKET_X, leftRacketY - RACKET_HEIGHT)
    rightRacket:setPosition(RIGHT_RACKET_X, rightRacketY - RACKET_HEIGHT)

    local COLOR = COLORS[face:getCurrentThemeIndex() + 1]
    hourTens:setColor(COLOR)
    hourOnes:setColor(COLOR)
    minuteTens:setColor(COLOR)
    minuteOnes:setColor(COLOR)
    leftRacket:setColor(COLOR)
    rightRacket:setColor(COLOR)
    ball:setColor(COLOR)
    playfield:setColor(COLOR)

    face:setBackgroundColor(BACKGROUND_COLORS[face:getCurrentThemeIndex() + 1])
end