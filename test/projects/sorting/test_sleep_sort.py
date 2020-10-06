import pytest
from glotter import project_fixture, project_test

from runner import ProjectType
from test.projects.sorting.sorting_helpers import base_test_sort_valid, base_test_sort_invalid,\
    get_valid_permutations_parametrization, get_invalid_permutations_parametrization


@project_fixture(ProjectType.SleepSort.key)
def sleep_sort(request):
    request.param.build()
    yield request.param
    request.param.cleanup()


@project_test(ProjectType.SleepSort.key)
@pytest.mark.parametrize(**get_valid_permutations_parametrization())
def test_sleep_sort_valid(description, in_params, expected, sleep_sort):
    base_test_sort_valid(description, in_params, expected, sleep_sort)


@project_test(ProjectType.SleepSort.key)
@pytest.mark.parametrize(**get_invalid_permutations_parametrization())
def test_sleep_sort_invalid(description, in_params, expected, sleep_sort):
    base_test_sort_invalid(description, in_params, expected, sleep_sort)
