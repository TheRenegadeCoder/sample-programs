import docker
import shutil
import tempfile

from datetime import datetime, timedelta
from uuid import uuid4 as uuid


class Singleton(type):
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            instance = super().__call__(*args, **kwargs)
            cls._instances[cls] = instance
        return cls._instances[cls]


class ContainerFactory:
    _containers = {}
    _volume_dis = {}
    _client = docker.from_env()
    _api_client = _client.api

    @classmethod
    def get_container(cls, source):
        """
        Returns a running container for a give source. This will return an existing container if one exists
        or create a new one if necessary

        :param source: the source to use inside the container
        :return: a running container specific to the source
        """
        key = source.full_path

        tmp_dir = tempfile.mkdtemp()
        shutil.copy(source.full_path, tmp_dir)
        cls._volume_dis[key] = tmp_dir

        image = cls.get_image(source.test_info.container_info)
        volume_info = {tmp_dir: {'bind': '/src', 'mode': 'rw'}}
        if key not in cls._containers:
            cls._containers[key] = cls._client.containers.run(
                image=image,
                name=f'{source.name}_{uuid().hex}',
                command='sleep 1h',
                working_dir='/src',
                volumes=volume_info,
                detach=True,
            )
        return cls._containers[key]

    @classmethod
    def get_image(cls, container_info, quiet=False):
        """
        Pull a docker image

        :param container_info: metadata about the image to pull
        :param quiet: whether to print output while downloading
        :return: a docker image
        """
        images = cls._client.images.list(name=f'{container_info.image}:{str(container_info.tag)}')
        if len(images) == 1:
            return images[0]
        if not quiet:
            print(f'Pulling {container_info.image}:{container_info.tag}...', end='')
        last_update = datetime.now()
        for _ in cls._api_client.pull(
                repository=container_info.image,
                tag=str(container_info.tag),
                stream=True,
                decode=True
        ):
            #if datetime.now() - last_update > timedelta(seconds=5) and not quiet:
            #    print(' ...', end='')
            #    last_update = datetime.now()
            if not quiet:
                print('.', end='')
        if not quiet:
            print('done')
        images = cls._client.images.list(name=f'{container_info.image}:{str(container_info.tag)}')
        if len(images) == 1:
            return images[0]

    @classmethod
    def cleanup(cls, source):
        """
        Cleanup docker container and temporary folder. Also remove both from their
        respective dictionaries

        :param source: source for determining what to cleanup
        """
        key = source.full_path

        cls._containers[key].remove(v=True, force=True)
        shutil.rmtree(cls._volume_dis[key], ignore_errors=True)

        del cls._volume_dis[key]
        del cls._containers[key]
