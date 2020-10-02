# Import the module
from enum import Enum, auto
from glotter import main as glotter_main

# Define the class
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
    MergeSort = auto()
    MST = auto()
    Prime = auto()
    QuickSort = auto()
    Quine = auto()
    ROT13 = auto()
    ReverseString = auto()
    RomanNumeral = auto()
    SelectionSort = auto()

    @property
    # Return the class
    def key(self):
        return self.name.lower()

# The main function
def main():
    glotter_main()

# Display the output
if __name__ == '__main__':
    main()
