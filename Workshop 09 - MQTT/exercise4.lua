local env = require "env"

HOST = "io.adafruit.com"
PORT = 1883

TOPIC = "declanbyrd/feeds/variableresistor"

client = mqtt.Client("Client1", 300, env.adafruitUsername, env.adafruitPassword)

client:lwt("/lwt", "Now Offline", 1, 0)

client:on(
    "connect",
    function(client)
        print("Client connected to " .. HOST)
        client:subscribe(
            TOPIC,
            1,
            function(client)
                print("Subscribe sucessful")
                publishADC(client)
            end
        )
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
                TOPIC,
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
