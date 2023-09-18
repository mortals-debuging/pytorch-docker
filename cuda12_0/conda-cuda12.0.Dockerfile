FROM mortals/codeenv:base-cuda12.0

# Install conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_23.1.0-1-Linux-x86_64.sh --output-document=miniconda.sh\
    && bash miniconda.sh -b -p /opt/conda && rm -f miniconda.sh

RUN /opt/conda/bin/conda clean -tipy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

ENV PATH /opt/conda/bin:$PATH

RUN conda init bash

COPY ../*.sh /usr/local/bin/
