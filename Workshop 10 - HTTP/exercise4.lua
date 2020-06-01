local env = require "env"

wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = env.networkName
station_cfg.pwd = env.networkPassword
station_cfg.save = true
wifi.sta.config(station_cfg)

pinLed = 4
gpio.mode(pinLed, gpio.OUTPUT)
svr = net.createServer(net.TCP)

function htmlUpdate(socket, flag)
  html = "<html>\r\n<head>\r\n<title>LED LAN Control</title>\r\n</head>\r\n"
  html =
    html ..
    '<body>\r\n<h1>LED</h1>\r\n<p>Click the button below to switch LED on  and off.</p>\r\n<form method="get">\r\n'
  if flag then
    strButton = "LED_OFF"
  else
    strButton = "LED_ON"
  end
  html =
    html ..
    '<input type="button" value="' .. strButton .. '" onclick="window.location.href=\'/' .. strButton .. '\'">\r\n'
  html = html .. "</form>\r\n</body>\r\n</html>\r\n"
  socket:send(html)
end

function setMode(socket, data)
  print(data)

  if string.find(data, "GET /LED_ON") then
    htmlUpdate(socket, true)
    gpio.write(pinLed, gpio.HIGH)
  elseif string.find(data, "GET / ") or string.find(data, "GET /LED_OFF") then
    htmlUpdate(socket, false)
    gpio.write(pinLed, gpio.LOW)
  else
    socket:send("<h2>Error, no matched string has been found!</h2>")
    socket:on(
      "sent",
      function(conn)
        conn:close()
      end
    )
  end
end

getOnlineTimer = tmr.create()
getOnlineTimer:register(
  3000,
  1,
  function()
    if wifi.sta.getip() == nil then
      print("Connecting to access point...\n")
    else
      print(wifi.sta.getip())
      if svr then
        svr:listen(
          80,
          function(conn)
            conn:on("receive", setMode)
          end
        )
      end
      getOnlineTimer:stop()
    end
  end
)

getOnlineTimer:start()
