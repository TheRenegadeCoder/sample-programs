import os
import tempfile
import shutil

import pytest
import docker
import yaml

from . import testinfo


class Source:
    def __init__(self, name, path, test_info_string):
        self._name = name
        self._path = path

        self.test_info = testinfo.TestInfo.from_string(test_info_string, self)

    @property
    def full_path(self):
        return os.path.join(self._path, self._name)

    @property
    def path(self):
        return self._path

    @property
    def name(self):
        return os.path.splitext(self._name)[0]

    @property
    def extension(self):
        return os.path.splitext(self._name)[1]

    def run(self, client, params=''):
        tmp_dir = tempfile.mkdtemp()
        shutil.copy(self.full_path, tmp_dir)
        result = client.containers.run(self.test_info.container_info.image,
                                       f'bash -c "cd /src && {self.test_info.container_info.cmd} {params}"',
                                       remove=True,
                                       volumes={tmp_dir: {'bind': '/src', 'mode': 'rw'}})
        return result.decode('utf-8')


def get_sources(path):
    sources = {}
    for root, dirs, files in os.walk(path):
        path = os.path.abspath(root)
        if "testinfo.yml" in files:
            with open(os.path.join(path, 'testinfo.yml'), 'r') as file:
                test_info_string = file.read()

            folder_info = testinfo.FolderInfo.from_dict(yaml.safe_load(test_info_string)['folder'])
            for file in files:
                if file.endswith(folder_info.extension):
                    project_name = os.path.splitext(file)[0].lower()
                    if project_name not in sources:
                        sources[project_name] = []
                    source = Source(file, path, test_info_string)
                    sources[project_name].append(source)
    return sources


@pytest.fixture
def docker_client():
    return docker.from_env()


