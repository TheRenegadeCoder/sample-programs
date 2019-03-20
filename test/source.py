import os
import shutil
import tempfile

import yaml

from test import testinfo
from test.project import ProjectType


class Source:
    """Metadata about a source file"""

    def __init__(self, name, path, test_info_string):
        """Initialize source

        :param name: filename including extension
        :param path: path to the file excluding name
        :param test_info_string: a string in yaml format containing testinfo for a directory
        """
        self._name = name
        self._path = path

        self._test_info = testinfo.TestInfo.from_string(test_info_string, self)

    @property
    def full_path(self):
        """Returns the full path to the source including filename and extension"""
        return os.path.join(self._path, self._name)

    @property
    def path(self):
        """Returns the path to the source excluding name"""
        return self._path

    @property
    def name(self):
        """Returns the name of the source excluding the extension"""
        return os.path.splitext(self._name)[0]

    @property
    def extension(self):
        """Returns the extension of the source"""
        return os.path.splitext(self._name)[1]

    @property
    def test_info(self):
        """Returns parsed TestInfo object"""
        return self._test_info

    def run(self, client, params='', expect_error=False):
        """
        Run the source and return the output

        :param client: a docker client
        :param params: input passed to the source as it's run
        :param expect_error: if set to True container exceptions will be caught and output will still be returned
        :return: the output of running the source
        """
        tmp_dir = tempfile.mkdtemp()
        shutil.copy(self.full_path, tmp_dir)

        image = _get_image(
            client=client,
            container_info=self.test_info.container_info
        )
        volume_info = {tmp_dir: {'bind': '/src', 'mode': 'rw'}}
        result = _run_container(
            client=client,
            image=image,
            container_info=self.test_info.container_info,
            volume_info=volume_info,
            params=params,
            expect_error=expect_error
        )
        shutil.rmtree(tmp_dir, ignore_errors=True)
        return result.decode('utf-8')


def _get_image(client, container_info):
    """
    Pull a docker image

    :param client: a docker client
    :param container_info: metadata about the image to pull
    :return: a docker image
    """
    return client.images.pull(container_info.image, tag=str(container_info.tag))


def _run_container(client, image, container_info, volume_info, params, expect_error):
    """
    Run source inside a container

    :param client: a docker client
    :param image: the image to run
    :param container_info: metadata about the container to run
    :param volume_info: a dictionary or list to configure volumes mounted inside the container
    :param params: input to pass to the source as it is run
    :param expect_error: if set to True container exceptions will be caught and output will still be returned
    :return: the log of the container
    """
    container = client.containers.run(image=image,
                                      command=f'{container_info.cmd} {params}',
                                      working_dir='/src',
                                      remove=not expect_error,
                                      detach=expect_error,
                                      volumes=volume_info)
    if not expect_error:
        return container

    out = b''.join([line for line in container.logs(stdout=True, stderr=True, stream=True, follow=True)])
    container.remove()
    return out


def get_sources(path):
    """
    Walk through a directory and create Source objects

    :param path: path to the directory through which to walk
    :return: a dict where the key is the ProjectType and the value is a list of all the Source objects of that project
    """
    sources = {k: [] for k in ProjectType}
    for root, dirs, files in os.walk(path):
        path = os.path.abspath(root)
        if "testinfo.yml" in files:
            with open(os.path.join(path, 'testinfo.yml'), 'r') as file:
                test_info_string = file.read()
            folder_info = testinfo.FolderInfo.from_dict(yaml.safe_load(test_info_string)['folder'])
            folder_project_names = folder_info.get_project_mappings(include_extension=True)
            for project_type, project_name in folder_project_names.items():
                if project_name in files:
                    source = Source(project_name, path, test_info_string)
                    sources[project_type].append(source)
    return sources
