import pytest

from runner import ProjectType
from glotter import project_fixture, project_test


invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide a string'
        ), (
            'empty input',
            '""',
            'Usage: please provide a string'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: no spaces',
            '"RemoveAllWhitespace"',
            'RemoveAllWhitespace'
        ), (
            'sample input: leading spaces',
            '"    RemoveAllWhitespace"',
            'RemoveAllWhitespace'
        ), (
            'sample input: trailing spaces',
            '"RemoveAllWhitespace    "',
            'RemoveAllWhitespace'
        ), (
            'sample input: inner spaces',
            '"Remove All Whitespace"',
            'RemoveAllWhitespace'
        ), (
            'sample input: tabs',
            '"\tRemove\tAll\tWhitespace\t"',
            'RemoveAllWhitespace'
        ), (
            'sample input: newlines',
            '"\nRemove\nAll\nWhitespace\n"',
            'RemoveAllWhitespace'
        ), (
            'sample input: carriage returns',
            '"\rRemove\rAll\rWhitespace\r"',
            'RemoveAllWhitespace'
        )
    ]
)


@project_fixture(ProjectType.RemoveAllWhiteSpace.key)
def remove_all_whitespace(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.RemoveAllWhiteSpace.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_remove_all_whitespace_valid(description, in_params, expected, remove_all_whitespace):
    actual = remove_all_whitespace.run(params=in_params)
    assert actual.strip() == expected


@project_test(ProjectType.RemoveAllWhiteSpace.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_remove_all_whitespace_invalid(description, in_params, expected, remove_all_whitespace):
    actual = remove_all_whitespace.run(params=in_params)
    assert actual.strip() == expected
