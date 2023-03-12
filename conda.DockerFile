FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04

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
    sudo git vim traceroute inetutils-ping net-tools curl fontconfig wget\
    libgl1 libglib2.0-dev libfontconfig libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0  \
    libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libfontconfig1 libdbus-1-3 libx11-6 \
    openssh-server htop

RUN mkdir /usr/share/fonts/userFonts
COPY ./fonts /usr/share/fonts/userFonts
RUN fc-cache -fv

COPY sshstart.sh /usr/bin/

# Install conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_23.1.0-1-Linux-x86_64.sh --output-document=miniconda.sh\
    && bash miniconda.sh -b -p /opt/conda && rm -f miniconda.sh

RUN /opt/conda/bin/conda clean -tipy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

ENV PATH /opt/conda/bin:$PATH

RUN conda init bash

LABEL maintainer="LiJianying <lijianying1998@gmail.com>"

RUN rm -r /opt/nvidia/

ENTRYPOINT ["/usr/bin/env"]

CMD ["bash"]
