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
            'sample input: lowercase string',
            '"hello"',
            'Hello'
        ), (
            'sample input: uppercase string',
            '"Hello"',
            'Hello'
        ), (
            'sample input: long string',
            '"hello world"',
            'Hello world'
        ), (
            'sample input: mixed casing',
            '"heLLo World"',
            'HeLLo World'
        ), (
            'sample input: symbols',
            '"12345"',
            '12345'
        )
    ]
)


@project_fixture(ProjectType.Capitalize.key)
def capitalize(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.Capitalize.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_capitalize_valid(description, in_params, expected, capitalize):
    actual = capitalize.run(params=in_params)
    assert actual.strip() == expected


@project_test(ProjectType.Capitalize.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_capitalize_invalid(description, in_params, expected, capitalize):
    actual = capitalize.run(params=in_params)
    assert actual.strip() == expected
