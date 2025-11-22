"""
Run this to update the labeler workflow:

    poetry run python scripts/set_up_labeler.py

This should be done when a new project is added
"""

from pathlib import Path
from typing import Any

import yaml

GLOTTER_PATH = Path(".glotter.yml")
LABELER_CONFIG_PATH = Path(".github/labeler.yml")


def main():
    projects = read_projects()
    config = get_labeler_config(projects)
    LABELER_CONFIG_PATH.write_text(yaml.safe_dump(config, sort_keys=False), encoding="utf-8")


def read_projects() -> list[str]:
    with GLOTTER_PATH.open(encoding="utf-8") as f:
        contents = yaml.safe_load(f)

    return sorted(" ".join(project["words"]) for project in contents["projects"].values())


def get_labeler_config(projects: list[str]) -> dict[str, Any]:
    # Common labels
    config: dict[str, Any] = {
        # Not just language READMEs
        "enhancement": [
            {"changed-files": [{"all-globs-to-all-files": ["!archive/*/*/README.md"]}]},
            {"base-branch": "main"},
        ],
        # README.md and any Markdown file in .github directory
        "needs docs": [
            {"changed-files": [{"any-glob-to-any-file": ["README.md", ".github/*.md"]}]},
            {"base-branch": "main"},
        ],
        # Any language testinfo.yml files
        "tests": [
            {"changed-files": [{"any-glob-to-any-file": ["archive/*/*/testinfo.yml"]}]},
            {"base-branch": "main"},
        ],
    }

    # Add project-specific labels
    for project in projects:
        # Project-specific language files (with all possible variations)
        filenames = sorted(
            set(func(project.split()) for func in [camel_case, underscore, hyphen, pascal_case])
        )
        config[project] = [
            {
                "changed-files": [
                    {
                        "any-glob-to-any-file": [
                            f"archive/*/*/{filename}.*" for filename in filenames
                        ]
                    }
                ]
            },
            {
                "base-branch": "main",
            },
        ]

    return config


def camel_case(words: list[str]) -> str:
    return "".join([words[0]] + [word.title() for word in words[1:]])


def underscore(words: list[str]) -> str:
    return "_".join(words)


def hyphen(words: list[str]) -> str:
    return "-".join(words)


def pascal_case(words: list[str]) -> str:
    return "".join(word.title() for word in words)


if __name__ == "__main__":
    main()
