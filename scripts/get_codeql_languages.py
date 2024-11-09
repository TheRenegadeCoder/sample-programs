import argparse
import json
import shutil
from collections import defaultdict
from dataclasses import dataclass
from fnmatch import fnmatch
from pathlib import Path
from typing import DefaultDict, Dict, List, Set

LINUX = "ubuntu-latest"
MACOS = "macos-latest"


@dataclass(frozen=True)
class LanguageInfo:
    language: str
    build_mode: str = "none"
    os: str = LINUX


CODEQL_LANGUAGES: Dict[str, LanguageInfo] = {
    "scripts/*.py": LanguageInfo(language="python"),
    "archive/c/c/*.c": LanguageInfo(language="c", build_mode="manual"),
    "archive/c/c-plus-plus/*.cpp": LanguageInfo(language="cpp", build_mode="manual"),
    "archive/c/c-sharp/*.cs": LanguageInfo(language="c#", build_mode="manual"),
    "archive/g/go/*.go": LanguageInfo(language="go", build_mode="autobuild"),
    "archive/j/java/*.java": LanguageInfo(language="java", build_mode="manual"),
    "archive/j/javascript/*.js": LanguageInfo(language="javascript"),
    "archive/k/kotlin/*.kt": LanguageInfo(language="kotlin", build_mode="manual"),
    "archive/p/python/*.py": LanguageInfo(language="python"),
    "archive/r/ruby/*.rb": LanguageInfo(language="ruby"),
    "archive/s/swift/*.swift": LanguageInfo(language="swift", build_mode="manual", os=MACOS),
    "archive/t/typescript/*.ts": LanguageInfo(language="typescript"),
}
ALL_CODEQL_LANGUAGES_FILES = {
    ".github/workflows/codeql-analysis.yml",
    "scripts/get_codeql_languages.py",
    "scripts/build_codeql_language.py",
}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("files_changed", nargs="*", help="files that have changed")
    parsed_args = parser.parse_args()
    languages: Set[LanguageInfo] = set()
    language_paths: DefaultDict[str, List[str]] = defaultdict(list)
    config_files: Dict[str, Path] = {}
    if set(parsed_args.files_changed) & ALL_CODEQL_LANGUAGES_FILES:
        for glob, language_info in CODEQL_LANGUAGES.items():
            languages.add(language_info)
            language_paths[language_info.language].append(glob)
    else:
        for changed_path in parsed_args.files_changed:
            for glob, language_info in CODEQL_LANGUAGES.items():
                if fnmatch(changed_path, glob):
                    languages.add(language_info)
                    language_paths[language_info.language].append(changed_path)
                    break

    temp_path = Path("temp")
    shutil.rmtree(temp_path, ignore_errors=True)
    temp_path.mkdir(parents=True, exist_ok=True)
    for language, paths in language_paths.items():
        config_file_path = temp_path / f"codeql-config-{language}.yml"
        config_files[language] = config_file_path
        contents = "paths:\n" + "".join(f"  - {path}\n" for path in paths)
        config_file_path.unlink(missing_ok=True)
        config_file_path.write_text(contents, encoding="utf-8")

    workflow_output = [
        {
            "language": language_info.language,
            "build-mode": language_info.build_mode,
            "os": language_info.os,
            "config-file": str(config_files[language_info.language]),
        }
        for language_info in sorted(languages, key=lambda x: x.language)
    ]
    print(json.dumps(workflow_output))


if __name__ == "__main__":
    main()
