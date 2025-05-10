import argparse
import re
import shlex
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List

TEST_INFO_DIR: Dict[str, str] = {
    "c": "c",
    "cpp": "c-plus-plus",
    "java": "java",
    "kotlin": "kotlin",
    "swift": "swift",
}

EXTENSION_PATTERN = re.compile(r"""^\s+extension:\s*['"](^'"]+)['"]""")
BUILD_PATTERN = re.compile(r"""^\s+build:\s*['"]([^'"]+)['"]""")
SOURCE_NAME_PATTERN = re.compile(r"\{\{\s*source\.name\s*\}\}")
SOURCE_EXTENSION_PATTERN = re.compile(r"\{\{\s*source\.extension\s*\}\}")


@dataclass
class TestInfoStruct:
    path: Path
    language: str
    test_info_str: str


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
        subprocess.run(command, cwd=path.parent, check=True)


def get_test_info_struct(language: str) -> TestInfoStruct:
    path = Path("archive") / language[0] / TEST_INFO_DIR[language] / "testinfo.yml"
    testinfo_str = path.read_text(encoding="utf-8")
    return TestInfoStruct(path=path, language=language, test_info_str=testinfo_str)


def get_build_command(testinfo_struct: TestInfoStruct, path: Path) -> List[str]:
    test_info_str = testinfo_struct.test_info_str
    extension = EXTENSION_PATTERN.sub(test_info_str, r"\g<1>")
    source_name = path.name[: -len(extension)]
    build = BUILD_PATTERN.sub(test_info_str, r"\g<1>")
    build = SOURCE_NAME_PATTERN.sub(build, source_name)
    build = SOURCE_EXTENSION_PATTERN.sub(build, extension)
    return shlex.split(build)


if __name__ == "__main__":
    main()
