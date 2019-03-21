import pytest

from test.fixtures import project_permutations, docker_client
from test.project import ProjectType


@pytest.fixture(params=project_permutations[ProjectType.ReverseString].params,
                ids=project_permutations[ProjectType.ReverseString].ids)
def reverse_string(request):
    return request.param


def test_reverse_string(docker_client, reverse_string):
    actual = reverse_string.run(docker_client, params='"Hello, World"')
    assert actual.strip() == 'dlroW ,olleH'
