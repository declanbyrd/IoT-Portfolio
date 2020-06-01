local env = require "env"

wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = env.networkName
station_cfg.pwd = env.networkPassword
station_cfg.save = true
wifi.sta.config(station_cfg)

mytimer = tmr.create()
mytimer:register(
    500,
    1,
    function()
        print(wifi.sta.getip())

        cl = net.createConnection(net.TCP, 0)
        --create a TCP based not encryped client
        cl:on(
            "connection",
            function(conn, s)
                conn:send("Now in connection, hello Declan\n")
                mytimer:stop()
            end
        )

        cl:on(
            "disconnection",
            function(conn, s)
                print("Now we are disconnected\n")
            end
        )

        cl:on(
            "sent",
            function(conn, s)
                print("Message has been sent out\n")
            end
        )

        cl:on(
            "receive",
            function(conn, s)
                print("What we receive from the server\n" .. s .. "\n")
            end
        )

        cl:connect(2020, "192.168.8.129")
    end
)

mytimer:start()
