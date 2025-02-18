function duplicateCharacterCounter(word)
  local hasDuplicates = false;

  if word == "" or word == nil then 
    print("Usage: please provide a string")
    return
  elseif (string.len(word) >= 1) then
    local myTable = {}
    local duplicateList = {}
    
    for i=1, string.len(word) do
      local char = string.sub(word, i, i)
      if not (myTable[char]) then
        myTable[char] = 1;
      else
        myTable[char] = myTable[char]+1;
        hasDuplicates = true;
      end
    end
    
    for key, value in pairs(myTable) do
      if (myTable[key] ~= 1) then
        table.insert(duplicateList, key .. ": " .. value)
      end
    end
    
    table.sort(duplicateList)

    for k=1, #duplicateList do
      print(duplicateList[k])
    end
  end

  if not (hasDuplicates) then
    print("No duplicate characters")
  end
end

duplicateCharacterCounter(arg[1])