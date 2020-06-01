local env = require "env"

HOST = "io.adafruit.com"
PORT = 1883

SUBSCRIBE_TOPIC = "declanbyrd/feeds/togglebutton"

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
    end
)

client:on(
    "message",
    function(client, topic, data)
        print(topic .. ":")
        if data ~= nil then
            print(data)
            if topic == "declanbyrd/feeds/togglebutton" then
                ledStateHandler(data)
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

function ledStateHandler(data)
    if data == "ON" then
        gpio.write(pinLED, 1)
    else
        gpio.write(pinLED, 0)
    end
end
