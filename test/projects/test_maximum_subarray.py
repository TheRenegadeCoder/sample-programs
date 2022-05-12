import pytest

from runner import ProjectType
from glotter import project_test, project_fixture
from test.utilities import clean_list

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: Please provide a list of at least two integers to sort in the format: "1, 2, 3, 4, 5"'
        ), (
            'empty input',
            '""',
            'Usage: Please provide a list of at least two integers to sort in the format: "1, 2, 3, 4, 5"'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: one element',
            '"1"',
            '1'
        ), (
            'sample input: many positive values',
            '"1, 2, 3"',
            '6'
        ), (
            'sample input: many negative values',
            '"-1, -2, -3"',
            '-1'
        ), (
            'sample input: many positive and negative values',
            '"-2, -1, 3, 4, 5"',
            '12'
        )
    ]
)


@project_fixture(ProjectType.MaximumSubarray.key)
def linear_search(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.MaximumSubarray.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_maximum_subarray_valid(description, in_params, expected, linear_search):
    actual = linear_search.run(params=in_params)
    assert actual.strip().lower() == expected


@project_test(ProjectType.MaximumSubarray.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_maximum_subarray_invalid(description, in_params, expected, linear_search):
    actual = linear_search.run(params=in_params)
    assert actual.strip() == expected
