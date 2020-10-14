import pytest

from runner import ProjectType
from glotter import project_test, project_fixture
from test.utilities import clean_list

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please input a number with at least two digits'
        ), (
            'empty input',
            "",
            'Usage: please input a number with at least two digits'
        ), (
            'invalid input: not a number',
            "a",
            'Usage: please input a number with at least two digits'
        ),
        (
            'invalid input: not enough digits',
            "7",
            'Usage: please input a number with at least two digits'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: palindrome',
            '232',
            'true'
        ), (
            'sample input: not palindrome',
            '521',
            'false'
        ),
    ]
)


@project_fixture(ProjectType.PalindromicNumber.key)
def palindromic_number(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.PalindromicNumber.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_palindromic_number_valid(description, in_params, expected, palindromic_number):
    actual = palindromic_number.run(params=in_params)
    assert actual.strip().lower() == expected


@project_test(ProjectType.PalindromicNumber.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_palindromic_number_invalid(description, in_params, expected, palindromic_number):
    actual = palindromic_number.run(params=in_params)
    assert actual.strip() == expected
