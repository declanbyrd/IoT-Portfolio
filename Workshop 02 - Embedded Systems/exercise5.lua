-- OPTIONAL

--[[
    blinking, dimming LED using pwm and tmr
--]]
--

dc = 1023 --duty cycle
direction = 0 -- 0 for down, 1 for up
pinDim = 3

intervals = {500, 300}
index = 0

pwm.setup(pinDim, 500, dc) -- 1000 is the rate of change.
pwm.start(pinDim)
blinkDimTimer = tmr.create()
blinkDimTimer:alarm(
    200,
    tmr.ALARM_AUTO,
    function()
        flashAndDimLights(intervals)
    end
)

function dimLights()
    if direction < 1 and dc > 10 then
        dc = dc - 20
        print(dc)
        pwm.setduty(pinDim, dc)
        if dc < 20 then
            direction = 1
        end
    else
        dc = dc + 10
        print(dc)
        pwm.setduty(pinDim, dc)
        if dc > 1013 then
            direction = 0
        end
    end
end

function flashAndDimLights(intervals)
    index = index % #intervals + 1
    blinkDimTimer:interval(intervals[index] + 1)
    if index == 1 then
        dimLights()
    else
        pwm.setduty(pinDim, 0)
    end
end
