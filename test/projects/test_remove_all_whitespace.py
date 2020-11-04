import pytest

from runner import ProjectType
from glotter import project_test, project_fixture


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
            'Sample Input: No Spaces',
            'RemoveAllWhitespace',
            'RemoveAllWhitespace'
        ), (
            'Sample Input: Leading Spaces',
            ' RemoveAllWhitespace',
            'RemoveAllWhitespace'
        ), (
            'Sample Input: Trailing Spaces',
            'RemoveAllWhitespace ',
            'RemoveAllWhitespace'
        ), (
            'Sample Input: Inner Spaces',
            'Remove All Whitespace',
            'RemoveAllWhitespace'
        ), (
            'Sample Input: Tabs',
            '   Remove   All Whitespace      ',
            'RemoveAllWhitespace'
        ), (
            'Sample Input: Newlines',
            '   Remove      All     Whitespace      ',
            'RemoveAllWhitespace'
        ), (
            'Sample Input: Carriage Returns',
            '    Remove   All   Whitespace   ',
            'RemoveAllWhitespace'
        )
    ]
)


@project_fixture(ProjectType.RemoveAllWhitespace.key)
def remove_all_whitespace(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.RemoveAllWhitespace.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_remove_all_whitespace_valid(description, in_params, expected, remove_all_whitespace):
    actual = remove_all_whitespace.run(params=in_params)
    assert actual.strip().lower() == expected


@project_test(ProjectType.RemoveAllWhitespace.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_remove_all_whitespace_invalid(description, in_params, expected, remove_all_whitespace):
    actual = remove_all_whitespace.run(params=in_params)
    assert actual.strip() == expected
