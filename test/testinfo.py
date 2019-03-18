import os
import tempfile
import shutil

import pytest
import docker
import yaml

from jinja2 import Environment, BaseLoader, Template


class Container:
    def __init__(self, image, cmd):
        self._image = image
        self._cmd = cmd

    @property
    def image(self):
        return self._image

    @property
    def cmd(self):
        return self._cmd

    @classmethod
    def from_test_info(cls, test_info):
        container_info = test_info['container']
        return Container(container_info['image'], container_info['cmd'])


def get_test_info_map(test_info):
    info_map = {}
    for info in test_info:
        with open(info.full_path) as file:
            info_map[info.path] = file.read()
    return info_map


def load_test_info(source, info_map):
    template = Environment(loader=BaseLoader).from_string(info_map[source.path])
    template_string = template.render(source=source)
    return yaml.load(template_string)


