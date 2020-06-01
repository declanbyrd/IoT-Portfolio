--[[
    Blink the LED using a timer
--]]
blinkTimer = tmr.create()
blinkTimer:register(
    2000,
    1,
    function()
        pinLED1 = 4
        pinLED2 = 0

        pinLED1Mode = gpio.read(pinLED1)
        pinLED2Mode = gpio.read(pinLED2)

        gpio.mode(pinLED2, gpio.OUTPUT)

        if (pinLED1Mode == gpio.HIGH) then
            gpio.mode(pinLED1, gpio.OUTPUT)
            gpio.write(pinLED1, gpio.LOW)

            gpio.mode(pinLED2, gpio.OUTPUT)
            gpio.write(pinLED2, gpio.HIGH)
        else
            gpio.mode(pinLED1, gpio.OUTPUT)
            gpio.write(pinLED1, gpio.HIGH)

            gpio.mode(pinLED2, gpio.OUTPUT)
            gpio.write(pinLED2, gpio.LOW)
        end
    end
)
blinkTimer:start()
