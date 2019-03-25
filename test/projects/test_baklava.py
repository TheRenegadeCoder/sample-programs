import os

import pytest

from test.fixtures import project_permutations, docker_client
from test.project import ProjectType


@pytest.fixture(params=project_permutations[ProjectType.Baklava].params,
                ids=project_permutations[ProjectType.Baklava].ids)
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
