import pytest

from test.projectpermutation import project_permutations
from samplerunner.project import ProjectType


def get_fibs(n):
    fibs = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    for i in range(n):
        yield f'{i + 1}: {fibs[i]}'


invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please input the count of fibonacci numbers to output'
        ), (
            'empty input',
            '""',
            'Usage: please input the count of fibonacci numbers to output'
        ), (
            'invalid input: not a number',
            '"a"',
            'Usage: please input the count of fibonacci numbers to output'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input 0',
            '"0"',
            ''
        ), (
            'sample input 1',
            '"1"',
            '\n'.join(get_fibs(1))
        ), (
            'sample input 2',
            '"2"',
            '\n'.join(get_fibs(2))
        ), (
            'sample input 5',
            '"5"',
            '\n'.join(get_fibs(5))
        ), (
            'sample input 10',
            '"10"',
            '\n'.join(get_fibs(10))
        )
    ]
)


@pytest.fixture(params=project_permutations[ProjectType.Fibonacci].params,
                ids=project_permutations[ProjectType.Fibonacci].ids)
def fibonacci(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_fibonacci_valid(description, in_params, expected, fibonacci):
    actual = fibonacci.run(params=in_params)
    assert actual.strip() == expected


@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_fibonacci_invalid(description, in_params, expected, fibonacci):
    actual = fibonacci.run(params=in_params)
    assert actual.strip() == expected

