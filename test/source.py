import os
import tempfile
import shutil

import pytest
import docker

from . import testinfo


class Source:
    def __init__(self, name, path):
        self._name = name
        self._path = path

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

    def run(self, client, info_map, params=''):
        container_info = testinfo.Container.from_test_info(testinfo.load_test_info(self, info_map))

        tmp_dir = tempfile.mkdtemp()
        shutil.copy(self.full_path, tmp_dir)
        result = client.containers.run(container_info.image,
                                       f'bash -c "cd /src && {container_info.cmd} {params}"',
                                       remove=True,
                                       volumes={tmp_dir: {'bind': '/src', 'mode': 'rw'}})
        return result.decode('utf-8')


def get_sources(path):
    sources = {}
    for root, dirs, files in os.walk(path):
        path = os.path.abspath(root)
        for file in files:
            project_name = os.path.splitext(file)[0].lower()
            if project_name not in sources:
                sources[project_name] = []
            sources[project_name].append(Source(file, path))
    return sources


@pytest.fixture
def docker_client():
    return docker.from_env()


