import pytest

from runner import ProjectType
from glotter import project_test, project_fixture

usage = 'Usage: please provide a tree in an adjacency matrix form ("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4")'

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            usage
        ), (
            'missing input: tree',
            '"" "1, 3, 5, 2, 4" "4"',
            usage
        ), (
            'missing input: vertex values',
            '"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0" "" "1"',
            usage
        ), (
            'missing input: target',
            '"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0" "1, 3, 5, 2, 4" ""',
            usage
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: first true',
            '"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0" "1, 3, 5, 2, 4" "1"',
            'true'
        ), (
            'sample input: last true',
            '"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0" "1, 3, 5, 2, 4" "4"',
            'true'
        )
    ]
)


@project_fixture(ProjectType.JobSequencing.key)
def job_sequencing(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.JobSequencing.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_job_sequencing_valid(description, in_params, expected, job_sequencing):
    actual = job_sequencing.run(params=in_params)
    assert actual.strip() == expected


@project_test(ProjectType.JobSequencing.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_job_sequencing_invalid(description, in_params, expected, job_sequencing):
    actual = job_sequencing.run(params=in_params)
    assert actual.strip() == expected
