--[[
    Read sensor data and illuminate LED on button press
--]]
buttonPin = 7
dhtPin = 2
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
            status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin)
            if status == dht.OK then
                print("DHT Temperature:" .. temp .. ";" .. "Humidity:" .. humi)
            elseif status == dht.ERROR_CHECKSUM then
                print("DHT Checksum error.")
            elseif status == dht.ERROR_TIMEOUT then
                print("DHT timed out.")
            end
        elseif (gpio.read(buttonPin) == 0 and pushed == 1) then
            pushed = 0
        end
    end
)

mytimer:start()
