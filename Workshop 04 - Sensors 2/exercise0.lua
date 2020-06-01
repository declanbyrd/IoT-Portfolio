buttonPin = 0
ledPin = 1

gpio.mode(buttonPin, gpio.INPUT)
gpio.mode(ledPin, gpio.OUTPUT)
gpio.write(ledPin, gpio.LOW)

pushed = 0
mytimerPush = tmr.create()
mytimerRelease = tmr.create()

mytimerPush:register(
    100,
    1,
    function()
        if (gpio.read(buttonPin) == 1 and pushed == 0) then
            pushed = 1
            gpio.write(ledPin, gpio.HIGH)
        end
    end
)

mytimerRelease:register(
    100,
    1,
    function()
        if (gpio.read(buttonPin) == 1 and pushed == 1) then
            pushed = 0
            gpio.write(ledPin, gpio.LOW)
        end
    end
)

mytimerPush:start()
mytimerRelease:start()
