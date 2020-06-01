local env = require "env"

wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = env.networkName
station_cfg.pwd = env.networkPassword
station_cfg.save = true
wifi.sta.config(station_cfg)

function post()
  http.post(
    "http://httpbin.org/post",
    "Content-Type: application/json\r\n",
    '{"IoT":"2020","This is":"Json Format","Please check":' .. '"How the data are shaped"}',
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

function put()
  http.put(
    "http://httpbin.org/put",
    "Content-Type: text/plain\r\n",
    "IoT 2020 plain text, please check how the data are formatted",
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

function delete()
  http.delete(
    "http://httpbin.org/delete",
    "",
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
      post()
      --put()
      --delete()
      getOnlineTimer:stop()
    end
  end
)

getOnlineTimer:start()
