local env = require "env"

wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = env.networkName
station_cfg.pwd = env.networkPassword
station_cfg.save = true
wifi.sta.config(station_cfg)

srv = net.createServer(net.TCP, 300)

srv:listen(
    2020,
    function(conn)
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
                conn:send("Now in connection, hello Dalin from Server\n")
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
                print("What we receive from theClient\n" .. s .. "\n")
            end
        )
    end
)
