import pytest

from runner import ProjectType
from glotter import project_test, project_fixture

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide a list of profits and a list of deadlines'
        ), (
            'empty input',
            '""',
            'Usage: please provide a list of profits and a list of deadlines'
        ), (
            'missing input',
            '"25 15 10 5"',
            'Usage: please provide a list of profits and a list of deadlines'
        ), (
            'lists different lengths',
            '"1, 2, 3, 4", "1, 2, 3, 4, 5"',
            'Usage: please provide a list of profits and a list of deadlines'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input one',
            '"25, 15, 10, 5" "3, 1, 2, 2"',
            '50'
        ), (
            'sample input two',
            '"20, 15, 10, 5, 1" "2, 2, 1, 3, 3"',
            '40'
        )
    ]
)


@project_fixture(ProjectType.JobSequencing)
def job_sequencing(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.JobSequencing)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_job_sequencing_valid(description, in_params, expected, job_sequencing):
    actual = job_sequencing.run(params=in_params)
    assert actual.strip() == expected


@project_test(ProjectType.JobSequencing)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_job_sequencing_invalid(description, in_params, expected, job_sequencing):
    actual = job_sequencing.run(params=in_params)
    assert actual.strip() == expected
