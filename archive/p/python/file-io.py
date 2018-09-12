def write_file():

    try:
        out = open("output.txt", "w")
    except OSError as e:
        print("Cannot open file: {}", e)


    out.write("Hi! I'm a line of text in this file!\n")
    out.write("Me, too!\n")

    out.flush()
    out.close()

def read_file():
    
    try:
        in_file = open("file.txt", "r")
    except OSError as e:
        print("Cannot open file to read: {}", e)
    
    line = in_file.readline()
    while line:
        print(line.rstrip('\n'))
        line = in_file.readline()
    
    in_file.close()

if __name__ == '__main__':
    write_file()
    read_file()
