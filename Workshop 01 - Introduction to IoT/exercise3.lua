-- OPTIONAL

--[[
    Using GPIO and the tmr module, make the LED blink following a predefined time interval.
    Led is on for 1000ms, off for 500ms, on for 2000ms and off for 2000ms before repeating the cycle.
--]]
pinLED1 = 4
gpio.mode(pinLED1, gpio.OUTPUT)
intervals = {1000, 500, 2000, 200} --type table
index = 1 --indexes start at 1 in Lua

blinkTimer = tmr.create()
blinkTimer:register(
    100,
    1,
    function()
        blinkLED(pinLED1, intervals)
    end
)

blinkTimer:start()

-- #intervals is the length of the table.
function blinkLED(pin, intervals)
    if index > #intervals then
        index = 1
    else
        index = index % #intervals + 1
        blinkTimer:interval(intervals[index] + 1)
        gpio.write(pin, (index + 1) % 2)
    end
end
