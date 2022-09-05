FROM nvidia/cuda:11.3.0-cudnn8-runtime-ubuntu20.04

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates libjpeg-dev libpng-dev && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64

# This Env setting is aimd to display Linux-original window in Windows through WSLg.
ENV DISPLAY=:0 CODEDIR=/opt/project XDG_RUNTIME_DIR=/usr/lib/

# Create a working directory
RUN mkdir $CODEDIR
WORKDIR $CODEDIR

# Remove all third-party apt sources to avoid issues with expiring keys.
RUN rm -f /etc/apt/sources.list.d/*.list

# Install some basic utilities
RUN apt-get update && apt-get -y --no-install-recommends install sudo git vim traceroute inetutils-ping net-tools curl fontconfig\
    libgl1 libglib2.0-dev libfontconfig libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0  \
    libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libfontconfig1 libdbus-1-3 libx11-6 \
    openssh-server

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tcl-dev tk-dev python-tk python3-tk python3.8 python3-pip\
    && ln -s /usr/bin/python3 /usr/bin/python\
    && rm -f /etc/apt/sources.list.d/*.list

COPY requirements.txt $CODEDIR
# install python packages
RUN python3 -m pip install -r requirements.txt && rm $CODEDIR/requirements.txt

RUN mkdir /usr/share/fonts/userFonts
COPY ./fonts /usr/share/fonts/userFonts
RUN fc-cache -fv

COPY jupyter.sh /usr/bin/

LABEL maintainer="LiJianying <lijianying1998@gmail.com>"

VOLUME ["tmp/data/new"]
CMD ["/bin/bash"]
