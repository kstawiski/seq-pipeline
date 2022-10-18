FROM ubuntu:focal
LABEL maintainer "Konrad Stawiski <konrad@konsta.com.pl>"

ENV DEBIAN_FRONTEND=noninteractive

# Setup Ubuntu
ENV TZ=Europe/Warsaw
RUN chsh -s /bin/bash root && echo 'SHELL=/bin/bash' >> /etc/environment && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && apt update && apt dist-upgrade -y && apt-get install -y pciutils libkmod-dev libgsl-dev libv8-dev mc nano libglu1-mesa-dev libharfbuzz-dev libfribidi-dev libgit2-dev gdebi uuid apt-transport-https screen libfontconfig1-dev build-essential libxml2-dev xorg ca-certificates cmake curl git libatlas-base-dev libcurl4-openssl-dev libjemalloc-dev liblapack-dev libopenblas-dev libzmq3-dev software-properties-common sudo unzip wget && add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt update && apt install -y build-essential libmagick++-dev libbz2-dev libpcre2-16-0 libpcre2-32-0 libpcre2-8-0 libpcre2-dev fort77 xorg-dev liblzma-dev  libblas-dev gfortran gcc-multilib gobjc++ libreadline-dev && apt install -y libcairo2-dev freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev libglfw3-dev libgles2-mesa-dev libopenblas-dev liblapack-dev build-essential git gcc cmake libcairo2-dev libxml2-dev build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev awscli libsquashfuse-dev supervisor

# Install Anaconda
ENV PATH /opt/conda/bin:$PATH
ENV SHELL /bin/bash
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
RUN rm Miniconda3-latest-Linux-x86_64.sh &&\
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
ENV TENSORFLOW_PYTHON /opt/conda/bin/python
ENV RETICULATE_PYTHON /opt/conda/bin/python
RUN conda config --add channels defaults && conda config --add channels bioconda && conda config --add channels conda-forge && conda config --set channel_priority strict && conda install -c conda-forge -c bioconda mamba

# Install common tools:
RUN mamba install -c bioconda -c conda-forge nextflow && apt-get -y install awscli samtools bcftools

# R:
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -sc)-cran40/" && apt update && apt -y dist-upgrade && apt install -y r-base-dev r-recommended build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev && Rscript -e "install.packages(c('data.table','dplyr'))"

# Google Cloud for Terra
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y && export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s` && echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && apt-get update && apt-get install gcsfuse -y

# Get docker for docker in docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sudo bash get-docker.sh && rm get-docker.sh

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Ngrok
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && tar xvzf ngrok-v3-stable-linux-amd64.tgz && rm ngrok-v3-stable-linux-amd64.tgz && ./ngrok config add-authtoken 2GJj2YAtqhxPapAatx2QxqfKn61_5PRMDpMj5n9vwMrtCeMNe 

# Signularity - get new from https://github.com/sylabs/singularity/releases
RUN wget https://github.com/sylabs/singularity/releases/download/v3.10.3/singularity-ce_3.10.3-focal_amd64.deb && apt -y install ./singularity-ce_3.10.3-focal_amd64.deb && rm ./singularity*.deb

# Charliecloud
# RUN sysctl -w kernel.unprivileged_userns_clone=1 && wget https://github.com/hpc/charliecloud/releases/download/v0.29/charliecloud-0.29.tar.gz && tar xvzf charliecloud-0.29.tar.gz && rm charliecloud-0.29.tar.gz && cd charliecloud-0.29 && ./autogen.sh && ./configure && make && make install

ADD Docker_init.sh /
RUN chmod +x /Docker_init.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8080
CMD["/usr/bin/supervisord"]