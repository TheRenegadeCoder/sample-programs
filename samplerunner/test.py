import os
import sys
import pytest

from samplerunner.source import get_sources
from samplerunner.project import get_project_type_by_name, ProjectType


def test(args):
    if args.language:
        _run_language(args.language)
    elif args.project:
        _run_project(args.project)
    elif args.source:
        _run_source(args.source)
    else:
        _run_all()


def _error_and_exit(msg):
    print(msg)
    sys.exit(1)


def _get_tests(src, project_type, all_tests):
    filename = f'{src.name}{src.extension}'
    test_module_name = f'test/projects/{_module_mappings[project_type]}.py'
    return [tst for tst in all_tests if tst.startswith(test_module_name) and f'[{filename}' in tst]


def _run_all():
    pytest.main()


def _run_language(language):
    all_tests = _collect_tests()
    sources_by_type = get_sources(path=os.path.join('archive', language[0], language))
    if all([len(sources) <= 0 for _, sources in sources_by_type.items()]):
        _error_and_exit(f'No valid sources found for language: "{language}"')
    tests = []
    for project_type, sources in sources_by_type.items():
        for src in sources:
            tests += _get_tests(src, project_type, all_tests)
    pytest.main(tests)


def _run_project(project):
    project_type = get_project_type_by_name(project, case_insensitive=True)
    pytest.main([f'test/projects/{_module_mappings[project_type]}.py'])


def _run_source(source):
    all_tests = _collect_tests()
    sources_by_type = get_sources('archive')
    for project_type, sources in sources_by_type.items():
        for src in sources:
            filename = f'{src.name}{src.extension}'
            if filename.lower() == source.lower():
                tests = _get_tests(src, project_type, all_tests)
                pytest.main(tests)
                break
        else:  # If didn't break inner loop continue
            continue
        break  # Else break this loop as well
    else:
        _error_and_exit(f'Source "{source}" could not be found')


class TestCollectionPlugin:
    def __init__(self):
        self.collected = []

    def pytest_collection_modifyitems(self, items):
        for item in items:
            self.collected.append(item.nodeid)


def _collect_tests():
    print('============================= collect test totals ==============================')
    plugin = TestCollectionPlugin()
    pytest.main(['-qq', '--collect-only'], plugins=[plugin])
    return plugin.collected


_module_mappings = {
    ProjectType.Baklava: 'test_baklava',
    ProjectType.BubbleSort: 'test_sorting',
    ProjectType.ConvexHull: 'test_convex_hull',
    ProjectType.EvenOdd: 'test_even_odd',
    ProjectType.Factorial: 'test_factorial',
    ProjectType.Fibonacci: 'test_fibonacci',
    ProjectType.FileIO: 'test_file_io',
    ProjectType.FizzBuzz: 'test_fizz_buzz',
    ProjectType.HelloWorld: 'test_hello_world',
    ProjectType.InsertionSort: 'test_sorting',
    ProjectType.JobSequencing: 'test_job_sequencing',
    ProjectType.LCS: 'test_lcs',
    ProjectType.MergeSort: 'test_sorting',
    ProjectType.MST: 'test_mst',
    ProjectType.Prime: 'test_prime',
    ProjectType.QuickSort: 'test_sorting',
    ProjectType.Quine: 'test_quine',
    ProjectType.ROT13: 'test_rot_13',
    ProjectType.ReverseString: 'test_reverse_string',
    ProjectType.RomanNumeral: 'test_roman_numeral',
    ProjectType.SelectionSort: 'test_sorting',
}
