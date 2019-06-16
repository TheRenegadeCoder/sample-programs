import os
from glotter import source
from runner import ProjectType


class ProjectPermutation:
    def __init__(self, params, ids):
        self.params = params
        self.ids = ids


def _get_project_permutations():
    path_to_directory_containing_this_file = os.path.dirname(os.path.abspath(__file__))
    sources = source.get_sources(os.path.join(path_to_directory_containing_this_file, '..', 'archive'))
    return {project_type: _project_permutation(sources, project_type)for project_type in ProjectType}


def _project_permutation(sources, project_type):
    return ProjectPermutation(
        params=sources[project_type],
        ids=[source.name + source.extension for source in sources[project_type]]
    )


project_permutations = _get_project_permutations()
