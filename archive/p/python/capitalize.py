import sys

def capitalize(input):
    if(isinstance(input, str)):
        print(input.capitalize())
    else:
        print('Input is not a string')

if(__name__ == '__main__'):
    if(len(sys.argv) == 1):
        print('Usage: provide a string as the first command line argument')
    else:
        capitalize(sys.argv[1]) #most arguments from argv will be treated as a string
