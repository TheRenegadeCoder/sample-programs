from enum import Enum, auto

import yaml

from jinja2 import Environment, BaseLoader

from test.project import ProjectType


class NamingScheme(Enum):
    hyphen = auto()
    underscore = auto()
    camel = auto()
    pascal = auto()
    lower = auto()


class ContainerInfo:
    def __init__(self, image, tag, cmd):
        self._image = image
        self._cmd = cmd
        self._tag = tag

    @property
    def image(self):
        return self._image

    @property
    def cmd(self):
        return self._cmd

    @property
    def tag(self):
        return self._tag

    @classmethod
    def from_dict(cls, dictionary):
        return ContainerInfo(dictionary['image'], dictionary['tag'], dictionary['cmd'])


class FolderInfo:
    def __init__(self, extension, naming):
        self._extension = extension
        try:
            self._naming = NamingScheme[naming]
        except KeyError:
            raise KeyError(f'Unknown naming scheme: "{naming}"')

    @property
    def extension(self):
        return self._extension

    @property
    def naming(self):
        return self._naming

    def get_project_mappings(self, include_extension=False):
        project_mapping = {
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
        extension = self.extension if include_extension else ''
        return {k: f'{self._get_project_name(v)}{extension}' for k, v in project_mapping.items()}

    def _get_project_name(self, words):
        if self.naming is NamingScheme.hyphen:
            return '-'.join(words)
        elif self.naming is NamingScheme.underscore:
            return '_'.join(words)
        elif self.naming is NamingScheme.camel:
            return words[0].lower() + map(lambda word: word.upper(), words[1:])
        elif self.naming is NamingScheme.pascal:
            return map(lambda word: word.Upper(), words)
        elif self.naming is NamingScheme.lower:
            return map(lambda word: word.lower(), words)

    @classmethod
    def from_dict(cls, dictionary):
        return FolderInfo(dictionary['extension'], dictionary['naming'])


class TestInfo:
    def __init__(self, container_info, file_info):
        self._container_info = container_info
        self._file_info = file_info

    @property
    def container_info(self):
        return self._container_info

    @property
    def file_info(self):
        return self._file_info

    @classmethod
    def from_dict(cls, dictionary):
        return TestInfo(
            container_info=ContainerInfo.from_dict(dictionary['container']),
            file_info=FolderInfo.from_dict(dictionary['folder'])
        )

    @classmethod
    def from_string(cls, string, source):
        template = Environment(loader=BaseLoader).from_string(string)
        template_string = template.render(source=source)
        info_yaml = yaml.safe_load(template_string)
        return cls.from_dict(info_yaml)
