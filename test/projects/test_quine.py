import pytest

from test.fixtures import project_permutations
from test.project import ProjectType


def _get_expected(source):
    with open(source.full_path) as file:
        return file.read()


@pytest.fixture(params=project_permutations[ProjectType.Quine].params,
                ids=project_permutations[ProjectType.Quine].ids,
                scope='module')
def quine(request):
    yield request.param
    request.param.cleanup()


def test_quine(quine):
    expected = _get_expected(quine)
    actual = quine.run()
    assert actual == expected
