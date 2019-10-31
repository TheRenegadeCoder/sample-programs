function writer()
	file_to_be_written = io.open("myfile.txt","w+")
	io.write("text to be written into myfile.txt")
	io.close()
end


function reader()
	file_to_be_read = io.open("myfile.txt","r")
	io.input(file_to_be_read)
	print(io.read())
	io.close()
    end

writer()
reader()
