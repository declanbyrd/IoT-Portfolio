local env = require "env"

wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = env.networkName
station_cfg.pwd = env.networkPassword
station_cfg.save = true
wifi.sta.config(station_cfg)

srv = net.createServer(net.TCP, 30)

mytimer = tmr.create()
mytimer:register(
    500,
    1,
    function()
        print(wifi.sta.getip())
        if wifi.sta.status() == wifi.STA_GOTIP then
            --TCP, 30s for an inactive client to be disconnected
            --try srv = net.createServer(net.UDP,10)
            srv:listen(
                2021,
                function(conn)
                    conn:send("Send to all clients who connect to Port 80, hello world! \n")
                    conn:on(
                        "receive",
                        function(conn, s)
                            print(s)
                            conn:send(s)
                        end
                    )
                    conn:on(
                        "connection",
                        function(conn, s)
                            conn:send("Now in connection Server\n")
                        end
                    )
                    conn:on(
                        "disconnection",
                        function(conn, s)
                            print("Now we are disconnected\n")
                        end
                    )
                    conn:on(
                        "sent",
                        function(conn, s)
                            print("Message has been sent out from the Server\n")
                        end
                    )
                    conn:on(
                        "receive",
                        function(conn, s)
                            print("What we receive from the Client\n" .. s .. "\n")
                            controlLight(s)
                        end
                    )
                end
            )
            mytimer:stop()
        end
    end
)

mytimer:start()

function controlLight(state)
    ledPin = 2
    gpio.mode(ledPin, gpio.OUTPUT)
    if state == "on" then
        gpio.write(ledPin, gpio.HIGH)
    elseif state == "off" then
        gpio.write(ledPin, gpio.LOW)
    else
        print("Not a valid control")
    end
end
