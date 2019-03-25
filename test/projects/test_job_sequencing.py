import pytest

from test.fixtures import project_permutations, docker_client
from test.project import ProjectType

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
            '"20, 15, 10, 5, 1" "2, 2, 1, 3"',
            '40'
        )
    ]
)


@pytest.fixture(params=project_permutations[ProjectType.JobSequencing].params,
                ids=project_permutations[ProjectType.JobSequencing].ids)
def job_sequencing(request):
    return request.param


@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_job_sequencing_valid(description, in_params, expected, docker_client, job_sequencing):
    actual = job_sequencing.run(docker_client, params=in_params)
    assert actual.strip() == expected


@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_job_sequencing_invalid(description, in_params, expected, docker_client, job_sequencing):
    actual = job_sequencing.run(docker_client, params=in_params, expect_error=True)
    assert actual.strip() == expected
