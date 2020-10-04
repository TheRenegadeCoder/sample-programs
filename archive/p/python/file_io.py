def write_file():

    try:
        with open("output.txt", "w") as out:
            out.write("Hi! I'm a line of text in this file!\n")
            out.write("Me, too!\n")
            
    except OSError as e:
        print("Cannot open file: {}", e)
        return


def read_file():
    
    try:
        with open("output.txt", "r") as in_file:
            for line in in_file:
                print(line.strip())
                
    except OSError as e:
        print("Cannot open file to read: {}", e)
        return


if __name__ == '__main__':
    write_file()
    read_file()
