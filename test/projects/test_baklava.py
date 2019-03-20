import os

import pytest

from test.fixtures import sources, docker_client
from test.project import ProjectType


@pytest.fixture(params=sources[ProjectType.Baklava],
                ids=[source.name + source.extension for source in sources[ProjectType.Baklava]])
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
    actual = baklava.run(docker_client)
    actual_lines = actual.split(os.linesep)
    assert actual_lines == expected_lines
