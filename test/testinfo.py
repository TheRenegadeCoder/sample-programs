import yaml

from jinja2 import Environment, BaseLoader, Template


class ContainerInfo:
    def __init__(self, image, tag, cmd):
        self._image = image
        self._cmd = cmd
        self._tag = tag

    @property
    def image(self):
        return self._image

    @property
    def cmd(self):
        return self._cmd

    @property
    def tag(self):
        return self._tag

    @classmethod
    def from_dict(cls, dictionary):
        return ContainerInfo(dictionary['image'], dictionary['tag'], dictionary['cmd'])


class FolderInfo:
    def __init__(self, extension):
        self._extension = extension

    @property
    def extension(self):
        return self._extension

    @classmethod
    def from_dict(cls, dictionary):
        return FolderInfo(dictionary['extension'])


class TestInfo:
    def __init__(self, container_info, file_info):
        self._container_info = container_info
        self._file_info = file_info

    @property
    def container_info(self):
        return self._container_info

    @property
    def file_info(self):
        return self._file_info

    @classmethod
    def from_dict(cls, dictionary):
        return TestInfo(
            container_info=ContainerInfo.from_dict(dictionary['container']),
            file_info=FolderInfo.from_dict(dictionary['folder'])
        )

    @classmethod
    def from_string(cls, string, source):
        template = Environment(loader=BaseLoader).from_string(string)
        template_string = template.render(source=source)
        info_yaml = yaml.safe_load(template_string)
        return cls.from_dict(info_yaml)
