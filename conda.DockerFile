FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-devel

# This Env setting is aimd to display Linux-original window in Windows through WSL2.
ENV DISPLAY=:0 CODEDIR=/opt/project XDG_RUNTIME_DIR=/usr/lib/

# Create a working directory
RUN mkdir $CODEDIR && rm -r /workspace/
WORKDIR $CODEDIR

# Remove all third-party apt sources to avoid issues with expiring keys.
RUN rm -f /etc/apt/sources.list.d/*.list

# Install some basic utilities
RUN apt-get update && apt-get -y install sudo git vim traceroute inetutils-ping net-tools curl fontconfig\
    libgl1 libglib2.0-dev libfontconfig libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0  \
    libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libfontconfig1 libdbus-1-3 libx11-6 \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install tcl-dev tk-dev python-tk python3-tk\
    && rm -rf /var/lib/apt/lists/* && rm -f /etc/apt/sources.list.d/*.list

RUN pip uninstall -y matplotlib && pip install matplotlib

RUN mkdir /usr/share/fonts/userFonts
COPY ./fonts /usr/share/fonts/userFonts
RUN fc-cache -fv

RUN pip install pyqt5 pyqt5_tools  &&  \
    pip install tornado tensorboard  \
    visdom imutils matplotlib jupyter jupyter-tensorboard pandas jieba xlrd xlwt openpyxl

COPY jupyter.sh /usr/bin/

LABEL maintainer="LiJianying <lijianying1998@gmail.com>"

VOLUME ["tmp/data/new"]
CMD ["/bin/bash"]