import pytest

from runner import ProjectType
from glotter import project_test, project_fixture
from test.utilities import clean_list

usage = 'Usage: please provide three inputs: a serialized matrix, a source node and a destination node'

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            usage
        ), (
            'empty input',
            '"" "" ""',
            usage
        ), 
        (
            'non-square input',
            '"1, 0, 3, 0, 5, 1" "1" "2"',
            usage
        ), (
            'no destination',
            '"0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" "0" ""',
            usage
        ), (
            'no source or destination',
            '"0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" "3" "" ""',
            usage
        ), (
            'source or destination < 0',
            '"0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" "3" "-1" "2"',
            usage
        ), (
            'weight < 0',
            '"0, 2, 0, -6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, -6, 8, 0, 0, 9, 0, 5, 7, 9, 0" "3" "1" "2"',
            usage
        ), (
            'source or destination > number of vertices',
            '"0, 2, 0, -6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, -6, 8, 0, 0, 9, 0, 5, 7, 9, 0" "3" "1" "10"',
            usage
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: routine',
            '"0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" "0" "1"',
            '2'
        )
    ]
)


@project_fixture(ProjectType.Dijkstra.key)
def dijkstra(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.Dijkstra.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_dijkstra_valid(description, in_params, expected, dijkstra):
    actual = dijkstra.run(params=in_params)
    assert clean_list(actual) == expected


@project_test(ProjectType.Dijkstra.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_dijkstra_invalid(description, in_params, expected, dijkstra):
    actual = dijkstra.run(params=in_params)
    assert actual.strip() == expected
