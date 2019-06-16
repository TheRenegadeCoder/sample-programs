import pytest

from runner import ProjectType
from glotter import project_test, project_fixture
from test.utilities import clean_list

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide two lists in the format "1, 2, 3, 4, 5"'
        ), (
            'empty input',
            '""',
            'Usage: please provide two lists in the format "1, 2, 3, 4, 5"'
        ), (
            'missing input',
            '"25 15 10 5"',
            'Usage: please provide two lists in the format "1, 2, 3, 4, 5"'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input same length',
            '"1, 4, 5, 3, 15, 6" "1, 7, 4, 5, 11, 6"',
            '1, 4, 5, 6'
        ), (
            'sample input different length',
            '"1, 4, 8, 6, 9, 3, 15, 11, 6" "1, 7, 4, 5, 8, 11, 6"',
            '1, 4, 8, 11, 6'
        )
    ]
)


@project_fixture(ProjectType.LCS)
def lcs(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.LCS)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_lcs_valid(description, in_params, expected, lcs):
    actual = lcs.run(params=in_params)
    assert clean_list(actual) == expected


@project_test(ProjectType.LCS)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_lcs_invalid(description, in_params, expected, lcs):
    actual = lcs.run(params=in_params)
    assert actual.strip() == expected
