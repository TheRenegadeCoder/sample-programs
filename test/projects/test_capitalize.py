import pytest

from runner import ProjectType
from glotter import project_fixture, project_test


invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
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


@project_fixture(ProjectType.ROT13.key)
def rot_13(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.ROT13.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_rot_13_valid(description, in_params, expected, rot_13):
    actual = rot_13.run(params=in_params)
    assert actual.strip() == expected


@project_test(ProjectType.ROT13.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_rot_13_invalid(description, in_params, expected, rot_13):
    actual = rot_13.run(params=in_params)
    assert actual.strip() == expected
