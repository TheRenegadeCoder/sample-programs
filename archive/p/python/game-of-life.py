from Tkinter import *

root = Tk()
root.title("The Renegade Coder's Game of Life")
frame = Frame(root, width=720, height=720)
frame.pack()
canvas = Canvas(frame, width=720, height=720)
canvas.pack()

def grid():
    x = 10
    y = 10
    global grid # Variable to store the Cell objects
    global rectangles # Variable to store rectangles
    rectangles = []
    grid = []
    for i in range(70):
        grid.append([])
        rectangles.append([])
        for j in range(70):
            rect = canvas.create_rectangle(x, y, x+10, y+10, fill="white")
            rectangles[i].append(rect)
            grid[i].append(Cell(x, y, i, j))
            x += 10
        x = 10
        y += 10