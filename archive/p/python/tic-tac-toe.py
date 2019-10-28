board = [' ' for x in range(10)]

def insertLetter(letter, pos):
    board[pos] = letter

def spaceIsFree(pos):
    return board[pos] == ' '

def printBoard(board):
    print(' ' + board[1] + ' | ' + board[2] + ' | ' + board[3])
    print('-----------')
    print(' ' + board[4] + ' | ' + board[5] + ' | ' + board[6])
    print('-----------')
    print(' ' + board[7] + ' | ' + board[8] + ' | ' + board[9])
    
def isWinner(b,l):
    return (b[7] == l and b[8] == l and b[9] == l) or(b[4] == l and b[5] == l and b[6] == l) or(b[1] == l and b[2] == l and b[3] == l) or(b[1] == l and b[4] == l and b[7] == l) or(b[2] == l and b[5] == l and b[8] == l) or(b[3] == l and b[6] == l and b[9] == l) or(b[1] == l and b[5] == l and b[9] == l) or(b[3] == l and b[5] == l and b[7] == l)

def playerMove():
    run = True
    while run:
        move = input("Please select a position to place an x (1-9): ")
        try:
            move = int(move)
            if move>0 and move<10 :
                if spaceIsFree(move):
                    run = False
                    insertLetter('x',move)
                else:
                    print("Sorry, this space is occupied! Try again.")
            else:
                print("Please type a number from 1 to 9!")
        except:
            print("Please type a number!")


def compMove():
    possibleMoves = [x for x, letter in enumerate(board) if letter==' ' and x!=0 ]
    move = 0

    for letter in ['o','x']:
        for i in possibleMoves:
            boardCopy = board[:]
            boardCopy[i] = letter
            if isWinner(boardCopy, letter):
                move = i
                return move
            
    cornersOpen = []
    for i in possibleMoves:
        if i in[1,3,7,9]:
            cornersOpen.append(i)
    if len(cornersOpen) > 0:
        move = selectRandom(cornersOpen)
        return move

    if 5 in possibleMoves:
        move = 5
        return move

    edgesOpen = []
    for i in possibleMoves:
        if i in[2,4,6,8]:
            edgesOpen.append(i)
    if len(edgesOpen) > 0:
        move = selectRandom(edgesOpen)

    return move

      

def selectRandom(lst):
    import random
    length = len(lst)
    r = random.randrange(0,length)
    return lst[r]
    


def isBoardFull(board):
    if board.count(' ')>1:
        return False
    else:
        return True


def main():
    print("Welcome to TIC TAC TOE!")
    print(' 1' + board[1] + '| 2' + board[2] + '| 3 ' + board[3])
    print('-----------')
    print(' 4' + board[4] + '| 5' + board[5] + '| 6 ' + board[6])
    print('-----------')
    print(' 7' + board[7] + '| 8' + board[8] + '| 9 ' + board[9])
    #printBoard(board)

    while not(isBoardFull(board)):
        if not(isWinner(board,'o')):
            playerMove()
            printBoard(board)

        else:
            print("Sorry, you lost!")
            break

        if not(isWinner(board,'x')):
            move=compMove()
            if move == 0:
                print("It's a Tie!")
                
                        
            else:
                insertLetter('o',move)
                print("Computer placed an 'o' in position",move,":")
                printBoard(board)

        else:
            print("Congratulations! You won!")
            break
        

    if isBoardFull(board):
        print("It's a Tie!")


 
main()
