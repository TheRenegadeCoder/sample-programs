import os

class Repo:
    def __init__(self):
        self.languages = list()


class Language:
    def __init__(self):
        self.name = None


repo = Repo()

for root, directories, files in os.walk("../archive"):
    if not directories:
        language = Language()
        language.name = os.path.basename(root)
        repo.languages.append(language)

for language in repo.languages:
    print(language.name)