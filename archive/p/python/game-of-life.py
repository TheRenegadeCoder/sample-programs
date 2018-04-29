import random

class Cell:
    def __init__(self, is_alive: bool):
        self.was_alive = is_alive
        self.is_alive = is_alive
        self.neighbors = list()

    def num_of_living_neighbors() -> int:
        total_living_neighbors = 0
        for neighbor in self.neighbors:
            if neighbor.is_alive:
                total_living_neighbors += 1
        return total_living_neighbors

    def transition():
        total_living_neighbors = num_of_living_neighbors()
        if self.was_alive and total_living_neighbors < 2:
            self.is_alive = False
        elif self.was_alive and total_living_neighbors in {2, 3}:
            self.is_alive = True
        elif self.was_alive and total_living_neighbors > 3:
            self.is_alive = False
        elif not self.was_alive and total_living_neighbors == 3:
            self.is_alive = True

    def clear_state():
        self.was_alive = self.is_alive

class Grid:
    def __init__(self, width: int, spawn_rate: float):
        self.width = width
        self.spawn_rate = spawn_rate
        self.grid = None

    def _create_cell(self) -> Cell:
        return Cell(random.uniform(0, 1) < self.spawn_rate)

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

    def generate(self):
        self._populate()
        self._link()


def main():
    myGrid = Grid(10, .5)
    myGrid.generate()
    for row in myGrid.grid:
        for cell in row:
            if cell.is_alive:
                print("X", end="")
            else:
                print("O", end="")
        print()

if __name__ == '__main__':
    main()
