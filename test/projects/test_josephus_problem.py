import pytest

from runner import ProjectType
from glotter import project_test, project_fixture

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please input the total number of people and number of people to skip.'
        ), (
            'empty input',
            '""',
            'Usage: please input the total number of people and number of people to skip.'
        ), (
            'invalid input: not a number',
            '"a"',
            'Usage: please input the total number of people and number of people to skip.'
        ), (
            'invalid input: no k',
            '1',
            "Usage: please input the total number of people and number of people to skip."
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input 5, 2',
            '5 2',
            '3'
        ), (
            'sample input 7 3',
            '7 3',
            '4'
        ), (
            'sample input 41, 4',
            '41 4',
            '11'
        )
    ]
)


@project_fixture(ProjectType.JosephusProblem.key)
def josephus_problem(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.JosephusProblem.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_josephus_problem_valid(description, in_params, expected, josephus_problem):
    actual = josephus_problem.run(params=in_params)
    assert actual.replace('[', '').replace(']', '').strip() == expected


@project_test(ProjectType.JosephusProblem.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_josephus_problem_invalid(description, in_params, expected, josephus_problem):
    actual = josephus_problem.run(params=in_params)
    assert actual.strip() == expected
