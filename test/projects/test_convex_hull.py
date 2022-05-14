from typing import List, Tuple
import pytest

from runner import ProjectType
from glotter import project_fixture, project_test

from test.utilities import clean_list

usage = 'Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210")'

invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            usage
        ), (
            'missing y',
            '"100, 180, 240"',
            usage
        ), (
            'invalid shape',
            '"100, 180" "240, 300"',
            usage
        ), (
            'different cardinality',
            '"100, 180, 240" "240, 60, 40, 200, 300"',
            usage
        ), (
            'invalid integers',
            '"100, 1A0, 240" "220, 120, 20"',
            usage
        )
    ]
)

valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input: triangle',
            '"100, 180, 240" "220, 120, 20"',
            '(100, 220)\n(240, 20)\n(180, 120)'
        ), (
            'sample input: pentagon',
            '"100, 140, 320, 480, 280" "240, 60, 40, 200, 300"',
            '(100, 240)\n(140, 60)\n(320, 40)\n(480, 200)\n(280, 300)'
        ), (
            'sample input: cluster',
            '"260, 280, 300, 320, 600, 360, 20, 240" "160, 100, 180, 140, 160, 320, 200, 0"',
            '(20, 200)\n(240, 0)\n(600, 160)\n(360, 320)'
        )
    ]
)

def parse_list(in_params) -> List[Tuple[int]]:
    points = clean_list(in_params)
    points = points.replace("(", "").replace(")", "").replace(" ", "").split()
    points = [tuple(map(int, point.split(","))) for point in points]
    return points

@project_fixture(ProjectType.ConvexHull.key)
def convex_hull(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.ConvexHull.key)
@pytest.mark.parametrize(valid_permutations[0], valid_permutations[1],
                         ids=[p[0] for p in valid_permutations[1]])
def test_convex_hull_valid(description, in_params, expected, convex_hull):
    actual = convex_hull.run(params=in_params)
    assert set(parse_list(actual)) == set(parse_list(expected))


@project_test(ProjectType.ConvexHull.key)
@pytest.mark.parametrize(invalid_permutations[0], invalid_permutations[1],
                         ids=[p[0] for p in invalid_permutations[1]])
def test_convex_hull_invalid(description, in_params, expected, convex_hull):
    actual = convex_hull.run(params=in_params)
    assert actual.strip() == expected
