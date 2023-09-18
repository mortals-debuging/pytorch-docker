## 仓库介绍

欢迎来到这个仓库，这里提供了一个基于 Docker 构建的深度学习框架环境。下面，您将找到有关环境和可用镜像的详细信息：

### 环境配置

- Python 版本：3.8
- PyTorch 版本：2.0
- CUDA 版本：12.0
- cuDNN 版本：8

### WSLg 支持

如果您正在使用 WSLg 并希望在容器中启用图形界面支持，请按照以下步骤操作：

1. 在开始之前，请确保您的 WSL 的 `/tmp/.X11-unix` 目录已链接到 `mnt\wslg\.X11-unix`。这是确保容器能够访问 X11 Unix 套接字的重要步骤。
2. 启动容器时，请添加以下命令以将 X11 Unix 套接字挂载到容器中：

```Shell
-v \\wsl$\Ubuntu-20.04\mnt\wslg\.X11-unix:/tmp/.X11-unix 
```

### 可用镜像

#### 1. PyTorch 2.0 环境（基于 CUDA 12.0）

这个镜像已经预装了 PyTorch 2.0，与 CUDA 12.0 兼容。请注意，由于包含了 PyTorch 2.0，镜像相对较大，大约占用 9.35GB 的磁盘空间。

**Docker Pull 命令：**

```Shell
docker pull mortals/codeenv:pytorch2.0-cuda12.0
```

#### 2. Miniconda 环境（基于 CUDA 12.0，无 PyTorch）

这个镜像包含 Miniconda 并适用于 CUDA 12.0，但不包含预装的 PyTorch。镜像大小约为 4.85GB。

**Docker Pull 命令：**

```Shell
docker pull mortals/codeenv:conda-cuda12.0
```

#### 3. Miniconda 环境（基于 CUDA 11.8）

此镜像与 CUDA 11.8 兼容，镜像大小约为 3.78GB。

**Docker Pull 命令：**

```Shell
docker pull mortals/codeenv:conda-cuda11.8
```

### 包含的脚本

作者在这些镜像中提供了两个方便的脚本，以帮助您配置和启动服务：

- `sshstart.sh`：用于配置 SSH 服务的自启动。在使用这个脚本之前，请确保在容器配置中提前进行了端口映射。SSH 服务端口默认设置为 22。
- `jupyter.sh`：用于启动 Jupyter 服务。同样，请在容器配置中提前进行端口映射，Jupyter 服务端口默认设置为 8888。

这些脚本可以帮助您更轻松地管理和访问容器中的服务。如果您需要更多详细信息或有任何其他问题，请随时联系我们。