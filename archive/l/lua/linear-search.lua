
local args = {...}

local nums_str = args[1]

local key = tonumber(args[2])

local numbers = {}

local found = false

    if #args ~= 2 then
        print('Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")')
        return
    end
    
    if not key then

        print('Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")')
        return
    end

    if #nums_str < 1 then
          print('Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")')
        return
    end

for num in string.gmatch(nums_str, '([^,]+)') do
    table.insert(numbers, tonumber(num))
end




for i = 1, #numbers do

    if numbers[i] == key then
        found = true

      break
    end
end

print(found and "true" or "false")
