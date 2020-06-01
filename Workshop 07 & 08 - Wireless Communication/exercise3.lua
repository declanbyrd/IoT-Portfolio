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
