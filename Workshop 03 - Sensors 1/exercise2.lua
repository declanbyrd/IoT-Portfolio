--[[
  Retrieve real time data from the sensor using a timer.
--]]
timer = tmr.create()
timer:alarm(
  1500,
  tmr.ALARM_AUTO,
  function()
    dhtPin = 2
    status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin)
    if status == dht.OK then
      print("DHT Temperature:" .. temp .. ";" .. "Humidity:" .. humi)
    elseif status == dht.ERROR_CHECKSUM then
      print("DHT Checksum error.")
    elseif status == dht.ERROR_TIMEOUT then
      print("DHT timed out.")
    end
  end
)
