local env = require "env"

HOST = "io.adafruit.com"
PORT = 1883

SUBSCRIBE_TOPIC = "declanbyrd/feeds/ledbrightness"

client = mqtt.Client("Client1", 300, env.adafruitUsername, env.adafruitPassword)

client:lwt("/lwt", "Now Offline", 1, 0)

client:on(
  "connect",
  function(client)
    print("Client connected to " .. HOST)
    client:subscribe(
      SUBSCRIBE_TOPIC,
      1,
      function(client)
        print("Subscribe sucessful")
      end
    )
    publishADC(client)
  end
)

client:on(
  "message",
  function(client, topic, data)
    print(topic .. ":")
    if data ~= nil then
      print(data)
      if topic == "declanbyrd/feeds/ledbrightness" then
        ledBrightnessHandler(data)
      end
    end
  end
)

client:on(
  "offline",
  function(client)
    print("Client offline")
  end
)

client:connect(
  HOST,
  PORT,
  false,
  false,
  function(conn)
  end,
  function(conn, reason)
    print("FAIL! Reason is " .. reason)
  end
)

pinLED = 1
pwm.setup(pinLED, 500, 0) -- 1000 is the rate of change.
pwm.start(pinLED)

function ledBrightnessHandler(data)
  pwm.setduty(pinLED, data)
end

pinADC = 0

function publishADC(client)
  adcPublish = tmr.create()
  adcPublish:register(
    2000,
    1,
    function()
      pinADC = 0
      voltage = adc.read(pinADC)
      client:publish(
        SUBSCRIBE_TOPIC,
        tostring(voltage),
        1,
        0,
        function(client)
          print("ADC reading sent: " .. voltage)
        end
      )
    end
  )
  adcPublish:start()
end
