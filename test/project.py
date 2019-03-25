from enum import Enum, auto


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
    ProjectType.SelectionSort
]

