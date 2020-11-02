import pytest

from runner import ProjectType
from glotter import project_test, project_fixture
from test.utilities import clean_list

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide a string that contains at least one palindrome'
        ), (
            'empty input',
            "",
            'Usage: please provide a string that contains at least one palindrome'
        ), (
            'invalid input: no palindromes',
            "polip",
            'Usage: please provide a string that contains at least one palindrome'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: one palindrome',
            'racecar',
            'racecar'
        ), (
            'sample input: two palindrome',
            '"kayak mom"',
            'kayak'
        ), (
            'sample input: complex palindrome',
            '"step on no pets"',
            'step on no pets'
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
