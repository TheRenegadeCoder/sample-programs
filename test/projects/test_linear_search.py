import pytest

from runner import ProjectType
from glotter import project_test, project_fixture
from test.utilities import clean_list

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")'
        ), (
            'missing input: target',
            '"1, 2, 3, 4"',
            'Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")'
        ), (
            'missing input: list',
            '"" "5"',
            'Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input first true',
            '"1, 3, 5, 7" "1"',
            'true'
        ), (
            'sample input last true',
            '"1, 3, 5, 7" "7"',
            'true'
        ), (
            'sample input middle true',
            '"1, 3, 5, 7" "5"',
            'true'
        ), (
            'sample input one true',
            '"5" "5"',
            'true'
        ), (
            'sample input one false',
            '"5" "7"',
            'false'
        ), (
            'sample input many false',
            '"1, 3, 5, 6" "7"',
            'false'
        )
    ]
)


@project_fixture(ProjectType.LinearSearch.key)
def linear_search(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.LinearSearch.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_linear_search_valid(description, in_params, expected, linear_search):
    actual = linear_search.run(params=in_params)
    assert actual.strip().lower() == expected


@project_test(ProjectType.LinearSearch.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_linear_search_invalid(description, in_params, expected, linear_search):
    actual = linear_search.run(params=in_params)
    assert actual.strip() == expected
