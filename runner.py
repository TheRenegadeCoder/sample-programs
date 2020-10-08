from enum import Enum, auto
from glotter import main as glotter_main


class ProjectType(Enum):
    Baklava = auto()
    BinarySearch = auto()
    BubbleSort = auto()
    Capitalize = auto()
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
    LinearSearch = auto()
    MergeSort = auto()
    MST = auto()
    PalindromicNumber = auto()
    Prime = auto()
    QuickSort = auto()
    Quine = auto()
    ROT13 = auto()
    ReverseString = auto()
    RomanNumeral = auto()
    SelectionSort = auto()
    SleepSort = auto()

    @property
    def key(self):
        return self.name.lower()


def main():
    glotter_main()


if __name__ == '__main__':
    main()
