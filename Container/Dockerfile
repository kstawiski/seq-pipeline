FROM ubuntu
LABEL maintainer "Konrad Stawiski <konrad@konsta.com.pl>"

ENV DEBIAN_FRONTEND=noninteractive

# Setup Ubuntu
ENV TZ=Europe/Warsaw
RUN chsh -s /bin/bash root && echo 'SHELL=/bin/bash' >> /etc/environment && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && apt update && apt dist-upgrade -y && apt-get install -y pciutils libkmod-dev libgsl-dev libv8-dev mc libglu1-mesa-dev libharfbuzz-dev libfribidi-dev libgit2-dev gdebi uuid apt-transport-https screen libfontconfig1-dev build-essential libxml2-dev xorg ca-certificates cmake curl git libatlas-base-dev libcurl4-openssl-dev libjemalloc-dev liblapack-dev libopenblas-dev libopencv-dev libzmq3-dev software-properties-common sudo unzip wget && add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt update && apt install -y build-essential libmagick++-dev libbz2-dev libpcre2-16-0 libpcre2-32-0 libpcre2-8-0 libpcre2-dev fort77 xorg-dev liblzma-dev  libblas-dev gfortran gcc-multilib gobjc++ libreadline-dev && apt install -y pandoc texinfo texlive-fonts-extra texlive libcairo2-dev freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev libglfw3-dev libgles2-mesa-dev libopenblas-dev liblapack-dev libopencv-dev build-essential git gcc cmake libcairo2-dev libxml2-dev texlive-full texlive-xetex ttf-mscorefonts-installer build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev default-jre default-jdk && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

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
RUN conda install -c conda-forge -c bioconda mamba singularity nextflow

# R:
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -sc)-cran40/" && apt update && apt -y dist-upgrade && apt install -y r-base-dev texlive-full texlive-xetex ttf-mscorefonts-installer r-recommended build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev default-jre default-jdk && Rscript -e "install.packages(c('remotes','devtools','BiocManager','keras','rgl','rJava','data.table','dplyr'))"

# Google Cloud for Terra
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y

# Copy pipelines
COPY WES_TumorOnly /WES_TumorOnly



ENTRYPOINT ["/bin/bash"]