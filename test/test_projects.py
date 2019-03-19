import os

import pytest
import docker

from . import source, testinfo


sources = source.get_sources('../archive')


@pytest.fixture
def docker_client():
    return docker.from_env()


@pytest.fixture(params=sources['baklava'],
                ids=['baklava' + source.extension for source in sources['baklava']])
def baklava(request):
    return request.param


@pytest.fixture(params=sources['bubble-sort'],
                ids=['bubble-sort' + source.extension for source in sources['bubble-sort']])
def bubble(request):
    return request.param


def test_baklava(docker_client, baklava):
    expected = """          *
         ***
        *****
       *******
      *********
     ***********
    *************
   ***************
  *****************
 *******************
*********************
 *******************
  *****************
   ***************
    *************
     ***********
      *********
       *******
        *****
         ***
          *
"""
    expected_lines = expected.split(os.linesep)
    actual = baklava.run(docker_client)
    actual_lines = actual.split(os.linesep)
    assert actual_lines == expected_lines


sorting_permutations = (
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
        ), (
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
        ),
    ])


@pytest.mark.parametrize(sorting_permutations[0], sorting_permutations[1], ids=[p[0] for p in sorting_permutations[1]])
def test_bubble_sort(description, in_params, expected, docker_client, bubble):
    actual = bubble.run(docker_client, params=in_params)
    assert actual.replace('[', '').replace(']', '').strip() == expected
