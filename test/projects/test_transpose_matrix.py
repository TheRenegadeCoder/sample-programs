import pytest

from runner import ProjectType
from glotter import project_test, project_fixture

usage = 'Usage: please enter the dimension of the matrix and the serialized matrix'

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            usage
        ), (
            'missing input: no columns or rows',
            '"" "" "1, 2, 3, 4, 5, 6"',
            usage
        ), (
            'missing input: no matrix',
            '"3" "3" ""',
            usage
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: routine',
            '"3" "2" "1, 2, 3, 4, 5, 6"',
            usage
        )
    ]
)


@project_fixture(ProjectType.TranposeMatrix.key)
def transpose_matrix(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.TranposeMatrix.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_transpose_matrix_valid(description, in_params, expected, transpose_matrix):
    actual = transpose_matrix.run(params=in_params)
    assert actual.strip() == expected


@project_test(ProjectType.TranposeMatrix.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_transpose_matrix_invalid(description, in_params, expected, transpose_matrix):
    actual = transpose_matrix.run(params=in_params)
    assert actual.strip() == expected
