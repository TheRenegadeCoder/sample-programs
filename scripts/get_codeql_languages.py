import argparse
import json
from collections import defaultdict
from dataclasses import dataclass
from fnmatch import fnmatch
from pathlib import Path
from typing import DefaultDict, Dict, Set

LINUX = "ubuntu-latest"
MACOS = "macos-latest"
WINDOWS = "windows-latest"


@dataclass(frozen=True)
class LanguageInfo:
    language: str
    build_mode: str = "none"
    os: str = LINUX


CODEQL_LANGUAGES: Dict[str, LanguageInfo] = {
    "scripts/*.py": LanguageInfo(language="python"),
    "archive/c/c/*.c": LanguageInfo(language="c", build_mode="manual"),
    "archive/c/c-plus-plus/*.cpp": LanguageInfo(language="cpp", build_mode="manual"),
    "archive/c/c-sharp/*.cs": LanguageInfo(language="c#"),
    "archive/g/go/*.go": LanguageInfo(language="go", build_mode="autobuild"),
    "archive/j/java/*.java": LanguageInfo(language="java", build_mode="manual"),
    "archive/j/javascript/*.js": LanguageInfo(language="javascript"),
    "archive/k/kotlin/*.kt": LanguageInfo(language="kotlin", build_mode="manual"),
    "archive/p/python/*.py": LanguageInfo(language="python"),
    "archive/r/ruby/*.rb": LanguageInfo(language="ruby"),
    "archive/t/typescript/*.ts": LanguageInfo(language="typescript"),
    "archive/s/swift/*.swift": LanguageInfo(language="swift", build_mode="manual", os=MACOS),
    ".github/workflows/*.yml": LanguageInfo(language="actions"),
}
ALL_CODEQL_LANGUAGES_FILES = {
    ".github/workflows/codeql-analysis.yml",
    "repo-config.yml",
    "scripts/get_codeql_languages.py",
    "scripts/build_codeql_language.py",
    "pyproject.toml",
    "poetry.lock",
}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--event", help="GitHub event")
    parser.add_argument("files_changed", nargs="*", help="files that have changed")
    parsed_args = parser.parse_args()
    languages: Set[LanguageInfo] = set()
    language_paths: DefaultDict[str, Set[str]] = defaultdict(set)
    if (
        parsed_args.event == "schedule"
        or set(parsed_args.files_changed) & ALL_CODEQL_LANGUAGES_FILES
    ):
        for glob, language_info in CODEQL_LANGUAGES.items():
            languages.add(language_info)
            language_paths[language_info.language].add(glob)
    else:
        for changed_path in parsed_args.files_changed:
            for glob, language_info in CODEQL_LANGUAGES.items():
                testinfo_path = str(Path(glob).parent / "testinfo.yml")
                if fnmatch(changed_path, glob) or changed_path == testinfo_path:
                    languages.add(language_info)
                    language_paths[language_info.language].add(glob)
                    break

    workflow_output = [
        {
            "language": language_info.language,
            "build-mode": language_info.build_mode,
            "os": language_info.os,
            "paths": " ".join(sorted(language_paths[language_info.language])),
        }
        for language_info in sorted(languages, key=lambda x: x.language)
    ]
    print(json.dumps(workflow_output))


if __name__ == "__main__":
    main()
