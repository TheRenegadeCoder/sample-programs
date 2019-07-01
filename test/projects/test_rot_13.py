import pytest

from test.projectpermutation import project_permutations
from samplerunner.project import ProjectType


invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide a string to encrypt'
        ), (
            'empty input',
            '""',
            'Usage: please provide a string to encrypt'
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input lower case',
            '"the quick brown fox jumped over the lazy dog"',
            'gur dhvpx oebja sbk whzcrq bire gur ynml qbt',
        ), (
            'sample input upper case',
            '"THE QUICK BROWN FOX JUMPED OVER THE LAZY DOG"',
            'GUR DHVPX OEBJA SBK WHZCRQ BIRE GUR YNML QBT',
        ), (
            'sample input punctuation',
            '"The quick brown fox jumped. Was it over the lazy dog?"',
            'Gur dhvpx oebja sbk whzcrq. Jnf vg bire gur ynml qbt?',
        )
    ]
)


@pytest.fixture(params=project_permutations[ProjectType.ROT13].params,
                ids=project_permutations[ProjectType.ROT13].ids,
                scope='module')
def rot_13(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_rot_13_valid(description, in_params, expected, rot_13):
    actual = rot_13.run(params=in_params)
    assert actual.strip() == expected


@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_rot_13_invalid(description, in_params, expected, rot_13):
    actual = rot_13.run(params=in_params)
    assert actual.strip() == expected

