import os

import yaml

from samplerunner import testinfo
from samplerunner.containerfactory import ContainerFactory
from samplerunner.project import ProjectType


class Source:
    """Metadata about a source file"""

    def __init__(self, name, path, test_info_string):
        """Initialize source

        :param name: filename including extension
        :param path: path to the file excluding name
        :param test_info_string: a string in yaml format containing testinfo for a directory
        """
        self._name = name
        self._path = path

        self._test_info = testinfo.TestInfo.from_string(test_info_string, self)

    @property
    def full_path(self):
        """Returns the full path to the source including filename and extension"""
        return os.path.join(self._path, self._name)

    @property
    def path(self):
        """Returns the path to the source excluding name"""
        return self._path

    @property
    def name(self):
        """Returns the name of the source excluding the extension"""
        return os.path.splitext(self._name)[0]

    @property
    def extension(self):
        """Returns the extension of the source"""
        return os.path.splitext(self._name)[1]

    @property
    def test_info(self):
        """Returns parsed TestInfo object"""
        return self._test_info

    def build(self, params=''):
        if self.test_info.container_info.build is not None:
            container = ContainerFactory.get_container(self)
            result = container.exec_run(
                cmd=f'{self.test_info.container_info.build} {params}',
                detach=False,
                workdir='/src'
            )
            if result[0] != 0:
                raise RuntimeError(f'unable to build using cmd "{self.test_info.container_info.build} {params}":\n'
                                   f'{result[1].decode("utf-8")}')

    def run(self, params=''):
        """
        Run the source and return the output

        :param params: input passed to the source as it's run
        :return: the output of running the source
        """

        container = ContainerFactory.get_container(self)
        result = container.exec_run(
            cmd=f'{self.test_info.container_info.cmd} {params}',
            detach=False,
            workdir='/src'
        )
        return result[1].decode('utf-8')

    def cleanup(self):
        ContainerFactory.cleanup(self)


def get_sources(path):
    """
    Walk through a directory and create Source objects

    :param path: path to the directory through which to walk
    :return: a dict where the key is the ProjectType and the value is a list of all the Source objects of that project
    """
    sources = {k: [] for k in ProjectType}
    for root, dirs, files in os.walk(path):
        path = os.path.abspath(root)
        if "testinfo.yml" in files:
            with open(os.path.join(path, 'testinfo.yml'), 'r') as file:
                test_info_string = file.read()
            folder_info = testinfo.FolderInfo.from_dict(yaml.safe_load(test_info_string)['folder'])
            folder_project_names = folder_info.get_project_mappings(include_extension=True)
            for project_type, project_name in folder_project_names.items():
                if project_name in files:
                    source = Source(project_name, path, test_info_string)
                    sources[project_type].append(source)
    return sources
