--[[
    `quotes.csv' contains quotes in the format of ``"AUTHOR","QUOTE"''
    the file should be located in ~/.config/conky/
    the AUTHOR field can be left blank
]]--

-- load the csv file into a table
function loadCSV(filename)
    local file = io.open(filename, "r")
    local lines = {}

    for line in file:lines() do
        local fields = {}
        for field in line:gmatch('"([^"]*)"') do
            table.insert(fields, field)
        end
        table.insert(lines, fields)
    end

    file:close()
    return lines
end

-- choose a random line from the csv file and return a finished quote string
function getRandomQuoteFromCSV(filename)
    local lines = loadCSV(filename)

    -- calculate a set seed for rng
    --   – uses process id, date of month, month, year and hour to compute the seed
    --   – with this setup, multi-monitor compatibility is guaranteed by using PID
    local stat_file = io.open("/proc/self/stat")
    local stat_file_contents = stat_file:read("*a")
    stat_file:close()
    pid = stat_file_contents:match("(%d+)")
    math.randomseed(pid * os.date("%d%H") * os.date("%Y%m"))

    local fields

    repeat
        fields = lines[math.random(#lines)]
    until #fields[2] < 100

    return fields
end

function conky_quote()
    local quote = getRandomQuoteFromCSV(os.getenv("HOME") .. "/.config/conky/quotes.csv")
    local quoteAuthor = quote[1]
    local quoteText = quote[2]

    -- remove trailing full-stop from quoteText
    if string.sub(quoteText, -1) == "." then
        quoteText = string.sub(quoteText, 1, -2)
    end

    -- add anonymous author in case none is given
    if quoteAuthor == "" then
        quoteAuthor = "Anonymous"
    end

    return quoteAuthor:lower() .. ":\n~ " .. quoteText:lower()
end
