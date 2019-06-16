from runner import ProjectType
from glotter import project_test, project_fixture


@project_fixture(ProjectType.ReverseString)
def reverse_string(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.ReverseString)
def test_reverse_string(reverse_string):
    actual = reverse_string.run(params='"Hello, World"')
    assert actual.strip() == 'dlroW ,olleH'
