local env = require "env"

wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = env.networkName
station_cfg.pwd = env.networkPassword
station_cfg.save = true
wifi.sta.config(station_cfg)

tmsrv = "0.uk.pool.ntp.org"

function stampTime()
    sec, microsec, rate = rtctime.get()
    tm = rtctime.epoch2cal(sec, microsec, rate)
    print(
        string.format(
            "%04d/%02d/%02d %02d:%02d:%02d",
            tm["year"],
            tm["mon"],
            tm["day"],
            tm["hour"],
            tm["min"],
            tm["sec"]
        )
    )
end

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
                    stampTime()
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
