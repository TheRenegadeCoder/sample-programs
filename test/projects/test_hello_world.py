import pytest

from test.fixtures import project_permutations, docker_client
from test.project import ProjectType


@pytest.fixture(params=project_permutations[ProjectType.HelloWorld].params,
                ids=project_permutations[ProjectType.HelloWorld].ids)
def hello_world(request):
    return request.param


def test_hello_world(docker_client, hello_world):
    actual = hello_world.run(docker_client)
    assert actual.strip() == 'Hello, World!'
