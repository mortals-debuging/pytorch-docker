****[中文](./README_cn.md)****
## Repository Introduction

Welcome to this repository, which provides a Docker-based environment for deep learning frameworks. Below, you'll find detailed information about the environment and available images:

### Environment Configuration

- Python Version: 3.8
- PyTorch Version: 2.0
- CUDA Version: 12.0
- cuDNN Version: 8

### WSLg Support

If you are using WSLg and wish to enable graphical interface support within the container, follow these steps:

1. Before getting started, ensure that your WSL's `/tmp/.X11-unix` directory is linked to `mnt\wslg\.X11-unix`. This is a crucial step to allow the container to access X11 Unix sockets.
2. When starting the container, add the following command to mount the X11 Unix sockets into the container:

```shell
-v \\wsl$\Ubuntu-20.04\mnt\wslg\.X11-unix:/tmp/.X11-unix 
```

### Available Images

#### 1. PyTorch 2.0 Environment (Based on CUDA 12.0)

This image comes pre-installed with PyTorch 2.0 and is compatible with CUDA 12.0. Please note that due to the inclusion of PyTorch 2.0, the image size is relatively large, occupying approximately 9.35GB of disk space.

**Docker Pull Command:**

```shell
docker pull mortals/codeenv:pytorch2.0-cuda12.0
```

#### 2. Miniconda Environment (Based on CUDA 12.0, Without PyTorch)

This image includes Miniconda and is suitable for CUDA 12.0, but it does not come with PyTorch pre-installed. The image size is around 4.85GB.

**Docker Pull Command:**

```Shell
docker pull mortals/codeenv:conda-cuda12.0
```

#### 3. Miniconda Environment (Based on CUDA 11.8)

This image is compatible with CUDA 11.8, with an image size of approximately 3.78GB.

**Docker Pull Command:**

```Shell
docker pull mortals/codeenv:conda-cuda11.8
```

### Included Scripts

The author provides two convenient scripts within these images to assist you in configuring and starting services:

- `sshstart.sh`: Used for configuring SSH service auto-start. Ensure that you have performed port mapping in the container configuration before using this script. The SSH service port is set to the default value of 22.
- `jupyter.sh`: Used for launching Jupyter services. Similarly, please configure port mapping in the container configuration in advance, with the default Jupyter service port set to 8888.

These scripts make it easier for you to manage and access services within the container. If you need more detailed information or have any other questions, please feel free to reach out.
