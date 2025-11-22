import argparse
import re
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, List

import yaml

TEST_INFO_DIR: Dict[str, str] = {
    "c": "c",
    "cpp": "c-plus-plus",
    "java": "java",
    "kotlin": "kotlin",
    "swift": "swift",
}

SOURCE_NAME_PATTERN = re.compile(r"\{\{\s*source\.name\s*\}\}")
SOURCE_EXTENSION_PATTERN = re.compile(r"\{\{\s*source\.extension\s*\}\}")


@dataclass
class TestInfoStruct:
    path: Path
    language: str
    build: str


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("language", help="language to build")
    parser.add_argument("files_changed", nargs="*", help="files that have changed")
    parsed_args = parser.parse_args()
    testinfo_struct = get_test_info_struct(parsed_args.language)
    for changed_file in parsed_args.files_changed:
        path = Path(changed_file)
        print(f"Building {path}")
        command = get_build_command(testinfo_struct, path)
        subprocess.run(command, cwd=path.parent, check=True, shell=True)


def get_test_info_struct(language: str) -> TestInfoStruct:
    path = Path("archive") / language[0] / TEST_INFO_DIR[language] / "testinfo.yml"
    with path.open() as f:
        testinfo = yaml.safe_load(f)

    return TestInfoStruct(path=path, language=language, build=testinfo["container"]["build"])


def get_build_command(testinfo_struct: TestInfoStruct, path: Path) -> str:
    build = SOURCE_NAME_PATTERN.sub(path.stem, testinfo_struct.build)
    build = SOURCE_EXTENSION_PATTERN.sub(path.suffix, build)
    return build


if __name__ == "__main__":
    main()
