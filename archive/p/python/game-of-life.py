import random

class Cell:
    def __init__(is_alive: bool):
        self.wasAlive = is_alive
        self.isAlive = is_alive
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
    def __init__(width: int, spawn_rate: float):
        self.width = width
        self.spawn_rate = spawn_rate
        self.grid = None

    def create_cell() -> Cell:
        return Cell(random.uniform(0, 1) < self.spawn_rate)

    def _populate():
        self.grid = [[create_cell() for _ in range(self.width)] for _ in range(self.width)]
