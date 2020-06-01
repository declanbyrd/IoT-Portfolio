local env = require "env"

wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = env.networkName
station_cfg.pwd = env.networkPassword
station_cfg.save = true
wifi.sta.config(station_cfg)

getOnlineTimer = tmr.create()
getOnlineTimer:register(
    3000,
    1,
    function()
        if wifi.sta.getip() == nil then
            print("Connecting to access point...\n")
        else
            ip = wifi.sta.getip()
            print("Connected, " .. ip)
            getOnlineTimer:stop()
        end
    end
)

getOnlineTimer:start()

dhtPin = 2
srv = net.createServer(net.TCP, 0)
srv:listen(
    80,
    function(conn)
        conn:on(
            "receive",
            function(conn, req)
                local status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin)
                local buf = ""
                if status == dht.OK then
                    print("DHT Temperature:" .. temp .. " Humidity:" .. humi .. "\n")
                end
                buf = buf .. "<html>"
                buf = buf .. '<head> <title>DHT11 LAN update</title> <meta http-equiv="refresh" content="3"> </head>'
                buf = buf .. "<body><p>Temperature: " .. temp .. "." .. temp_dec .. "C</p>"
                buf = buf .. "<p>Humidity: " .. humi .. "." .. humi_dec .. "%RH</p>"
                buf = buf .. "<p>Did you spot any limitation here ? And can you improve it ?" .. "</p></body></html>"
                conn:send(buf)

                conn:on(
                    "sent",
                    function(conn)
                        conn:close()
                    end
                )
            end
        )
    end
)
