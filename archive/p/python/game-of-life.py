import random
from tkinter import *

class Cell(Frame):
    def __init__(self, is_alive: bool, parent):
        Frame.__init__(self, parent, width=10, height=10)
        self.was_alive = is_alive
        self.is_alive = is_alive
        self.neighbors = list()
        self.configure(bg=self.get_background_color())

    def get_background_color(self) -> str:
        if self.is_alive:
            return 'black'
        else:
            return 'white'

    def num_of_living_neighbors(self) -> int:
        total_living_neighbors = 0
        for neighbor in self.neighbors:
            if neighbor.is_alive:
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
    def __init__(self, width: int, spawn_rate: float):
        Tk.__init__(self)
        self.width = width
        self.spawn_rate = spawn_rate
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

    def step(self):
        for row in self.grid:
            for cell in row:
                cell.transition()
                cell.configure(bg=cell.get_background_color())
        for row in self.grid:
            for cell in row:
                cell.clear_state()
        self.after(1000, self.step)


def main():
    myGrid = Grid(50, .15)
    myGrid.generate()
    myGrid.after(1000, myGrid.step)
    myGrid.mainloop()

if __name__ == '__main__':
    main()
