import pytest

from runner import ProjectType
from glotter import project_test, project_fixture
from test.utilities import clean_list

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Incorrect input provided. Program Terminated'
        ), (
            'empty input',
            "",
            'Incorrect input provided. Program Terminated'
        ), (
            'invalid input: no palindromic present',
            "Polip",
            'No Palindromic substring present.'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: longest palindrome of 6eie6',
            '6eie6o6',
            'Longest Palindromic Substring is: 6eie6'
        ), (
            'sample input: longest palindrome of 6oooo6',
            '6eie6o6oooo6',
            'Longest Palindromic Substring is: 6oooo6'
        ),
    ]
)


@project_fixture(ProjectType.LPS.key)
def lps(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.LPS.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_lps_valid(description, in_params, expected, lps):
    actual = lps.run(params=in_params)
    assert actual.strip().lower() == expected


@project_test(ProjectType.LPS.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_lps_invalid(description, in_params, expected, lps):
    actual = lps.run(params=in_params)
    assert actual.strip() == expected
