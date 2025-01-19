import argparse
import shlex
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List

from glotter.source import Source

TEST_INFO_DIR: Dict[str, str] = {
    "c": "c",
    "cpp": "c-plus-plus",
    "c#": "c-sharp",
    "java": "java",
    "kotlin": "kotlin",
    "swift": "swift",
}


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
    source = Source(
        name=path.name,
        language=testinfo_struct.language,
        path=str(path),
        test_info_string=testinfo_struct.test_info_str,
    )
    build: str = source.test_info.container_info.build
    return shlex.split(build)


if __name__ == "__main__":
    main()
