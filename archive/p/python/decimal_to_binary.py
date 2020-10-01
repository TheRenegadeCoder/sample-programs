def decimalToBinary(number):
    if number > 1:
        decimalToBinary(number // 2)
    print(number % 2, end='')

if __name__ == '__main__':
    number = int(input("Enter decimal number: "))
    decimalToBinary(number)