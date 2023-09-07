function conky_hour()
    return os.date("%H")
end

function conky_minute()
    return os.date("%M")
end

function conky_date()
    local weekday = os.date("%A")
    local day = os.date("%d")
    local month = os.date("%B")

    local currentDate = weekday .. ", " .. day .. ". " .. month
    return currentDate
end
