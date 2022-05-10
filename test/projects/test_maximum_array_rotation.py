import pytest

from runner import ProjectType
from glotter import project_test, project_fixture
from test.utilities import clean_list

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide a list of integers (e.g. "8, 3, 1, 2")'
        ), (
            'empty input',
            '""',
            'Usage: please provide a list of integers (e.g. "8, 3, 1, 2")'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input no rotation',
            '"3, 1, 2, 8"',
            '29'
        ), (
            'sample input one rotation',
            '"1, 2, 8, 3"',
            '29'
        ), (
            'sample input many rotations',
            '"8, 3, 1, 2"',
            '29'
        )
    ]
)


@project_fixture(ProjectType.MaximumArrayRotation.key)
def linear_search(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.MaximumArrayRotation.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_linear_search_valid(description, in_params, expected, linear_search):
    actual = linear_search.run(params=in_params)
    assert actual.strip().lower() == expected


@project_test(ProjectType.MaximumArrayRotation.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_linear_search_invalid(description, in_params, expected, linear_search):
    actual = linear_search.run(params=in_params)
    assert actual.strip() == expected
