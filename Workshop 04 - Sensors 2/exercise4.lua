buttonPin = 7
ledPin = 1
adcPin = 0
pushed = 0

dc = 1023 --duty cycle

index = 1

pwm.setup(ledPin, 500, 0) -- 500 is the rate of change.
pwm.start(ledPin)
mytimerPush = tmr.create()
mytimerRelease = tmr.create()

mytimerPush:register(
  100,
  1,
  function()
    if (gpio.read(buttonPin) == 1 and pushed == 0) then
      pushed = 1
    end
  end
)

mytimerRelease:register(
  100,
  1,
  function()
    if (gpio.read(buttonPin) == 1 and pushed == 1) then
      if index == 5 then
        pwm.setduty(ledPin, 0)
        index = 1
      else
        index = index + 1
        pushed = 0
        lightLevel = adc.read(adcPin)
        brightness = lightLevel % index
        print(lightLevel)
        pwm.setduty(ledPin, brightness)
      end
    end
  end
)

mytimerPush:start()
mytimerRelease:start()
