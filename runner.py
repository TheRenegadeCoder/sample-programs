from enum import Enum, auto
from glotter import main as glotter_main


class ProjectType(Enum):
    Baklava = auto()
    BinarySearch = auto()
    BubbleSort = auto()
    Capitalize = auto()
    ConvexHull = auto()
    DepthFirstSearch = auto()
    Dijkstra = auto()
    DuplicateCharacterCounter = auto()
    EvenOdd = auto()
    Factorial = auto()
    Fibonacci = auto()
    FileInputOutput = auto()
    FizzBuzz = auto()
    FractionMath = auto()
    HelloWorld = auto()
    InsertionSort = auto()
    JobSequencing = auto()
    JosephusProblem = auto()
    LinearSearch = auto()
    LongestCommonSubsequence = auto()
    LongestPalindromicSubstring = auto()
    LongestWord = auto()
    MaximumArrayRotation = auto()
    MaximumSubarray = auto()
    MergeSort = auto()
    MinimumSpanningTree = auto()
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
    TransposeMatrix = auto()
    

    @property
    def key(self):
        return self.name.lower()


def main():
    glotter_main()


if __name__ == '__main__':
    main()
