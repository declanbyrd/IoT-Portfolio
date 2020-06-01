local env = require "env"

wifi.setmode(wifi.SOFTAP)
ap_cfg = {}
ap_cfg.ssid = env.networkName
ap_cfg.pwd = env.networkPassword
wifi.ap.config(ap_cfg)
