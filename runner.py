import os
from enum import Enum, auto
from glotter import main as glotter_main
from glotter import projects_enum, Settings


@projects_enum
class ProjectType(Enum):
    Baklava = auto()
    BubbleSort = auto()
    ConvexHull = auto()
    EvenOdd = auto()
    Factorial = auto()
    Fibonacci = auto()
    FileIO = auto()
    FizzBuzz = auto()
    HelloWorld = auto()
    InsertionSort = auto()
    JobSequencing = auto()
    LCS = auto()
    MergeSort = auto()
    MST = auto()
    Prime = auto()
    QuickSort = auto()
    Quine = auto()
    ROT13 = auto()
    ReverseString = auto()
    RomanNumeral = auto()
    SelectionSort = auto()


sorting_types = [
    ProjectType.BubbleSort,
    ProjectType.InsertionSort,
    ProjectType.MergeSort,
    ProjectType.QuickSort,
    ProjectType.SelectionSort,
]


def main():
    settings = Settings()
    glotter_main()


if __name__ == '__main__':
    main()
