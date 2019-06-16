import os

from runner import ProjectType
from glotter import project_test, project_fixture


@project_fixture(ProjectType.Baklava)
def baklava(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.Baklava)
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
    for i in range(len(expected_lines)):
        assert actual_lines[i] == expected_lines[i], f'line {i + 1} did not match'
    assert len(actual_lines) == len(expected_lines), 'output contained extra trailing lines'
