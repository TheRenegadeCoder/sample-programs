import os

import pytest
import docker

from . import source, testinfo


sources = source.get_sources('../archive')
info_map = testinfo.get_test_info_map(sources['testinfo'])


@pytest.fixture
def docker_client():
    return docker.from_env()


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
        actual = baklava.run(docker_client, info_map)
        actual_lines = actual.split(os.linesep)
    assert actual_lines == expected_lines
