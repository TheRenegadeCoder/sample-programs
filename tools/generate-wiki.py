import os


class Repo:
    def __init__(self):
        self.source_dir = "../archive"
        self.languages = list()

    def generate_repo(self):
        for root, directories, files in os.walk(self.source_dir):
            if not directories:
                language = Language(os.path.basename(root), files)
                language.analyze_language()
                repo.languages.append(language)
        for language in repo.languages:
            print(language)

    def compute_total_snippets(self):
        count = 0
        for language in self.languages:
            count += language.compute_total_snippets()
        return count


class Language:
    def __init__(self, name, file_list):
        self.name = name
        self.file_list = file_list
        self.total_snippets = 0

    def __str__(self):
        return self.name + ": " + str(self.total_snippets)

    def analyze_language(self):
        self.compute_total_snippets()

    def compute_total_snippets(self):
        count = 0
        for file in self.file_list:
            file_name, file_ext = os.path.splitext(file)
            if file_ext not in (".md", ""):
                count += 1
        self.total_snippets = count


repo = Repo()
repo.generate_repo()
