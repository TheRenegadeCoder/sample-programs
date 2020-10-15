local function ascii_base(s)
  return s:lower() == s and ('a'):byte() or ('A'):byte()
end

function caesar_cipher(str, key)
  return (str:gsub('%a', function(s)
    local base = ascii_base(s)
    return string.char(((s:byte() - base + key) % 26) + base)
  end))
end

if (#arg < 1 or arg[1] == "")
then
    print('Usage: please provide a string to encrypt')
else
    io.write(caesar_cipher(arg[1], 13))
end

io.write("\n")
