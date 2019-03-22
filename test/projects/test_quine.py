import pytest

from test.fixtures import project_permutations, docker_client
from test.project import ProjectType


def _get_expected(source):
    with open(source.full_path) as file:
        return file.read()


@pytest.fixture(params=project_permutations[ProjectType.Quine].params,
                ids=project_permutations[ProjectType.Quine].ids)
def quine(request):
    return request.param


def test_quine(docker_client, quine):
    expected = _get_expected(quine)
    actual = quine.run(docker_client)
    assert actual == expected
