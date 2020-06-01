local env = require "env"

wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = env.networkName
station_cfg.pwd = e.v.networkPassword
station_cfg.save = true
wifi.sta.config(station_cfg)
