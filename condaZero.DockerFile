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
    openssh-server htop

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tcl-dev tk-dev python-tk python3-tk python3.8 python3-pip\
    && ln -s /usr/bin/python3 /usr/bin/python\
    && rm -f /etc/apt/sources.list.d/*.list

RUN mkdir /usr/share/fonts/userFonts
COPY ./fonts /usr/share/fonts/userFonts
RUN fc-cache -fv

COPY sshstart.sh /usr/bin/

# Install conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py38_23.1.0-1-Linux-x86_64.sh --output-document=miniconda.sh\
    && bash miniconda.sh -b -p /opt/conda && rm -f miniconda.sh

RUN /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate mono" >> ~/.bashrc \

ENV PATH /opt/conda/bin:$PATH

RUN conda create -n mono python=3.8 -y

RUN ./root/.bashrc && \
    /opt/conda/bin/conda init bash && \
    conda activate mono && conda info --envs

LABEL maintainer="LiJianying <lijianying1998@gmail.com>"

RUN rm -r /opt/nvidia/

ENTRYPOINT ["/usr/bin/env"]

CMD ["bash"]
