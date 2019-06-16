import pytest

from runner import ProjectType
from glotter import project_test, project_fixture


invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide a string of roman numerals'
        ), (
            'invalid input',
            '"XT"',
            'Error: invalid string of roman numerals'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'empty input',
            '""',
            '0'
        ), (
            'single I',
            '"I"',
            '1'
        ), (
            'single V',
            '"V"',
            '5'
        ), (
            'single X',
            '"X"',
            '10'
        ), (
            'single L',
            '"L"',
            '50'
        ), (
            'single C',
            '"C"',
            '100'
        ), (
            'single D',
            '"D"',
            '500'
        ), (
            'single M',
            '"M"',
            '1000'
        ), (
            'addition',
            '"XXV"',
            '25'
        ), (
            'subtraction',
            '"XIV"',
            '14'
        )
    ]
)


@project_fixture(ProjectType.RomanNumeral)
def roman_numeral(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.RomanNumeral)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_roman_numeral_valid(description, in_params, expected, roman_numeral):
    actual = roman_numeral.run(params=in_params)
    assert actual.strip() == expected


@project_test(ProjectType.RomanNumeral)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_roman_numeral_invalid(description, in_params, expected, roman_numeral):
    actual = roman_numeral.run(params=in_params)
    assert actual.strip() == expected

