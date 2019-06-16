from runner import ProjectType
from glotter import project_test, project_fixture


@project_fixture(ProjectType.HelloWorld)
def hello_world(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.HelloWorld)
def test_hello_world(hello_world):
    actual = hello_world.run()
    assert actual.strip() == 'Hello, World!'
