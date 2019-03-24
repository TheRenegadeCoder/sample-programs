import docker
import shutil
import tempfile


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

        image = cls._get_image(source.test_info.container_info)
        volume_info = {tmp_dir: {'bind': '/src', 'mode': 'rw'}}
        if key not in cls._containers:
            cls._containers[key] = cls._client.containers.run(
                image=image,
                command='sleep 1h',
                working_dir='/src',
                volumes=volume_info,
                detach=True,
            )
        return cls._containers[key]

    @classmethod
    def _get_image(cls, container_info):
        """
        Pull a docker image

        :param container_info: metadata about the image to pull
        :return: a docker image
        """
        return cls._client.images.pull(container_info.image, tag=str(container_info.tag))

    @classmethod
    def _cleanup(cls, source):
        key = source.full_path
        del cls._volume_dis[key]
        del cls._containers[key]
