from enum import Enum, auto


class NamingScheme(Enum):
    hyphen = auto()
    underscore = auto()
    camel = auto()
    pascal = auto()
    lower = auto()


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


def requires_params(project):
    project_mapping = {
        ProjectType.Baklava: False,
        ProjectType.BubbleSort: True,
        ProjectType.ConvexHull: True,
        ProjectType.EvenOdd: True,
        ProjectType.Factorial: True,
        ProjectType.Fibonacci: True,
        ProjectType.FileIO: False,
        ProjectType.FizzBuzz: False,
        ProjectType.HelloWorld: False,
        ProjectType.InsertionSort: True,
        ProjectType.JobSequencing: True,
        ProjectType.LCS: True,
        ProjectType.MergeSort: True,
        ProjectType.MST: True,
        ProjectType.Prime: True,
        ProjectType.QuickSort: True,
        ProjectType.Quine: False,
        ProjectType.ROT13: True,
        ProjectType.ReverseString: True,
        ProjectType.RomanNumeral: True,
        ProjectType.SelectionSort: True,
    }
    return project_mapping[project]


def requires_params(project):
    project_mapping = {
        ProjectType.Baklava: False,
        ProjectType.BubbleSort: True,
        ProjectType.ConvexHull: True,
        ProjectType.EvenOdd: True,
        ProjectType.Factorial: True,
        ProjectType.Fibonacci: True,
        ProjectType.FileIO: False,
        ProjectType.FizzBuzz: False,
        ProjectType.HelloWorld: False,
        ProjectType.InsertionSort: True,
        ProjectType.JobSequencing: True,
        ProjectType.LCS: True,
        ProjectType.MergeSort: True,
        ProjectType.MST: True,
        ProjectType.Prime: True,
        ProjectType.QuickSort: True,
        ProjectType.Quine: False,
        ProjectType.ROT13: True,
        ProjectType.ReverseString: True,
        ProjectType.RomanNumeral: True,
        ProjectType.SelectionSort: True,
    }
    return project_mapping[project]


_project_words = {
    ProjectType.Baklava: ['baklava'],
    ProjectType.BubbleSort: ['bubble', 'sort'],
    ProjectType.ConvexHull: ['convex', 'hull'],
    ProjectType.EvenOdd: ['even', 'odd'],
    ProjectType.Factorial: ['factorial'],
    ProjectType.Fibonacci: ['fibonacci'],
    ProjectType.FileIO: ['file', 'io'],
    ProjectType.FizzBuzz: ['fizz', 'buzz'],
    ProjectType.HelloWorld: ['hello', 'world'],
    ProjectType.InsertionSort: ['insertion', 'sort'],
    ProjectType.JobSequencing: ['job', 'sequencing'],
    ProjectType.LCS: ['lcs'],
    ProjectType.MergeSort: ['merge', 'sort'],
    ProjectType.MST: ['mst'],
    ProjectType.Prime: ['prime'],
    ProjectType.QuickSort: ['quick', 'sort'],
    ProjectType.Quine: ['quine'],
    ProjectType.ROT13: ['rot', '13'],
    ProjectType.ReverseString: ['reverse', 'string'],
    ProjectType.RomanNumeral: ['roman', 'numeral'],
    ProjectType.SelectionSort: ['selection', 'sort'],
}

_project_acronyms = ['lcs', 'mst', 'io']


def get_project_type_by_name(name, case_insensitive):
    if case_insensitive:
        name = name.lower()

    for project_type in ProjectType:
        for naming in NamingScheme:
            project_name = get_project_name(naming, project_type)
            if case_insensitive:
                project_name = project_name.lower()
            if project_name == name:
                return project_type

    return None


def get_project_name(naming, project_type):
    """
    gets a project name for a specific naming scheme

    :param naming: the naming scheme
    :param project_type: the ProjectType
    :return: the project type formatted by the directory's naming scheme
    """
    return _get_project_name_from_words(naming, _project_words[project_type])


def _get_project_name_from_words(naming, words):
    """
    generates a project name using the words in the project type and the directory's naming scheme

    :param words: the words in the project type
    :return: the project type formatted by the directory's naming scheme
    """
    if naming is NamingScheme.hyphen:
        return '-'.join(words)
    elif naming is NamingScheme.underscore:
        return '_'.join(words)
    elif naming is NamingScheme.camel:
        return words[0].lower() + _to_pascal(words, _project_acronyms)
    elif naming is NamingScheme.pascal:
        return _to_pascal(words, _project_acronyms)
    elif naming is NamingScheme.lower:
        return ''.join(map(lambda word: word.lower(), words))


def _to_pascal(words, acronyms):
    def to_title(word):
        if len(word) <= 2 and word in acronyms:
            return word.upper()
        return word.title()
    return ''.join(map(to_title, words))


