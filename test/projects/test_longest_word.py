import pytest

from runner import ProjectType
from glotter import project_fixture, project_test


invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide a string'
        ), (
            'empty input',
            '""',
            'Usage: please provide a string'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: many words',
            '"May the force be with you"',
            '5'
        ), (
            'sample input: single word',
            '"Floccinaucinihilipilification"',
            '29'
        ), (
            'sample input: multiline',
            '"Hi,\nMy name is Paul!"',
            '5'
        )
    ]
)


@project_fixture(ProjectType.LongestWord.key)
def longest_word(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.LongestWord.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_longest_word_valid(description, in_params, expected, longest_word):
    actual = longest_word.run(params=in_params)
    assert actual.strip() == expected


@project_test(ProjectType.LongestWord.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_longest_word_invalid(description, in_params, expected, longest_word):
    actual = longest_word.run(params=in_params)
    assert actual.strip() == expected
