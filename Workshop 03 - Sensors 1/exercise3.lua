--[[
    Read sensor data and illuminate LED on button press
--]]
buttonPin = 2
gpio.mode(buttonPin, gpio.INPUT)
gpio.write(buttonPin, gpio.LOW)

pushed = 0

mytimer = tmr.create()
mytimer:register(
    100,
    1,
    function()
        if (gpio.read(buttonPin) == 1 and (pushed == 0)) then
            pushed = 1
            print("Button detected")
        elseif (gpio.read(buttonPin) == 0 and pushed == 1) then
            pushed = 0
        end
    end
)

mytimer:start()
