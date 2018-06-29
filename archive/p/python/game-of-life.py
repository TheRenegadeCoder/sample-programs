from Tkinter import *

root = Tk()
root.title("The Renegade Coder's Game of Life")
frame = Frame(root, width=720, height=720)
frame.pack()
canvas = Canvas(frame, width=720, height=720)
canvas.pack()

def create_grid():
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

  def rectangle_coordinates(x, y):
  	return (x- x%10, y - y%10)

  def click_colour_change(event):
    print event.x, event.y
    x, y = rectangle_coordinates(event.x, event.y)
    try:
        iy = x / 10 - 1
        ix = y / 10 - 1
        if ix == -1 or iy == -1:
            raise IndexError
        if grid[ix][iy].isAlive:
            canvas.itemconfig(rectangles[ix][iy], fill="black")
        else:
            canvas.itemconfig(rectangles[ix][iy], fill="white")
        grid[ix][iy].switchStatus()
        print grid[ix][iy].pos_matrix, grid[ix][iy].pos_screen
    except IndexError:
        return

  def paint_grid:
  	for i in grid:
        for j in i:
            if j.nextStatus != j.isAlive:
                x, y = j.pos_matrix
                print x, y
                if j.nextStatus:
                    canvas.itemconfig(rectangles[x][y], fill="white")
                    print "changed", j.pos_matrix, "from dead to alive"
                else:
                    canvas.itemconfig(rectangles[x][y], fill="black")
                    print "changed", j.pos_matrix, "from alive to dead"
                j.switchStatus()
                print "Current status of", j.pos_matrix, j.isAlive

  def status_update(cell):
    num_alive = 0
    x, y = cell.pos_matrix
    for i in (x-1, x, x+1):
        for j in (y-1, y, y+1):
            if i == x and j == y:
                continue
            if i == -1 or j == -1:
                continue
            try:
                if grid[i][j].isAlive:
                    num_alive += 1
            except IndexError:
                pass
    if cell.isAlive:
        return not( num_alive == 2 or num_alive == 3 )
    else:
        return num_alive == 3

  def start_game():
    for i in grid:
        for j in i:
            if status_update(j):
                j.nextStatus = not j.isAlive
                print "change in", j.pos_matrix, "from", j.isAlive, "to", j.nextStatus
            else:
                j.nextStatus = j.isAlive
    paint_grid()
    global game_id
    game_id = root.after(200, start_game)

  def end_game():
    root.after_cancel(begin_id)







