from runner import ProjectType
from glotter import project_test, project_fixture


@project_fixture(ProjectType.FileInputOutput.key)
def file_io(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.FileInputOutput.key)
def test_file_io(file_io):
    actual = file_io.run()
    expected = file_io.exec("cat output.txt")
    assert actual.strip() == expected.strip()
