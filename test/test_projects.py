import os
import tempfile
import shutil

import pytest
import docker


class Source:
    def __init__(self, name, path):
        self._name = name
        self._path = path

    @property
    def fullpath(self):
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

@pytest.fixture
def docker_client():
    return docker.from_env()


def run_source(client, source, params=''):
    tmp_dir = tempfile.mkdtemp()
    shutil.copy(source.fullpath, tmp_dir)
    result = client.containers.run('python',
                                   f"bash -c 'cd /src && python {source.name}{source.extension} {params}'",
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
