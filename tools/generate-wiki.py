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

    def get_languages_by_letter(self, letter):
        language_list = [language for language in self.languages if language.name.startswith(letter)]
        return language_list


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
        self.repo: Repo = None
        self.url_base: str = "/jrg94/sample-programs/wiki/"
        self.pages: List[Page] = list()

    def build_link(self, text, page_name):
        separator = ""
        return separator.join(["[", text, "]", "(", self.url_base, page_name, ")"])

    def build_wiki(self):
        self.repo = Repo()
        self.repo.analyze_repo()
        self.build_alphabet_page()
        self.output_pages()

    def output_pages(self):
        for page in self.pages:
            page.output_page()

    def build_alphabet_page(self):
        alphabetical_list = os.listdir(self.repo.source_dir)
        column_separator = " | "
        header = column_separator.join(["Collection", "# of Languages", "# of Snippets"])
        divider = column_separator.join(["-----", "-----", "-----"])
        rows = list()
        rows.append(header)
        rows.append(divider)
        for letter in alphabetical_list:
            letter_link = self.build_link(letter.capitalize(), letter.capitalize())
            languages_by_letter = self.repo.get_languages_by_letter(letter)
            num_of_languages = len(languages_by_letter)
            num_of_snippets = sum([language.total_snippets for language in languages_by_letter])
            row = column_separator.join([letter_link, str(num_of_languages), str(num_of_snippets)])
            rows.append(row)
        totals = column_separator.join(["**Totals**", str(len(self.repo.languages)), str(self.repo.total_snippets)])
        rows.append(totals)
        row_separator = "\n"
        page_content = row_separator.join(rows)
        self.pages.append(Page("Alphabetical Language Catalog", page_content))


class Page:
    def __init__(self, name, content):
        self.name: str = name
        self.content: str = content

    def __str__(self):
        return self.name + "\n" + self.content

    def output_page(self):
        separator = "-"
        file_name = separator.join(self.name.split()) + ".md"
        output_file = open(file_name, "w+")
        output_file.write(self.content)
        output_file.close()


if __name__ == '__main__':
    wiki = Wiki()
    wiki.build_wiki()
