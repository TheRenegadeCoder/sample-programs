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
    """Configuration for a container to run for a directory"""

    def __init__(self, image, tag, cmd, build=None):
        """
        Initialize a ContainerInfo

        :param image: the image to run
        :param tag: the tag of the image to run
        :param cmd: the command to run the source inside the container
        :param build: an optional command to run to build the source before running the command
        """
        self._image = image
        self._cmd = cmd
        self._tag = tag
        self._build = build

    @property
    def image(self):
        """Returns the image to run"""
        return self._image

    @property
    def cmd(self):
        """Returns the command to run the source inside the container"""
        return self._cmd

    @property
    def tag(self):
        """Returns the tag of the image to run"""
        return self._tag

    @property
    def build(self):
        """Returns the command to build the source before running it inside the container"""
        return self._build

    @classmethod
    def from_dict(cls, dictionary):
        """
        Create a ContainerInfo from a dictionary

        :param dictionary: the dictionary representing ContainerInfo
        :return: a new ContainerInfo
        """
        image = dictionary['image']
        tag = dictionary['tag']
        cmd = dictionary['cmd']
        build = dictionary['build'] if 'build' in dictionary else None
        return ContainerInfo(
            image=image,
            tag=tag,
            cmd=cmd,
            build=build
        )


class FolderInfo:
    """Metadata about sources in a directory"""

    def __init__(self, extension, naming):
        """
        Initialize a FolderInfo

        :param extension: the file extension that is considered as source
        :param naming: the naming scheme for files in the directory
        """
        self._extension = extension
        try:
            self._naming = NamingScheme[naming]
        except KeyError:
            raise KeyError(f'Unknown naming scheme: "{naming}"')

    @property
    def extension(self):
        """Returns the extension for sources in the directory"""
        return self._extension

    @property
    def naming(self):
        """Returns the naming scheme for the directory"""
        return self._naming

    def get_project_mappings(self, include_extension=False):
        """
        Uses the naming scheme to generate the expected source names in the directory
        and create a mapping from ProjectType to source name

        :param include_extension: whether to include the extension in the source name
        :return: a dict where the key is a ProjectType and the value is the source name
        """
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
        """
        Generates a project name using the words in the project type and the directory's naming scheme

        :param words: the words in the project type
        :return: the project type formatted by the directory's naming scheme
        """
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
        """
        Create a FileInfo from a dictionary

        :param dictionary: the dictionary representing FileInfo
        :return: a new FileInfo
        """
        return FolderInfo(dictionary['extension'], dictionary['naming'])


class TestInfo:
    """an object representation of a testinfo file"""

    def __init__(self, container_info, file_info):
        """
        Initialize a TestInfo object

        :param container_info: ContainerInfo object
        :param file_info: FileInfo object
        """
        self._container_info = container_info
        self._file_info = file_info

    @property
    def container_info(self):
        """Return container info section"""
        return self._container_info

    @property
    def file_info(self):
        """Return file info section"""
        return self._file_info

    @classmethod
    def from_dict(cls, dictionary):
        """
        Create a TestInfo from a dictionary

        :param dictionary: the dictionary representing TestInfo
        :return: a new TestInfo
        """
        return TestInfo(
            container_info=ContainerInfo.from_dict(dictionary['container']),
            file_info=FolderInfo.from_dict(dictionary['folder'])
        )

    @classmethod
    def from_string(cls, string, source):
        """
        Create a TestInfo from a string. Modify the string using Jinja2 templating. Then parse it as yaml

        :param string: contents of a testinfo file
        :param source: a source object to use for jinja2 template parsing
        :return: a new TestInfo
        """
        template = Environment(loader=BaseLoader).from_string(string)
        template_string = template.render(source=source)
        info_yaml = yaml.safe_load(template_string)
        return cls.from_dict(info_yaml)
