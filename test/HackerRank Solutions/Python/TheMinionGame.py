""" HackerRank python practise solution
Problem link:- https://www.hackerrank.com/challenges/the-minion-game/problem
"""


def minion_game(string):
    stuart, kevin = 0, 0
    for i in range(0, len(string)):
        if string[i] in "AEIOU":
            kevin += (len(string) - i)
        else:
            stuart += (len(string) - i)

    if stuart > kevin:
        print("Stuart", stuart)
    elif stuart < kevin:
        print("Kevin", kevin)
    else:

        print("Draw")