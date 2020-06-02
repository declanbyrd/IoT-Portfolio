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
    3000,
    1,
    function()
        if wifi.sta.getip() == nil then
            print("Connecting to network...")
        else
            sntp.sync(
                tmsrv,
                function()
                    print("Sync success")
                    mytimer:stop()
                    cron.schedule(
                        "* * * * *",
                        function(e)
                            print("This function will be executed once every minute")
                        end
                    )

                    cron.schedule(
                        "*/5 * * * *",
                        function(e)
                            print("This function will execute once every 5 minutes")
                        end
                    )

                    cron.schedule(
                        "0 22 * * *",
                        function(e)
                            print("\n ALARM CLOCK \n IT IS 10PM \n")
                        end
                    )
                end,
                function()
                    print("Sync fail")
                end,
                1
            )
        end
    end
)

mytimer:start()
