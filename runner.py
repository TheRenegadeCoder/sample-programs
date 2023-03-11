from enum import Enum, auto
from glotter import main as glotter_main


class ProjectType(Enum):
    Placeholder = auto()

    @property
    def key(self):
        return self.name.lower()


def main():
    glotter_main()


if __name__ == '__main__':
    main()
