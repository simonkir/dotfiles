function conky_hour()
    local currentTime = os.date("*t")
    local hour = string.format("%02d", currentTime.hour)
    return hour
end

function conky_minute()
    local currentTime = os.date("*t")
    local minute = string.format("%02d", currentTime.min)
    return minute
end

function conky_date()
    local currentTime = os.date("*t")

    local weekdays = {"sonntag", "montag", "dienstag", "mittwoch", "donnerstag", "freitag", "samstag"}
    local months = {"januar", "februar", "märz", "april", "mai", "juni", "juli", "august", "september", "oktober", "november", "dezember"}

    local weekday = weekdays[currentTime.wday]
    local day = string.format("%02d", currentTime.day)
    local month = months[currentTime.month]

    local currentDate = weekday .. ", " .. day .. ". " .. month
    return currentDate
end
