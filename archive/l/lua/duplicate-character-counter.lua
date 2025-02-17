function duplicateCharacterCounter(word)
    
    local testString = ""
    
    if (string.len(word) >= 1 ) then
        local myTable = {}
        
        for i=1, string.len(word) do
            local occur = 1;
            
            myTable[string.sub(word, i, i)] = occur;
            testString = testString .. " " .. myTable[String.sub(word, i, i)]
        end

        for key, value in pairs(myTable) do
            if (myTable[key] ~= 1) then
                -- print("KEY: " .. key .. " & VALUE: " .. value) --test case to see what it prints
                return print( KEY .. ": " .. VALUE)
            end
        end
        return testString
end

--duplicateCharacterCounter("") -- should print usage
duplicateCharacterCounter("hello") -- should print duplicates