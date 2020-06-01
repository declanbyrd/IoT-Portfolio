local env = require "env"

wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = env.networkName
station_cfg.pwd = env.networkPassword
station_cfg.save = true
wifi.sta.config(station_cfg)

apiKey = env.openWeatherApiKey

url = "http://api.openweathermap.org/data/2.5/weather?q=Portsmouth,uk&units=metric&appid=" .. apiKey

tmsrv = "0.uk.pool.ntp.org"

function stampTime()
  sec, microsec, rate = rtctime.get()
  tm = rtctime.epoch2cal(sec, microsec, rate)
  print(
    string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])
  )
end

function getWeather()
  http.get(
    url,
    nil,
    function(code, data)
      if code ~= 200 then
        print("http request failed with status code " .. code)
      else
        print("http request suceeded with status code " .. code)
        dataTable = sjson.decode(data)
        print("The weather in " .. dataTable.name .. " is currently " .. dataTable.weather[1].description)
        print(
          "In " ..
            dataTable.name ..
              " it is currently " ..
                dataTable.main.temp .. " degrees but feels like " .. dataTable.main.feels_like .. " degrees"
        )
      end
    end
  )
end

function main()
  cron.schedule(
    "* * * * *",
    function(e)
      stampTime()
    end
  )
  cron.schedule(
    "*/5 * * * *",
    function(e)
      print(getWeather())
    end
  )
end

mytimer = tmr.create()

mytimer:register(
  5000,
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
          main()
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
