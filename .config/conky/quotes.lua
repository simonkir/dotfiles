--[[
    `quotes.csv' contains quotes in the format of "AUTHOR","QUOTE"
    the file should be located in ~/.config/conky/
    the AUTHOR field can be left blank, i. e. ""
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

    -- read random quote
    local quoteAuthor = ""
    local quoteText = ""

    repeat
        local fields = lines[math.random(#lines)]
        quoteAuthor = fields[1]
        quoteText = fields[2]
    until #quoteText < 100

    -- formatting the result
    if quoteAuthor == "" then
        quoteAuthor = "Unknown Author"
    end

    return quoteAuthor:upper() .. "\n„" .. quoteText .. "“"
end

function conky_quote()
    return getRandomQuoteFromCSV(os.getenv("HOME") .. "/.config/conky/quotes.csv")
end
