from runner import ProjectType
from glotter import project_test, project_fixture

def HelloWorld():
    return 'Hello World'
@project_fixture(ProjectType.HelloWorld.key)
def hello_world(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.HelloWorld.key)
def test_hello_world(hello_world):
    actual = hello_world.run()
    assert actual.strip() == 'Hello, World!'
