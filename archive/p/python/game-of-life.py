class Cell:
    def __init__(is_alive: bool):
        self.isAlive = isAlive
        self.neighbors = list()

    def num_of_living_neighbors():
        total_living_neighbors = 0
        for neighbor in self.neighbors:
            if neighbor.is_alive:
                total_living_neighbors += 1
        return total_living_neighbors

class Grid:
    def __init__(width: int, spawn_rate: float):
        self.width = width
        self.spawn_rate = spawn_rate
