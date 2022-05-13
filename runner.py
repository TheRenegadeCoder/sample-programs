from enum import Enum, auto
from glotter import main as glotter_main


class ProjectType(Enum):
    Baklava = auto()
    BinarySearch = auto()
    BubbleSort = auto()
    Capitalize = auto()
    ConvexHull = auto()
    DepthFirstSearch = auto()
    EvenOdd = auto()
    Factorial = auto()
    Fibonacci = auto()
    FileIO = auto()
    FizzBuzz = auto()
    FractionMath = auto()
    HelloWorld = auto()
    InsertionSort = auto()
    JobSequencing = auto()
    JosephusProblem = auto()
    LCS = auto()
    LongestWord = auto()
    LPS = auto()
    LinearSearch = auto()
    MaximumArrayRotation = auto()
    MaximumSubarray = auto()
    MergeSort = auto()
    MST = auto()
    PalindromicNumber = auto()
    PrimeNumber = auto()
    QuickSort = auto()
    Quine = auto()
    ROT13 = auto()
    RemoveAllWhiteSpace = auto()
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
