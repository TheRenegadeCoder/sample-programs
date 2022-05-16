import pytest

from runner import ProjectType
from glotter import project_test, project_fixture
from test.utilities import clean_list

usage = "Usage: please provide a comma-separated list of integers"

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            usage
        ), (
            'empty input',
            '""',
            usage
        ), (
            'non-square input',
            '"1, 0, 3, 0, 5, 1"',
            usage
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: routine',
            '"0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0"',
            '16'
        )
    ]
)


@project_fixture(ProjectType.MinimumSpanningTree.key)
def minimum_spanning_tree(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.MinimumSpanningTree.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_minimum_spanning_tree_valid(description, in_params, expected, minimum_spanning_tree):
    actual = minimum_spanning_tree.run(params=in_params)
    assert actual.strip().lower() == expected


@project_test(ProjectType.MinimumSpanningTree.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_minimum_spanning_tree_invalid(description, in_params, expected, minimum_spanning_tree):
    actual = minimum_spanning_tree.run(params=in_params)
    assert actual.strip() == expected
