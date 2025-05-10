-- Script for displaying "Days since accident:"
-- Uses in-game day count via os.day()

-- Display message
local message = "Days since accident: "

-- Monitor setup
local monitor = peripheral.find("monitor")
if not monitor then
    print("Error: No monitor found!")
    return
end

-- Check if the start time exists, if not create it
function getStartTime()
    if fs.exists(".starttime") then
        local file = fs.open(".starttime", "r")
        if file then
            local startTime = tonumber(file.readLine())
            file.close()
            if startTime then
                return startTime
            else
                print("Error: File is empty or corrupted.")
                return os.day()
            end
        else
            print("Error: Failed to open file for reading.")
            return os.day()
        end
    end

    -- Create the start time if it does not exist
    local startTime = os.day()
    local file = fs.open(".starttime", "w")
    if file then
        file.write(tostring(startTime))
        file.close()
        return startTime
    else
        print("Error: Unable to write start time to file.")
        return os.day()
    end
end

-- Calculate the number of days since the accident
function calculateDays(startTime)
    local currentDay = os.day()  -- Get the current in-game day
    local days = currentDay - startTime  -- Difference in days

    -- Ensure the difference is not negative
    if days < 0 then
        days = 0
    end

    return days
end

-- Display the number of days on the monitor
function updat
