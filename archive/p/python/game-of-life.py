from Tkinter import *

root = Tk()
root.title("The Renegade Coder's Game of Life")
frame = Frame(root, width=720, height=720)
frame.pack()
canvas = Canvas(frame, width=720, height=720)
canvas.pack()