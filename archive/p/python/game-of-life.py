class Cell:
    def __init__(is_alive: bool):
        self.isAlive = isAlive

class Grid:
    def __init__(width: int, spawn_rate: float):
        self.width = width
        self.spawn_rate = spawn_rate
