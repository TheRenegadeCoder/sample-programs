from random import randint


name = input('Write your name: ')

# A number will be chosen randomly between 0 and 100 by the computer
number = randint(0, 100)

print('\nWelcome to the Guessing Game,', name)
print("I'm your computer ... I just thought of a number between 0 and 100.")
print('Can you guess what it was?')

hit = False
attempt = 0

while not hit:
    # You will guess which number was selected
    guess = int(input("What's your guess? "))
    attempt += 1
    if guess == number:
        hit = True
    else:
        # At each attempt it will be shown whether the number entered is greater or less than the number chosen at random by the computer
        if guess < number:
            print('\033[31mMy thinking is bigger!')
        else:
            print('\033[34mMy thinking is less!')

# When you hit the number, a congratulations message will be printed on the screen
print(
    f'\n\033[0m{name}, you got it right with \033[32m{attempt}\033[0m attempts.\033[32m CONGRATULATIONS!!')
