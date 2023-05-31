## Environment
### Tools Version Detail
- Python version 3.8
- Pytorch version 2.0
- Cuda version 12.0
- Cudnn version 8

&nbsp;
## WSL gui Support
This image had installed almost dependency module, but it still acquires a sock file from host machine (Windows).
- Before started please confirm your wsl /tmp/.X11-unix has linked mnt\wslg\.X11-unix.
- When start the container, add following commend to mount the sock file
```Shell
-v \\wsl$\Ubuntu-20.04\mnt\wslg\.X11-unix:/tmp/.X11-unix 
```

## DockerHub
This image has pushed to dockerhub.
&nbsp;
### Docker Pull Command
```Shell
docker pull mortals/codeenv:conda-cuda12.0
```
