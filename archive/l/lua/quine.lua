function reader()
	file_to_be_read = io.open("quine.lua","r")
	io.input(file_to_be_read)
	print(io.read("*all"))
	io.close()
    end
reader()