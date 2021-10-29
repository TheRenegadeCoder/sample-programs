# Homework 3
# Will Kemp
# July 10th, 2020
# This program plays rock paper scissors against the input of the user.

#import random module
import random

#Intro and Win conditions for user
print('Welcome to Scissors, Paper, Rock\n' + 'The Rules:\n' + '-Scissors beats Paper\n' + '-Paper beats Rock\n' + '-Rock beats Scissors\n')

#while loop to make game replayable
while True:

    #set userValue initial value to force user input while loop
    userValue = 31

    #Get user input and make sure its valid
    while (userValue > 2 or userValue < 0) :
        userValue = eval(input('Scissors (0)\nPaper (1)\nRock (2)\n' + 'Make your choice:\n'))
        #Warn user of value being outside accepted range.
        if userValue > 2 or userValue < 0 :
            print('Please make sure your selection is 0, 1, or 2\nCurrent choice value:' + str(userValue) )

    #Generate Computer Choice value
    compValue = random.randint(0,2)

    #Set Choice output variable for computer
    if compValue == 0 :
        compChoice = "Scissors"
    elif compValue == 1 :
        compChoice = "Paper"
    elif compValue == 2 :
        compChoice = "Rock"
        
    #Set Choice output variable for user
    if userValue == 0 :
        userChoice = "Scissors"
    elif userValue == 1 :
        userChoice = "Paper"
    elif userValue == 2 :
        userChoice = "Rock"
        
    #Win Conditions check userValue against compValue
    if userValue == compValue :
        winner = 'It is a draw'
    elif (userValue == 0) and (compValue == 1) : 
        winner = 'You win!'
    elif (userValue == 1) and (compValue == 2) : 
        winner = 'You win!'
    elif (userValue == 2) and (compValue == 0) : 
        winner = 'You win!'
    elif (userValue == 0) and (compValue == 2) :
        winner = 'Computer wins.'
    elif (userValue == 1) and (compValue == 0) :
        winner = 'Computer wins.'
    elif (userValue == 2) and (compValue == 1) :
        winner = 'Computer wins.'
        
    print('The Computer chose ' + compChoice +'.\nYou chose ' + userChoice + '.\n' + winner)

    #Set replay vairable to initiate replay while loop. Ask for replay choice
    replay = ''
    while ((replay.upper() != 'Y') and (replay.upper() != 'N')) :
        replay = input('Would you like to play again? Yes (Y) or No(N):\n')
        
    #If user selects No, break loop and exit. Otherwise loop continues and restarts game
    if ((replay == 'n') or (replay == 'N')) :
        break

    