import pytest

from runner import ProjectType
from glotter import project_test, project_fixture

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please input a non-negative integer'
        ), (
            'empty input',
            "",
            'Usage: please input a non-negative integer'
        ), (
            'invalid input: not a number',
            "a",
            'Usage: please input a non-negative integer'
        ), (
            'invalid input: negative integer',
            "-7",
            'Usage: please input a non-negative integer'
        ), (
            'invalid input: float',
            "5.41",
            'Usage: please input a non-negative integer'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: one digit',
            '7',
            'true'
        ), (
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
