function writer()
	file_to_be_written = io.open("output.txt","w+")
	io.write("text to be written into output.txt")
	io.close()
end


function reader()
	file_to_be_read = io.open("output.txt","r")
	io.input(file_to_be_read)
	print(io.read())
	io.close()
    end

writer()
reader()
