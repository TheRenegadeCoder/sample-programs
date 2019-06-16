from runner import ProjectType
from glotter import project_test, project_fixture


def _get_expected(source):
    with open(source.full_path) as file:
        return file.read()


@project_fixture(ProjectType.Quine)
def quine(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.Quine)
def test_quine(quine):
    expected = _get_expected(quine).strip()
    actual = quine.run().strip()
    assert actual == expected
