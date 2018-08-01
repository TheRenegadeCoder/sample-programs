import os
from typing import List


class Repo:
    def __init__(self):
        self.source_dir: str = os.path.join("..", "archive")
        self.languages: List[Language] = list()
        self.total_snippets: int = 0

    def analyze_repo(self):
        for root, directories, files in os.walk(self.source_dir):
            if not directories:
                language = Language(os.path.basename(root), root, files)
                language.analyze_language()
                self.languages.append(language)
        self.compute_total_snippets()

    def compute_total_snippets(self):
        count = 0
        for language in self.languages:
            count += language.total_snippets
        self.total_snippets = count


class Language:
    def __init__(self, name: str, path: str, file_list: List[str]):
        self.name: str = name
        self.path: str = path
        self.file_list: List[str] = file_list
        self.total_snippets: int = 0
        self.total_dir_size: int = 0

    def __str__(self):
        return self.name + ";" + str(self.total_snippets) + ";" + str(self.total_dir_size)

    def analyze_language(self):
        self.compute_total_snippets()
        self.computer_total_dir_size()

    def compute_total_snippets(self):
        count = 0
        for file in self.file_list:
            file_name, file_ext = os.path.splitext(file)
            if file_ext not in (".md", ""):
                count += 1
        self.total_snippets = count

    def computer_total_dir_size(self):
        size = 0
        for file in self.file_list:
            relative_path = os.path.join(self.path, file)
            size += os.path.getsize(relative_path)
        self.total_dir_size = size


class Wiki:
    def __init__(self):
        self.repo = None
        self.pages = list()

    @staticmethod
    def build_link(text, url_base, page_name):
        separator = ""
        return separator.join(["[", text, "]", "(", url_base, page_name, ")"])

    def build_wiki(self):
        self.repo = Repo()
        self.repo.analyze_repo()
        alphabetical_list = os.listdir(self.repo.source_dir)
        column_separator = "|"
        header = column_separator.join(["Collection", "# of Languages", "# of Snippets"])
        divider = column_separator.join(["-----", "-----", "-----"])
        rows = list()
        rows.append(header)
        rows.append(divider)
        for letter in alphabetical_list:
            letter_link = self.build_link(letter.capitalize(), "/jrg94/sample-programs/wiki/", letter.capitalize())
            row = column_separator.join([letter_link, "", ""])
            rows.append(row)
        row_separator = "\n"
        page = row_separator.join(rows)
        self.pages.append(page)
        print(page)


wiki = Wiki()
wiki.build_wiki()
