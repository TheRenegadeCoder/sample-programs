import pytest

from test.projectpermutation import project_permutations
from samplerunner.project import ProjectType


@pytest.fixture(params=project_permutations[ProjectType.HelloWorld].params,
                ids=project_permutations[ProjectType.HelloWorld].ids,
                scope='module')
def hello_world(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


def test_hello_world(hello_world):
    actual = hello_world.run()
    assert actual.strip() == 'Hello, World!'
