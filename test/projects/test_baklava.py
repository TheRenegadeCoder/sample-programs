import os

import pytest

from test.projectpermutation import project_permutations
from samplerunner.project import ProjectType


@pytest.fixture(params=project_permutations[ProjectType.Baklava].params,
                ids=project_permutations[ProjectType.Baklava].ids,
                scope='module')
def baklava(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


def test_baklava(baklava):
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
    actual = baklava.run()
    actual_lines = actual.split(os.linesep)
    assert actual_lines == expected_lines
