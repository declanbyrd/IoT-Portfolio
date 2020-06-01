--[[
    use pwm and tmr to create traffic lights
--]]
redPin = 1
yellowPin = 2
greenPin = 3

pwm.setup(redPin, 500, 512)
pwm.setup(yellowPin, 500, 512)
pwm.setup(greenPin, 500, 512)

pwm.start(redPin)
pwm.start(yellowPin)
pwm.start(greenPin)

lightValues = {red = 0, yellow = 0, green = 0}
sequence = {"red", "yellow", "green", "yellow"}
intervals = {2000, 1000, 2000, 1000}
sequenceIndex = 0

function trafficLights(lightValues)
    for lightColour, brightness in pairs(lightValues) do
        print(lightColour, brightness)
    end
    pwm.setduty(1, lightValues.red)
    pwm.setduty(2, lightValues.yellow)
    pwm.setduty(3, lightValues.green)
end

function setLights(lightValues, intervals)
    sequenceIndex = sequenceIndex % #sequence + 1
    for lightColour, brightness in pairs(lightValues) do
        if lightColour == sequence[sequenceIndex] then
            lightValues[lightColour] = 512
        else
            lightValues[lightColour] = 0
        end
    end
    trafficTimer:interval(intervals[sequenceIndex] + 1)
    trafficLights(lightValues)
end

trafficTimer = tmr:create()

trafficTimer:alarm(
    2000,
    tmr.ALARM_AUTO,
    function()
        setLights(lightValues, intervals)
    end
)
