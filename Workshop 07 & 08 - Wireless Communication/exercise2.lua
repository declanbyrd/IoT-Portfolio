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
