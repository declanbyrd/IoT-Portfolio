sensorPin = 6
gpio.mode(sensorPin, gpio.INPUT)
sensorTimer = tmr.create()
sensorTimer:alarm(
  1000,
  tmr.ALARM_AUTO,
  function()
    if gpio.read(sensorPin) == 1 then
      print("Motion detected")
    else
      print("Motion not detected")
    end
  end
)
