import {promises as fs} from 'fs'

# the fs.writeFile create a file if the file don't exist,otherwise it recreate the file.
write_file = (filename) ->
	line = 'this is a line\n'
	line += 'this is another line\n'
	try
		await fs.writeFile filename,line
		console.log 'file created'
	catch err
		console.log 'error in write file'
		throw err

# the fs.appendFile create a file if the file don't exist, otherwise it put data at the end of the file
append_file = (filename) ->
	line = 'this line was appended'
	try
		await fs.appendFile filename,line
		console.log 'file appended'
	catch err
		console.log 'error in append file'
		throw err

# the fs.readFile read a file and store it as return value
read_file = (filename) ->
	console.log("reading the #{filename} ...")
	try
		data = await fs.readFile filename,'utf-8'
		console.log(data)
	catch err
		console.log 'error in read file'
		throw err

main = () ->
	filename = 'output.txt'
	await write_file filename
	await read_file filename
	await append_file filename
	await read_file filename

main()