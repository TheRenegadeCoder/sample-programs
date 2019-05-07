import os

import pytest

from test.projectpermutation import project_permutations
from samplerunner.project import ProjectType


@pytest.fixture(params=project_permutations[ProjectType.FileIO].params,
                ids=project_permutations[ProjectType.FileIO].ids,
                scope='module')
def file_io(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


def test_baklava(file_io):
    actual = file_io.run()
    expected = file_io.exec("cat output.txt")
    assert actual.strip() == expected.strip()
