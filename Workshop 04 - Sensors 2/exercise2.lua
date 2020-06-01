adcPin = 0
pinDim = 3

dc = 1023 --duty cycle

pwm.setup(pinDim, 500, dc) -- 500 is the rate of change.
pwm.start(pinDim)
pwmTimer = tmr.create()
pwmTimer:alarm(
  100,
  tmr.ALARM_AUTO,
  function()
    lightLevel = adc.read(adcPin)
    brightness = dc - lightLevel
    print(lightLevel)
    pwm.setduty(pinDim, brightness)
  end
)
