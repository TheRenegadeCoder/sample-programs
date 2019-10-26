import sys

def capitalize(input):
    if len(input) > 0:
        print(input[0].capitalize() + input[1:])

if __name__ == '__main__':
    if(len(sys.argv) == 1):
        print('Usage: provide a string as the first command line argument')
    else:
        capitalize(sys.argv[1])
