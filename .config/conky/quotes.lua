--[[
`quotes.csv' should be located within ~/.config/conky
    it should be formated as "AUTHOR","QUOTE"
    the AUTHOR field can be left blank
]]--

-- Load the CSV file into a table
function loadCSV(filename)
    local file = io.open(filename, "r")
    local lines = {}

    for line in file:lines() do
        local fields = {}
        for field in line:gmatch('"([^"]+)"') do
            table.insert(fields, field)
        end
        table.insert(lines, fields)
    end

    file:close()
    return lines
end

-- Choose a random line from the CSV file and return both fields as a string
function getRandomLineFromCSV(filename)
    local lines = loadCSV(filename)

    if #lines > 0 then
        -- generate the same quotes on both screens
        -- math.randomseed(os.date("%d") * os.date("%H") * os.date("%M"))
        local randomIndex = math.random(#lines)
        local fields = lines[randomIndex]
        local field1 = fields[1]
        local field2 = fields[2]

        if not field1 then
            field1 = ""
        end

        return field1:upper() .. "\n„" .. field2 .. "“"
    else
        return nil
    end
end

function conky_quote()
   return getRandomLineFromCSV(os.getenv("HOME") .. "/.config/conky/quotes.csv")
end
