FROM nvidia/cuda:12.0.1-cudnn8-devel-ubuntu20.04

# This Env setting is aimd to display Linux-original window in Windows through WSLg.
ENV DISPLAY=:0 CODEDIR=/opt/project XDG_RUNTIME_DIR=/usr/lib/

# Create a working directory
RUN mkdir $CODEDIR
WORKDIR $CODEDIR

# Remove all third-party apt sources to avoid issues with expiring keys.
RUN rm -f /etc/apt/sources.list.d/*.list && rm -rf /var/lib/apt/lists/*

# Install some basic utilities
RUN apt-get update --fix-missing && apt-get upgrade -y  \
    && apt-get -y --no-install-recommends install  ca-certificates libjpeg-dev libpng-dev\
    sudo git vim traceroute inetutils-ping net-tools curl fontconfig\
    libgl1 libglib2.0-dev libfontconfig libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0  \
    libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libfontconfig1 libdbus-1-3 libx11-6 \
    openssh-server htop python3-pip

COPY *.sh /usr/bin/

LABEL maintainer="LiJianying <lijianying1998@gmail.com>"

RUN rm -r /opt/nvidia/

ENTRYPOINT ["/usr/bin/env"]

CMD ["bash"]