from enum import Enum, auto


class ProjectType(Enum):
    Placeholder = auto()
    # Add new project types here for projects that cannot use auto-generated tests

    @property
    def key(self):
        return self.name.lower()
