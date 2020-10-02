import pytest

from runner import ProjectType
from glotter import project_test, project_fixture

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please input a number'
        ), (
            'empty input',
            '""',
            'Usage: please input a number'
        ), (
            'invalid input: not a number',
            '"a"',
            'Usage: please input a number'
        )
    ]
)

def EvenOdd(n):
    if n % 2 == 0:
        yield 'Even'
    else:
        yield 'Odd'


@project_fixture(ProjectType.EvenOdd.key)
def even_odd(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.EvenOdd.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_even_odd_valid(description, in_params, expected, even_odd):
    actual = even_odd.run(params=in_params)
    assert actual.replace('[', '').replace(']', '').strip() == expected


@project_test(ProjectType.EvenOdd.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_even_odd_invalid(description, in_params, expected, even_odd):
    actual = even_odd.run(params=in_params)
    assert actual.strip() == expected
