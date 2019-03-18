import os
import tempfile
import shutil

import pytest
import docker
import yaml

from jinja2 import Environment, BaseLoader, Template


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


class Container:
    def __init__(self, image, cmd):
        self._image = image
        self._cmd = cmd

    @property
    def image(self):
        return self._image

    @property
    def cmd(self):
        return self._cmd

    @classmethod
    def from_test_info(cls, test_info):
        container_info = test_info['container']
        return Container(container_info['image'], container_info['cmd'])



def get_sources():
    sources = {}
    for root, dirs, files in os.walk('../archive'):
        path = os.path.abspath(root)
        for file in files:
            project_name = os.path.splitext(file)[0].lower()
            if project_name not in sources:
                sources[project_name] = []
            sources[project_name].append(Source(file, path))
    return sources


sources = get_sources()


def get_test_info_map():
    info_map = {}
    test_infos = sources['testinfo']
    for test_info in test_infos:
        with open(test_info.full_path) as file:
            info_map[test_info.path] = file.read()
    return info_map


info_map = get_test_info_map()


def load_test_info(source):
        template = Environment(loader=BaseLoader).from_string(info_map[source.path])
        template_string = template.render(source=source)
        return yaml.load(template_string)


@pytest.fixture
def docker_client():
    return docker.from_env()


def run_source(client, source, params=''):
    container_info = Container.from_test_info(load_test_info(source))

    tmp_dir = tempfile.mkdtemp()
    shutil.copy(source.full_path, tmp_dir)
    result = client.containers.run(container_info.image,
                                   f'bash -c "cd /src && {container_info.cmd} {params}"',
                                   remove=True,
                                   volumes={tmp_dir: {'bind': '/src', 'mode': 'rw'}})
    return result.decode('utf-8')


@pytest.fixture(params=sources['baklava'], ids=['baklava' + source.extension for source in sources['baklava']])
def baklava(request):
    return request.param


def test_baklava(docker_client, baklava):
    expected = """          *
         ***
        *****
       *******
      *********
     ***********
    *************
   ***************
  *****************
 *******************
*********************
 *******************
  *****************
   ***************
    *************
     ***********
      *********
       *******
        *****
         ***
          *
"""
    expected_lines = expected.split(os.linesep)
    actual_lines = []
    if baklava.extension == ".py":
        actual = run_source(docker_client, baklava)
        actual_lines = actual.split(os.linesep)
    assert actual_lines == expected_lines
