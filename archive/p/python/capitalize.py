import sys

if __name__ == '__main__':
    if(len(sys.argv) == 1 or len(sys.argv[1]) == 0):
        print('Usage: please provide a string')
    else:
        input = sys.argv[1]
        if len(input) > 0:
            print(input.capitalize(sys.argv[1]))
