Watchfaces API Reference
========================

Geometry
--------

All methods use a cartesian coordinate system with x pointing right and y pointing down.
The point (0, 0) is the upper left corner while (239, 239) is the lower right corner.

`face` methods
--------------
### `face:loadAtlas(name)`

Loads and returns a GDX textureatlas from a file with the given on the SD card.

### `face:loadSprite(name)`

Loads a graphic from a file with the given name on the SD card and returns it as a sprite.
Supported file formats can be found in the [Android core media format list](http://developer.android.com/guide/appendix/media-formats.html#core).
JPEG, GIF, PNG and BMP are always supported.
You should use JPEG or PNG whatever produces the smallest files on your given graphic.
JPEG is best for natural pictures while PNG is best for icon like graphics.
If you need transparency, you have to use PNG or GIF.

### `face:loadSprite(name, suffix, layerCount)`

Loads several graphics and creates an indexed sprite.
The files must be named `<name>_X.<suffix>` with X ranging from 0 to *layerCount - 1*.
Only one graphic is shown at a time.
You can define which graphic to show with `sprite:setIndex(index)` starting with index 0.

### `face:loadSprite(name, subdivisionCount)`

Loads a graphic and subdivides it horizontally into equally sized parts.
Only one part is shown at a time.
You can define which part to show with `sprite:setIndex(index)` starting with index 0.

### `face:loadFont(fontfile, sprite)`

Loads a font using the given name of the fontfile to load the font description and the given sprite to get the packed font graphics.

### `face:add(sprite)`

Adds a sprite as a layer to the face.
Layers are painted in the order they are added, i.e. the ones added later hide the ones added earlier.

### `face:add(function)`

Adds a function as a layer to the face.
The code of the function paints the layer.
Layers are painted in the order they are added, i.e. the ones added later hide the ones added earlier.

### `face:createLayerCollection()`

Creates a new layercollection.

### `face:add(layerCollection)`

Adds a collection of layers as a layer to the face.
Layercollections are painted like normal layers, but you can switch between the different collections of it.

### `face:setUpdateInterval(milliseconds)`

Sets the **desired** time between two screen updates.
Updates might happen slower or faster.

### `face:addRectangleHotzone(left, top, width, height, functionname)`

Creates a *hotzone* that has the top left corner at the coordinates *(left, top)* and the given *width* and *height*.
When the user touches this hotzone, the given function is invoked.

### `face:setBackgroundColor(red, green, blue)`

Set the background to the given color. The values for red, green and blue have a range of 0 - 255.

### `sprite:setColor(color)`

Set the background to the given RGB color code.
The first octet is the alpha channel which has to be `ff` for full opacy, like 0xffff0000 for all red.

`atlas` methods
---------------

### `atlas:createSprite(name)`

Returns a sprite from the atlas.

### `atlas:createSprite(name, index)`

Returns the index'th sprite from an indexed sprite in the atlas.

### `atlas:createIndexed(name)`

Returns a sprite consisting of multiple images.
You can switch between the sprites, e.g. for simple animations.

### `atlas:createSubdividedSprite(name, subdivisionCount)`

Loads a sprite from the atlas, subdivides it horizontally into equally sized parts and returns it as a `Sprite`.
Only one part is shown at a time.
You can define which part to show with `sprite:setIndex(index)` starting with index 0.

`sprite` methods
----------------

### `sprite:setRotation(degrees)`

Sets the clockwise rotation of the sprite in degrees.
0 is no rotation, 90 right, 180 is upside down, 270 is left and 360 is no rotation again.
The rotation happens around the *pivot point* which is the upper left corner by default.

### `sprite:setPivot(x, y)`

Sets the *pivot point* within the sprite around which a rotation happens.
You can use decimals, but you should make sure that your graphic can rotate around a single pixel as this looks much better.
If you set the position of a sprite, you set the position of the pivot point.

### `sprite:setPosition(x, y)`

Sets the position of the *pivot point* of the graphic which is the upper left corner by default.

### `sprite:translate(deltaX, deltaY)`

Moves the sprite this amount of pixels.
The values may be negative.

### `sprite:setIndex(index)`

Sets the index of the graphic to be displayed of a multi sprite.
The first image has the index 0.

### `sprite:setColor(red, green, blue)`

Tints the sprite with the given color. The values for red, green and blue have a range of 0 - 255.

### `sprite:setColor(color)`

Tints the sprite with the given RGB color code like 0xff0000 for all red.

`font` methods
--------------

### `font:drawLeftAligned(canvas, text, x, y)`

Draw the text on the given canvas having the given position on the left side and as the baseline of the text.

### `font:drawLeftCentered(canvas, text, x, y)`

Draw the text on the given canvas having the given position in the middle and as the baseline of the text.

### `font:drawRightAligned(canvas, text, x, y)`

Draw the text on the given canvas having the given position on the right side and as the baseline of the text.


### `font:setColor(red, green, blue)`

Tints the font with the given color. The values for red, green and blue have a range of 0 - 255.

### `font:setColor(color)`

Tints the font with the given RGB color code like 0xff0000 for all red.

`layercollection` methods
-------------------------

### `layercollection:add(index, sprite)`

Adds a sprite as a layer to the collection with the given number.
Layers are painted in the order they are added, i.e. the ones added later hide the ones added earlier.
Only layers of one collection are displayed at a time.

### `layercollection:add(index, function)`

Adds a function as a layer to the collection with the given number.
The code of the function paints the layer.
Layers are painted in the order they are added, i.e. the ones added later hide the ones added earlier.
Only layers of one collection are displayed at a time.

### `layercollection:setCollection(index)`

Selects the collection to show.
Only one collection can be shown at a time.

### `layercollection:getCollectionCount()`

Returns the number of defined collection.

### `layercollection:ensureSize(size)`

Makes sure that the layercollection has at least `size` collections.

`deviceStatus` methods
----------------------

### `deviceStatus:getBatteryPercent()`

Returns the current battery level in percent (0 - 100).

### `deviceStatus:getCellularLevel()`

Returns the current cellular reception level (0 - 4).

### `deviceStatus:getMissedCalls()`

Returns the number of missed calls.

### `deviceStatus:getNextAlarm()`

Returns the time of the next alarm as a `Calendar` (just like the `time` in `update`) or `nil` if there is no alarm.
As alarms cannot be queried on Android the app has to wait for an alarm broadcast, which is sent whenever the alarm changes.

### `deviceStatus:getNextAlarmHour()`

Returns the hour of the next alarm (0 - 23) or `deviceStatus.NO_ALARM` if there is no alarm.
As alarms cannot be queried on Android the app has to wait for an alarm broadcast, which is sent whenever the alarm changes.

### `deviceStatus:getNextAlarmMinute()`

Returns the minute of the next alarm (0 - 59) or `deviceStatus.NO_ALARM` if there is no alarm.
As alarms cannot be queried on Android the app has to wait for an alarm broadcast, which is sent whenever the alarm changes.

g### `deviceStatus:getUnreadGMail()`

Returns the number of unread GMail messages.

### `deviceStatus:getUnreadSMS()`

Returns the number of unread text messages.

### `deviceStatus:getWeather()`

Returns the weather at the current location.

### `deviceStatus:getWifiPercent()`

Returns the signal level of the current wifi connection (0 - 100).

### `deviceStatus:is24HourFormat()`

Returns true if the clock is set to 24h display and false if set to 12h, i.e. using "am/pm".

`weather` methods
-----------------

### `weather.temperature.min/current/max`

Returns the min/current/max temperature.

### `weather.wind.directionDegrees`

Returns the direction in degrees where the wind comes from.

### `weather.wind.speedMps`

Returns the wind speed in miles per hour.

### `weather.wind.gustsMps`

Returns the speed of gusts in miles per hour.

### `weather.weather.id`

OpenWeatherMap's id of the weather.

### `weather.weather.icon`

Name of the weather as defined by OpenWeatherMap.

### `weather.weather.main`

Main of the weather as defined by OpenWeatherMap.

### `weather.weather.description`

Description of the weather as defined by OpenWeatherMap.

### `weather.rain.hours`

Number of hours of rain for the day.

### `weather.rain.precipitationMm`

Number of millimeter of rain (liters per square meter).

### `weather.humidityPercent`

Humidity in percent (0 - 100).

### `weather.pressureMbars`

Air pressure at sea level in millibars.

### `weather.overcastPercents`

Cloud coverage in percent (0 - 100).

`OS` methods
------------

### `OS:startSMSApp()`

Starts the system's SMS (text message) app.

### `OS:startCallLogApp()`

Opens the system's call log.

### `OS:startSendMessageApp()`

Starts the app that allows to send a message.
