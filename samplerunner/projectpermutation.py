from samplerunner import source
from samplerunner.project import ProjectType


class ProjectPermutation:
    def __init__(self, params, ids):
        self.params = params
        self.ids = ids


def _get_project_permutations():
    sources = source.get_sources('../archive')
    return {project_type: _project_permutation(sources, project_type)for project_type in ProjectType}


def _project_permutation(sources, project_type):
    return ProjectPermutation(
        params=sources[project_type],
        ids=[source.name + source.extension for source in sources[project_type]]
    )


project_permutations = _get_project_permutations()