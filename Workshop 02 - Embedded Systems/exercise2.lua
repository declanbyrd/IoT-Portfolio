--[[
    Use the pwm module to dim the LED
--]]
dc = 1023 --duty cycle
pinDim = 3
pwm.setup(pinDim, 500, dc) -- 500 is the rate of change.
pwm.start(pinDim)
pwmTimer = tmr.create()
pwmTimer:alarm(
    200,
    tmr.ALARM_AUTO,
    function()
        dc = dc - 10
        print(dc)
        pwm.setduty(pinDim, dc)
        if (dc < 10) then
            dc = 1023
        end
    end
)
