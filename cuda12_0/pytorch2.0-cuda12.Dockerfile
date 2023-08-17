FROM mortals/codeenv:base-cuda12.0

# install python packages
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

COPY requirements.txt ./
RUN pip install -r requirements.txt && rm ./requirements.txt

COPY ../*.sh /usr/local/bin/
