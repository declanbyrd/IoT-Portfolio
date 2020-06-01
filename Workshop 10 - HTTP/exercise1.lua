local env = require "env"

wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = env.networkName
station_cfg.pwd = env.networkPassword
station_cfg.save = true
wifi.sta.config(station_cfg)

function crawl()
  url = "http://httpbin.org/ip"
  print(url)
  headers = {
    ["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36"
  }
  http.request(
    url,
    "GET",
    headers,
    "",
    function(code, data)
      if (code < 0) then
        print("HTTP request failed")
        print(code)
      else
        print(code, data)
      end
    end
  )
end

getOnlineTimer = tmr.create()
getOnlineTimer:register(
  3000,
  1,
  function()
    if wifi.sta.getip() == nil then
      print("Connecting to access point...\n")
    else
      crawl()
      getOnlineTimer:stop()
    end
  end
)

getOnlineTimer:start()
