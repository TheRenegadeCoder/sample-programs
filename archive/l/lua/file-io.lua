function writer()
	file_to_be_written = io.open("output.txt","w+")
	io.output(file_to_be_written)
	io.write("text to be written into output.txt")
	io.close(file_to_be_written)
end


function reader()
	file_to_be_read = io.open("output.txt","r")
	io.input(file_to_be_read)
	print(io.read())
	io.close(file_to_be_read)
end

writer()
reader()
