import argparse
import json
from fnmatch import fnmatch

# Can't get C#, Java, Kotlin, and Swift to work. Comment out for now
CODEQL_LANGUAGES = {
    "scripts/*.py": "python",
    "archive/c/c/*.c": "c",
    "archive/c/c-plus-plus/*.cpp": "cpp",
    # "archive/c/c-sharp/*.cs": "c#",
    "archive/g/go/*.go": "go",
    # "archive/j/java/*.java": "java",
    "archive/j/javascript/*.js": "javascript",
    # "archive/k/kotlin/*.kt": "kotlin",
    "archive/p/python/*.py": "python",
    "archive/r/ruby/*.rb": "ruby",
    # "archive/s/swift/*.swift": "swift",
    "archive/t/typescript/*.ts": "typescript",
}
ALL_CODEQL_LANGUAGES = set(CODEQL_LANGUAGES.values())
ALL_CODEQL_LANGUAGES_FILES = {
    ".github/workflows/codeql-analysis.yml",
    "scripts/get_codeql_languages.py",
    "scripts/build_codeql_language.py",
}
LINUX = "ubuntu-latest"
MACOS = "macos-latest"
LANGUAGE_CONFIG = {
    "c": {"build-mode": "manual", "os": LINUX},
    # "cpp": {"build-mode": "manual", "os": LINUX},
    # "c#": {"build-mode": "none", "os": LINUX},
    "go": {"build-mode": "autobuild", "os": LINUX},
    # "java": {"build-mode": "none", "os": LINUX},
    # "kotlin": {"build-mode": "autobuild", "os": LINUX},
    "javascript": {"build-mode": "none", "os": LINUX},
    "python": {"build-mode": "none", "os": LINUX},
    "ruby": {"build-mode": "none", "os": LINUX},
    "typescript": {"build-mode": "none", "os": LINUX},
    # "swift": {"build-mode": "autobuild", "os": MACOS},
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

    workflow_output = [
        {"language": language, **LANGUAGE_CONFIG[language]} for language in sorted(languages)
    ]
    print(json.dumps(workflow_output))


if __name__ == "__main__":
    main()
