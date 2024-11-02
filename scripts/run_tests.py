import argparse
import sys
from collections import defaultdict
from pathlib import Path
from typing import Iterable, List, Set, NoReturn, Generator, Optional

from glotter.batch import batch
from glotter.download import download, remove_images
from glotter.source import get_sources
from glotter.settings import Settings
from glotter.test import test

RUN_EVERYTHING_PATHS = {
    Path(".glotter.yml"),
    Path("pyproject.toml"),
    Path("poetry.lock"),
    Path(".github/workflows/test-suite.yml"),
    Path("scripts/run_tests.py"),
}


def remove_non_existing_file_changes(files_changed: Iterable[str]) -> Set[Path]:
    return {Path(path) for path in files_changed if Path(path).exists()}


def should_run_everything(event: Optional[str], paths_changed: Set[Path]) -> bool:
    return event == "schedule" or bool(paths_changed & RUN_EVERYTHING_PATHS)


def run_everything(parsed_args: argparse.Namespace) -> NoReturn:
    print("=== Running all tests ===\n", flush=True)
    glotter_args = argparse.Namespace(
        num_batches=parsed_args.num_batches,
        batch=None,
        parallel=parsed_args.parallel,
        remove=parsed_args.remove,
    )
    batch(glotter_args)


def should_run_languages(paths_changed: Set[Path]) -> bool:
    return any(path.name == "testinfo.yml" for path in paths_changed)


def run_languages(paths_changed: Set[Path], parsed_args: argparse.Namespace) -> NoReturn:
    languages = _get_languages(paths_changed)
    print(f"=== Running tests for {', '.join(languages)} ===\n", flush=True)
    exit_code = 0
    for language_set in _do_batches(languages, parsed_args):
        test_args = argparse.Namespace(
            source=None, project=None, language=language_set, parallel=parsed_args.parallel
        )
        try:
            test(test_args)
        except SystemExit as e:
            exit_code = exit_code or int(e.code)

    sys.exit(exit_code)


def should_run_sample_programs(paths_changed: Set[Path]) -> bool:
    return any(path.name != "README.md" for path in paths_changed)


def run_sample_programs(paths_changed: Set[Path], parsed_args: argparse.Namespace) -> NoReturn:
    print(
        f"=== Running tests for {', '.join(sorted(str(path) for path in paths_changed))} ===\n",
        flush=True,
    )
    languages = _get_languages(paths_changed)
    all_sources = get_sources(Settings().source_root)
    abs_paths_changed = {path.absolute() for path in paths_changed}
    exit_code = 0
    for language_set in _do_batches(languages, parsed_args):
        # Get selected language/project combinations for this language set
        languages_and_projects = sorted(
            (source.language.lower(), project)
            for project, sources in all_sources.items()
            for source in sources
            if source.language.lower() in language_set
            and Path(source.full_path) in abs_paths_changed
        )

        # Get list of selected projects for each language
        sample_programs = defaultdict(list)
        for language, project in languages_and_projects:
            sample_programs[language].append(project)

        # Test each selected project for each language
        for language, projects in sample_programs.items():
            for project in projects:
                test_args = argparse.Namespace(
                    source=None, project=project, language=language, parallel=parsed_args.parallel
                )
                try:
                    test(test_args)
                except SystemExit as e:
                    exit_code = exit_code or int(e.code)

    sys.exit(exit_code)


def _get_languages(paths_changed: Set[Path]) -> List[str]:
    all_sources = get_sources(Settings().source_root)
    dirs_changed = {path.parent.absolute() for path in paths_changed}
    return sorted(
        {
            source.language.lower()
            for sources in all_sources.values()
            for source in sources
            if Path(source.path) in dirs_changed
        }
    )


def _do_batches(
    languages: List[str], parsed_args: argparse.Namespace
) -> Generator[Set[str], None, None]:
    num_languages = len(languages)
    num_batches = min(num_languages, parsed_args.num_batches)
    for n in range(0, num_batches):
        # Get languages for this batch
        batch_args = argparse.Namespace(
            source=None,
            project=None,
            language=set(
                languages[
                    (n * num_languages // num_batches) : ((n + 1) * num_languages // num_batches)
                ]
            ),
            parallel=parsed_args.parallel,
        )

        # Download images for this batch
        _display_batch("Downloading images", n, num_batches)
        containers = download(batch_args)

        # Tell caller languages for this batch
        yield batch_args.language

        # If removing images, remove images for this batch
        if parsed_args.remove:
            _display_batch("Removing images", n, num_batches)
            remove_images(containers, parsed_args.parallel)


def _display_batch(prefix, n, num_batches) -> None:
    print(f"\n*** {prefix} for batch {n + 1} of {num_batches} ***", flush=True)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--event", help="GitHub event")
    parser.add_argument("--num-batches", type=int, help="number of glotter batches", required=True)
    parser.add_argument("--parallel", action="store_true", help="run glotter in parallel")
    parser.add_argument(
        "--remove", action="store_true", help="remove docker images after each batch is finished"
    )
    parser.add_argument("files_changed", nargs="*", help="files that have changed")
    parsed_args = parser.parse_args()

    paths_changed = remove_non_existing_file_changes(parsed_args.files_changed)
    if should_run_everything(parsed_args.event, paths_changed):
        run_everything(parsed_args)

    if should_run_languages(paths_changed):
        run_languages(paths_changed, parsed_args)

    if should_run_sample_programs(paths_changed):
        run_sample_programs(paths_changed, parsed_args)

    print("Nothing to do")
    sys.exit(0)


if __name__ == "__main__":
    main()
