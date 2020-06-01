--[[
    pwn dim cycle of top down, bottom up.
    light to dark, then dark to light.
--]]
dc = 1023 --duty cycle
direction = 0 -- 0 for down, 1 for up
pinDim = 3
pwm.setup(pinDim, 500, dc) -- 1000 is the rate of change.
pwm.start(pinDim)
mytimer = tmr.create()
mytimer:alarm(
    200,
    tmr.ALARM_AUTO,
    function()
        if direction < 1 and dc > 10 then
            dc = dc - 10
            print(dc)
            pwm.setduty(pinDim, dc)
            if dc < 10 then
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
)
