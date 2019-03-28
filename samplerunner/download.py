import os
import sys

from samplerunner.source import get_sources
from samplerunner.project import get_project_type_by_name
from samplerunner.containerfactory import ContainerFactory


def download(args):
    if args.language:
        _download_language(args.language)
    elif args.project:
        _download_project(args.project)
    elif args.source:
        _download_source(args.source)
    else:
        _download_all()


def _download_image_from_source(source):
    ContainerFactory.get_image(source.test_info.container_info)


def _get_archive_path():
    path_to_directory_containing_this_file = os.path.dirname(os.path.abspath(__file__))
    return os.path.join(path_to_directory_containing_this_file, '..', 'archive')


def _error_and_exit(msg):
    print(msg)
    sys.exit(1)


def _download_all():
    sources_by_type = get_sources(_get_archive_path())
    for _, sources in sources_by_type.items():
        for source in sources:
            _download_image_from_source(source)


def _download_language(language):
    sources_by_type = get_sources(path=os.path.join(_get_archive_path(), language[0], language))
    if all([len(sources) <= 0 for _, sources in sources_by_type.items()]):
        _error_and_exit(f'No valid sources found for language: "{language}"')
    for project_type, sources in sources_by_type.items():
        for source in sources:
            _download_image_from_source(source)


def _download_project(project):
    sources_by_type = get_sources(_get_archive_path())
    project_type = get_project_type_by_name(project, case_insensitive=True)
    if project_type is None or project_type not in sources_by_type:
        _error_and_exit(f'No valid sources found for project: "{project}"')
    sources = sources_by_type[project_type]
    for source in sources:
        _download_image_from_source(source)


def _download_source(source):
    sources_by_type = get_sources(_get_archive_path())
    for project_type, sources in sources_by_type.items():
        for src in sources:
            if f'{src.name}{src.extension}'.lower() == source.lower():
                _download_image_from_source(src)
                break
        else:  # If didn't break inner loop continue
            continue
        break  # Else break this loop as well
    else:
        _error_and_exit(f'Source "{source}" could not be found')
