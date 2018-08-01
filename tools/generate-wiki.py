import os

class Repo:
    def __init__(self):
        self.languages = list()


class Language:
    def __init__(self):
        self.name = None
        self.num_of_snippets = 0


def compute_num_of_snippets(file_list):
    count = 0
    for file in file_list:
        file_name, file_ext = os.path.splitext(file)
        if file_ext not in (".md", ""):
            count += 1
    return count


repo = Repo()

for root, directories, files in os.walk("../archive"):
    if not directories:
        language = Language()
        language.name = os.path.basename(root)
        language.num_of_snippets = compute_num_of_snippets(files)
        repo.languages.append(language)

for language in repo.languages:
    print(language.name + ": " + str(language.num_of_snippets))