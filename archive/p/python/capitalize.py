import sys

def capitalize(input):
    if(isinstance(input, str)):
        print(input.capitalize())
    else:
        print('Input is not a string')

if(__name__ == '__main__'):
    capitalize(sys.argv[1]) #most arguments from argv will be treated as a string
