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
            'sample input: no duplicates',
            '"hola"',
            'No duplicate characters'
        ), (
            'sample input: routine',
            '"goodbyeblues"',
            'o: 2\nb: 2\ne: 2'
        )
    ]
)


@project_fixture(ProjectType.DuplicateCharacterCounter.key)
def duplicate_character_counter(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.DuplicateCharacterCounter.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_duplicate_character_counter_valid(description, in_params, expected, duplicate_character_counter):
    actual = duplicate_character_counter.run(params=in_params)
    assert actual.strip() == expected


@project_test(ProjectType.DuplicateCharacterCounter.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_duplicate_character_counter_invalid(description, in_params, expected, duplicate_character_counter):
    actual = duplicate_character_counter.run(params=in_params)
    assert actual.strip() == expected
