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
    def key(self):
        return self.name.lower()
class HelloWorld(Enum):
    print("Hello world")
class EvenOdd(Enum):
    num = int(input("Enter number\n"))
    if num%2 == 0:
        print("The number: Even")
        
    else:
        print("The number: Odd")
class Capitalize(Enum):
    txt = input("Enter text here: \n")
    b = txt.capitalize()
    print(f"Capitalized text is: {b}")

def main():
    glotter_main()


if __name__ == '__main__':
    main()
