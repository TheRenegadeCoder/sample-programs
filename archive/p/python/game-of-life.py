import random
import sys
from tkinter import *

class Cell(Frame):
    def __init__(self, is_alive: bool, parent):
        Frame.__init__(self, parent, width=10, height=10)
        self.was_alive = is_alive
        self.is_alive = is_alive
        self.neighbors = list()
        self['bg'] = self.get_background_color()

    def get_background_color(self) -> str:
        if self.is_alive:
            return 'black'
        else:
            return 'white'

    def num_of_living_neighbors(self) -> int:
        total_living_neighbors = 0
        for neighbor in self.neighbors:
            if neighbor.was_alive:
                total_living_neighbors += 1
        return total_living_neighbors

    def transition(self):
        total_living_neighbors = self.num_of_living_neighbors()
        if self.was_alive and total_living_neighbors < 2:
            self.is_alive = False
        elif self.was_alive and total_living_neighbors in {2, 3}:
            self.is_alive = True
        elif self.was_alive and total_living_neighbors > 3:
            self.is_alive = False
        elif not self.was_alive and total_living_neighbors == 3:
            self.is_alive = True

    def clear_state(self):
        self.was_alive = self.is_alive

class Grid(Tk):
    def __init__(self, width: int = 50, spawn_rate: float = .15, frame_rate: float = 3, total_frames: int = 200):
        Tk.__init__(self)
        self.title("The Renegade Coder's Game of Life")
        self.width = width
        self.spawn_rate = spawn_rate
        self.frame_rate = frame_rate
        self.delay = int(1000 / self.frame_rate)
        self.total_frames = total_frames
        self.frame_index = 0
        self.grid = None

    def _create_cell(self) -> Cell:
        return Cell(random.uniform(0, 1) < self.spawn_rate, self)

    def _populate(self):
        self.grid = [[self._create_cell() for _ in range(self.width)] for _ in range(self.width)]

    def _link(self):
        for curr_row, row_list in enumerate(self.grid):
            previous_row = (curr_row - 1) % self.width
            next_row = (curr_row + 1) % self.width
            for curr_col, cell in enumerate(row_list):
                previous_col = (curr_col - 1) % self.width
                next_col = (curr_col + 1) % self.width
                cell.neighbors.append(self.grid[curr_row][previous_col])
                cell.neighbors.append(self.grid[curr_row][next_col])
                cell.neighbors.append(self.grid[previous_row][curr_col])
                cell.neighbors.append(self.grid[next_row][curr_col])
                cell.neighbors.append(self.grid[previous_row][previous_col])
                cell.neighbors.append(self.grid[next_row][next_col])
                cell.neighbors.append(self.grid[previous_row][next_col])
                cell.neighbors.append(self.grid[next_row][previous_col])
                cell.grid(column=curr_col, row=curr_row)

    def generate(self):
        self._populate()
        self._link()
        self.after(self.delay, self.step)

    def step(self):
        for row in self.grid:
            for cell in row:
                cell.transition()
                cell['bg'] = cell.get_background_color()
        for row in self.grid:
            for cell in row:
                cell.clear_state()
        self.frame_index += 1
        if self.frame_index < self.total_frames:
            self.after(self.delay, self.step)


def main():
    if len(sys.argv) > 4:
        width = int(sys.argv[1])
        frame_rate = float(sys.argv[2])
        total_frames = int(sys.argv[3])
        spawn_rate = float(sys.argv[4])
        myGrid = Grid(width, spawn_rate, frame_rate, total_frames)
    else:
        myGrid = Grid()
    myGrid.generate()
    myGrid.mainloop()

if __name__ == '__main__':
    main()
