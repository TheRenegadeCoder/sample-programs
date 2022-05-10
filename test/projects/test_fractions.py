import pytest

from runner import ProjectType
from glotter import project_fixture, project_test


invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: ./fraction-math operand1 operator operand2'
        ), (
            'empty input',
            '""',
            'Usage: ./fractions-math operand1 operator operand2'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: addition',
            '2/3 + 4/5',
            '22/15'
        ), (
            'sample input: multiplication',
            '2/3 * 4/5',
            '8/15'
        ), (
            'sample input: subtraction',
            '2/3 - 4/5',
            '-2/15'
        ), (
            'sample input: division',
            '2/3 / 4/5',
            '5/6'
        ), (
            'sample input: equals',
            '2/3 == 4/5',
            '0'
        ), (
            'sample input: greater than',
            '2/3 > 4/5	',
            '0'
        ), (
            'sample input: less than',
            '2/3 < 4/5',
            '1'
        ), (
            'sample input: greater than equals',
            '2/3 >= 4/5',
            '0'
        ), (
            'sample input: less than equals',
            '2/3 <= 4/5',
            '1'
        ), (
            'sample input: not equals',
            '2/3 != 4/5',
            '1'
        )
    ]
)


@project_fixture(ProjectType.FractionMath.key)
def capitalize(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.FractionMath.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_fractions_valid(description, in_params, expected, capitalize):
    actual = capitalize.run(params=in_params)
    assert actual.strip() == expected


@project_test(ProjectType.FractionMath.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_fractions_invalid(description, in_params, expected, capitalize):
    actual = capitalize.run(params=in_params)
    assert actual.strip() == expected
