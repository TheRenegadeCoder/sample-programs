import pytest

from test.fixtures import sources, docker_client
from test.project import sorting_types


sorting_invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
        ), (
            'empty input',
            '""',
            'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
        ), (
            'invalid input: not a list',
            '"1"',
            'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
        ), (
            'invalid input: wrong format',
            '"4 5 3"',
            'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
        )
    ]
)

sorting_valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input',
            '"4, 5, 3, 1, 2"',
            '1, 2, 3, 4, 5'
        ), (
            'sample input: with duplicate',
            '"4, 5, 3, 1, 4, 2"',
            '1, 2, 3, 4, 4, 5'
        ), (
            'sample input: already sorted',
            '"1, 2, 3, 4, 5"',
            '1, 2, 3, 4, 5'
        ), (
            'sample input: reverse sorted',
            '"9, 8, 7, 6, 5, 4, 3, 2, 1"',
            '1, 2, 3, 4, 5, 6, 7, 8, 9'
        )
    ]
)


@pytest.fixture(params=[source for project in sorting_types for source in sources[project]],
                ids=[source.name + source.extension for project in sorting_types for source in sources[project]])
def sort_source(request):
    return request.param


@pytest.mark.parametrize(sorting_valid_permutations[0], sorting_valid_permutations[1],
                         ids=[p[0] for p in sorting_valid_permutations[1]])
def test_sort_valid(description, in_params, expected, docker_client, sort_source):
    actual = sort_source.run(docker_client, params=in_params)
    assert actual.replace('[', '').replace(']', '').strip() == expected


@pytest.mark.parametrize(sorting_invalid_permutations[0], sorting_invalid_permutations[1],
                         ids=[p[0] for p in sorting_invalid_permutations[1]])
def test_sort_invalid(description, in_params, expected, docker_client, sort_source):
    actual = sort_source.run(docker_client, params=in_params, expect_error=True)
    assert actual.strip() == expected
