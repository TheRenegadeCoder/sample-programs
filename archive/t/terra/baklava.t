local function strRepeat(n, s)
    local r = ""
    for i = 1, n do
        r = r .. s
    end

    return r
end

local function baklava()
    for i = -10, 10 do
        local numSpaces = i
        if i < 0 then
            numSpaces = -numSpaces
        end

        print(strRepeat(numSpaces, " ") .. strRepeat(21 - 2 * numSpaces, "*"))
    end
end

baklava()
