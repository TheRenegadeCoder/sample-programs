import os
import pathlib
import urllib.request
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
        self.wiki_url_base: str = "/jrg94/sample-programs/wiki/"
        self.repo_url_base: str = "/jrg94/sample-programs/tree/master/archive/"
        self.tag_url_base: str = "https://therenegadecoder.com/tag/"
        self.issue_url_base: str = "/jrg94/sample-programs/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+"
        self.pages: List[Page] = list()

    @staticmethod
    def _build_link(text: str, url: str) -> str:
        separator = ""
        return separator.join(["[", text, "]", "(", url, ")"])

    @staticmethod
    def verify_link(url):
        request = urllib.request.Request(url)
        request.get_method = lambda: 'HEAD'
        print("Trying: ", url)
        try:
            urllib.request.urlopen(request)
            return True
        except urllib.request.HTTPError:
            return False

    def build_wiki_link(self, text: str, page_name: str) -> str:
        return self._build_link(text, self.wiki_url_base + page_name)

    def build_repo_link(self, text: str, letter: str, language: str) -> str:
        return self._build_link(text, self.repo_url_base + letter + "/" + language)

    def build_tag_link(self, language):
        test_url = self.tag_url_base + language
        if not self.verify_link(test_url):
            markdown_url = ""
        else:
            markdown_url = self._build_link("Here", test_url)
        return markdown_url

    def build_issue_link(self, language: str):
        lang_query = language.replace("-", "+")
        return self._build_link("Here", self.issue_url_base + lang_query)

    def build_wiki(self):
        self.repo = Repo()
        self.repo.analyze_repo()
        self.build_alphabet_catalog()
        self.build_alphabet_pages()
        self.output_pages()

    def output_pages(self):
        for page in self.pages:
            page.output_page()

    def build_alphabet_catalog(self):
        page = Page("Alphabetical Language Catalog")
        alphabetical_list = os.listdir(self.repo.source_dir)
        page.add_table_header("Collection", "# of Languages", "# of Snippets")
        for letter in alphabetical_list:
            letter_link = self.build_wiki_link(letter.capitalize(), letter.capitalize())
            languages_by_letter = self.repo.get_languages_by_letter(letter)
            num_of_languages = len(languages_by_letter)
            num_of_snippets = sum([language.total_snippets for language in languages_by_letter])
            page.add_table_row(letter_link, str(num_of_languages), str(num_of_snippets))
        page.add_table_row("**Totals**", str(len(self.repo.languages)), str(self.repo.total_snippets))
        self.pages.append(page)

    def build_alphabet_pages(self):
        alphabetical_list = os.listdir(self.repo.source_dir)
        for letter in alphabetical_list:
            page = self.build_alphabet_page(letter)
            self.pages.append(page)

    def build_alphabet_page(self, letter):
        page = Page(letter)
        introduction = """The following table contains all the existing languages 
                    in the repository that start with the letter %s:""" % letter.capitalize()
        page.add_row(introduction)
        page.add_table_header("Language", "Article(s)", "Issue(s)", "# of Snippets", "Contributors")
        languages_by_letter = self.repo.get_languages_by_letter(letter)
        for language in languages_by_letter:
            language_link = self.build_repo_link(language.name.capitalize(), letter, language.name)
            tag_link = self.build_tag_link(language.name)
            issues_link = self.build_issue_link(language.name)
            page.add_table_row(language_link, tag_link, issues_link, str(language.total_snippets), "")
        return page


class Page:
    def __init__(self, name: str):
        self.name: str = name
        self.content: List(str) = list()

    def __str__(self):
        return self.name + self._build_page()

    def _build_page(self):
        return "\n".join(self.content)

    def add_row(self, row: str):
        self.content.append(row)

    def add_table_header(self, *args):
        column_separator = " | "
        header = column_separator.join(args)
        divider = column_separator.join(["-----"] * len(args))
        self.content.append(header)
        self.content.append(divider)

    def add_table_row(self, *args):
        column_separator = " | "
        row = column_separator.join(args)
        self.content.append(row)

    def output_page(self):
        separator = "-"
        file_name = separator.join(self.name.split()) + ".md"
        dump_dir = 'wiki'
        pathlib.Path(dump_dir).mkdir(parents=True, exist_ok=True)
        output_file = open(os.path.join(dump_dir, file_name), "w+")
        output_file.write(self._build_page())
        output_file.close()


if __name__ == '__main__':
    wiki = Wiki()
    wiki.build_wiki()
