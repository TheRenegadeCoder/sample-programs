import argparse
import json
from fnmatch import fnmatch

CODEQL_LANGUAGES = {
    "archive/c/c/*.c": "c-cpp",
    "archive/c/c-plus-plus/*.cpp": "c-cpp",
    "archive/j/java/*.java": "java-kotlin",
    "archive/j/javascript/*.js": "javascript-typescript",
    "archive/k/kotlin/*.kt": "java-kotlin",
    "archive/p/python/*.py": "python",
    "archive/r/ruby/*.rb": "ruby",
    "archive/s/swift/*.swift": "swift",
    "archive/t/typescript/*.ts": "javascript-typescript",
}
ALL_CODEQL_LANGUAGES = set(CODEQL_LANGUAGES.values())
ALL_CODEQL_LANGUAGES_FILES = {
    ".github/workflows/codeql-analysis.yml",
    "scripts/get_codeql_languages.py",
}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("files_changed", nargs="*", help="files that have changed")
    parsed_args = parser.parse_args()
    languages = set()
    if set(parsed_args.files_changed) & ALL_CODEQL_LANGUAGES_FILES:
        languages = ALL_CODEQL_LANGUAGES
    else:
        for changed_path in parsed_args.files_changed:
            for glob, language in CODEQL_LANGUAGES.items():
                if fnmatch(changed_path, glob):
                    languages.add(language)
                    break

    workflow_output = [{"language": language} for language in sorted(languages)]
    print(json.dumps(workflow_output))


if __name__ == "__main__":
    main()
