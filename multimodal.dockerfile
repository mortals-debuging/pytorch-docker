FROM mortals/codeenv:pytorch2.0-cuda12.0
RUN pip install tensorboard &&\
    pip install rouge-score==0.1.2 &&\
    pip install scipy ortools h5py pyyaml
COPY mynltk.py ./
RUN python3 ./mynltk.py && rm ./mynltk.py