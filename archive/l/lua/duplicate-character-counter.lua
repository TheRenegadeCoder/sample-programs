function duplicateCharacterCounter(word)
  local hasDuplicates = false;

  -- Empty or no input validation
  if word == "" or word == nil then 
    print("Usage: please provide a string")
    return

  -- Check for duplicates validation
  elseif (string.len(word) >= 1) then
    local myTable = {}
    local duplicateList = {}
    
    for i=1, string.len(word) do
      local char = string.sub(word, i, i)
      if (myTable[char]) then
        myTable[char] = myTable[char]+1
        hasDuplicates = true

      else
        myTable[char] = 1;
        table.insert(duplicateList, char)
      end
    end
    for _, char in ipairs(duplicateList) do
        if myTable[char] > 1 then
            print(char .. ": " .. myTable[char])
        end
    end
  end

  -- No duplicates validation
  if not (hasDuplicates) then
    print("No duplicate characters")
  end
end

duplicateCharacterCounter(arg[1])