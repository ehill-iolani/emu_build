# Set the base image to Ubuntu 20.04 LTS
FROM ubuntu:20.04

# Disable prompts during package installation
ENV DEBIAN_FRONTEND noninteractive

# Convenience packages
RUN apt update
RUN apt install -y curl git nano

# Miniconda installation
RUN cd tmp
RUN curl https://repo.anaconda.com/miniconda/Miniconda3-py310_23.3.1-0-Linux-x86_64.sh --output miniconda.sh
RUN bash miniconda.sh -bu
ENV PATH="/root/miniconda3/bin:$PATH"
RUN conda update -y conda

# Setting up the emu file system
RUN mkdir /home/database && \
    pip install osfclient && \
    export EMU_DATABASE_DIR=/home/database && \
    cd ${EMU_DATABASE_DIR} && \
    osf -p 56uf7 fetch osfstorage/emu-prebuilt/emu.tar && \
    tar -xvf emu.tar
    
RUN conda create -y -n emu python=3.10
SHELL ["conda", "run", "-n", "emu", "/bin/bash", "-c"]

# Install emu
RUN conda init && \
    conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda install -y emu && \
    conda install -y seqtk && \
    echo "conda activate emu" >> ~/.bashrc && \
    mkdir /home/data && \
    # Cleanup
    rm miniconda.sh && \
    rm /home/database/emu.tar

RUN echo "export EMU_DATABASE_DIR=/home/database" >> ~/.bashrc
