import pytest

from test.projectpermutation import project_permutations
from samplerunner.project import ProjectType


invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please input a non-negative integer'
        ), (
            'empty input',
            '""',
            'Usage: please input a non-negative integer'
        ), (
            'invalid input: not a number',
            '"a"',
            'Usage: please input a non-negative integer'
        ), (
            'invalid input: not an integer',
            '"6.7"',
            'Usage: please input a non-negative integer'
        ), (
            'invalid input: negative',
            '"-7"',
            'Usage: please input a non-negative integer'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input 0',
            '"0"',
            'false'
        ), (
            'sample input 1',
            '"1"',
            'false'
        ), (
            'sample input 2',
            '"2"',
            'true'
        ), (
            'sample input small composite',
            '"4"',
            'false'
        ), (
            'sample input small prime',
            '"7"',
            'true'
        ), (
            'sample input large composite',
            '"4011"',
            'false'
        ), (
            'sample input large prime',
            '"3727"',
            'true'
        )
    ]
)


@pytest.fixture(params=project_permutations[ProjectType.Prime].params,
                ids=project_permutations[ProjectType.Prime].ids,
                scope='module')
def prime(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_fibonacci_valid(description, in_params, expected, prime):
    actual = prime.run(params=in_params)
    assert actual.strip().lower() == expected


@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_fibonacci_invalid(description, in_params, expected, prime):
    actual = prime.run(params=in_params)
    assert actual.strip() == expected

