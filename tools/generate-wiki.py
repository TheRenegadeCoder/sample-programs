import os


class Repo:
    def __init__(self):
        self.source_dir = "../archive"
        self.languages = list()

    def generate_repo(self):
        for root, directories, files in os.walk(self.source_dir):
            if not directories:
                language = Language()
                language.name = os.path.basename(root)
                language.file_list = files
                language.num_of_snippets = language.compute_total_snippets()
                repo.languages.append(language)
        for language in repo.languages:
            print(language.name + ": " + str(language.num_of_snippets))

    def compute_total_snippets(self):
        count = 0
        for language in self.languages:
            count += language.compute_total_snippets()
        return count


class Language:
    def __init__(self):
        self.name = None
        self.file_list = list()
        self.total_snippets = 0

    def compute_total_snippets(self):
        count = 0
        for file in self.file_list:
            file_name, file_ext = os.path.splitext(file)
            if file_ext not in (".md", ""):
                count += 1
        return count


repo = Repo()
repo.generate_repo()
