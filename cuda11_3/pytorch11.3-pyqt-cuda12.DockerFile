#
#由于docker镜像一般都是最精简的，所以会有一些必要的运行库缺失，本镜像补充安装了缺失的运行库。
#这里已经提前安装了Jupyter和SSH启动配置。
#终端中输入 sshstart.sh 即可开启ssh服务。输入runjupyter.sh 即可开启jupyter服务。
#
FROM nvidia/cuda:11.3.0-cudnn8-runtime-ubuntu20.04

ENV NVIDIA_VISIBLE_DEVICES=all NVIDIA_DRIVER_CAPABILITIES=compute,utility\
    LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64

# This Env setting is aimd to display Linux-original window in Windows through WSLg.
ENV DISPLAY=:0 CODEDIR=/opt/project XDG_RUNTIME_DIR=/usr/lib/

# Create a working directory
RUN mkdir $CODEDIR
WORKDIR $CODEDIR

# Remove all third-party apt sources to avoid issues with expiring keys.
RUN rm -f /etc/apt/sources.list.d/*.list && rm -rf /var/lib/apt/lists/*

# Install some basic utilities
RUN apt-get update --fix-missing && apt-get -y --no-install-recommends install  ca-certificates libjpeg-dev libpng-dev\
    sudo git vim traceroute inetutils-ping net-tools curl fontconfig\
    libgl1 libglib2.0-dev libfontconfig libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0  \
    libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libfontconfig1 libdbus-1-3 libx11-6 \
    openssh-server htop python3-pip

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tcl-dev tk-dev python-tk python3-tk \
    && ln -s /usr/bin/python3 /usr/bin/python\
    && rm -f /etc/apt/sources.list.d/*.list

COPY pyqt5-requirements.txt $CODEDIR
# install qt5 python packages
RUN python3 -m pip install -r pyqt5-requirements.txt && rm $CODEDIR/pyqt5-requirements.txt

# install pytorch
RUN python3 -m pip install torch==1.11.0+cu113 torchvision==0.12.0+cu113 torchtext==0.12.0 --extra-index-url https://download.pytorch.org/whl/cu113

RUN mkdir /usr/share/fonts/userFonts
COPY ../fonts /usr/share/fonts/userFonts
RUN fc-cache -fv

COPY requirements.txt ./
RUN pip install -r requirements.txt && rm ./requirements.txt &&\
    pip install jupyter-tensorboard
COPY *.sh /usr/local/bin/

LABEL maintainer="LiJianying <lijianying1998@gmail.com>"

RUN rm -r /opt/nvidia/

ENTRYPOINT ["/usr/bin/env"]

CMD ["bash"]
