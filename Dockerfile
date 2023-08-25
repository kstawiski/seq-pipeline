FROM ubuntu:focal
LABEL maintainer "Konrad Stawiski <konrad@konsta.com.pl>"

ENV DEBIAN_FRONTEND=noninteractive

# Setup Ubuntu
ENV TZ=Europe/Warsaw
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN chsh -s /bin/bash root && echo 'SHELL=/bin/bash' >> /etc/environment && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && apt update && apt dist-upgrade -y && apt-get install -y pciutils libkmod-dev libgsl-dev libv8-dev mc nano libglu1-mesa-dev libharfbuzz-dev libfribidi-dev libgit2-dev gdebi uuid apt-transport-https screen libfontconfig1-dev openssh-server build-essential libxml2-dev xorg ca-certificates cmake curl git libatlas-base-dev libcurl4-openssl-dev libjemalloc-dev liblapack-dev libopenblas-dev libzmq3-dev software-properties-common sudo unzip wget && add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt update && apt install -y build-essential libmagick++-dev libbz2-dev libpcre2-16-0 libpcre2-32-0 libpcre2-8-0 libpcre2-dev fort77 xorg-dev liblzma-dev  libblas-dev gfortran gcc-multilib gobjc++ libreadline-dev && apt install -y libcairo2-dev freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev libglfw3-dev libgles2-mesa-dev libopenblas-dev liblapack-dev build-essential git gcc cmake openslide-tools g++ gcc libblas-dev liblapack-dev libcairo2-dev libxml2-dev build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev awscli libsquashfuse-dev supervisor default-jdk && mkdir /www && mkdir /work

# CUDA
# RUN CODENAME=$(cat /etc/*-release | grep UBUNTU_CODENAME | cut -d'=' -f 2) && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb && dpkg -i cuda-keyring_1.0-1_all.deb && rm cuda-keyring_1.0-1_all.deb && apt update && apt -y -f install cuda


# Install Anaconda
ENV PATH /opt/conda/bin:$PATH
ENV SHELL /bin/bash
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
RUN rm Miniconda3-latest-Linux-x86_64.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
ENV TENSORFLOW_PYTHON /opt/conda/bin/python
ENV RETICULATE_PYTHON /opt/conda/bin/python
RUN conda config --add channels defaults && conda config --add channels bioconda && conda config --add channels conda-forge && conda config --set channel_priority strict

# Install common tools:
RUN apt-get -y install awscli samtools bcftools && pip3 install dbxfs

# R:
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -sc)-cran40/" && apt update && apt -y dist-upgrade && apt install -y r-base-dev r-recommended build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev && Rscript -e "install.packages(c('data.table','dplyr','devtools', 'languageserver', 'BiocManager'))"

# Google Cloud for Terra
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y && export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s` && echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && apt-get update && apt-get install gcsfuse -y

# Get docker for docker in docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sudo bash get-docker.sh && rm get-docker.sh

# Localtunnel
# RUN curl -sL https://deb.nodesource.com/setup_16.x | bash && apt-get install -y npm && apt-get install -y nodejs && npm install -g localtunnel

# Signularity - get new from https://github.com/sylabs/singularity/releases
RUN wget https://github.com/sylabs/singularity/releases/download/v3.10.3/singularity-ce_3.10.3-focal_amd64.deb && apt -y install ./singularity-ce_3.10.3-focal_amd64.deb && rm ./singularity*.deb

# Rclone
RUN curl https://rclone.org/install.sh | bash

# VSCODE:
RUN curl -fsSL https://code-server.dev/install.sh | sh && code-server --install-extension ms-python.python --force && code-server --install-extension REditorSupport.r --force && code-server --install-extension formulahendry.code-runner --force && code-server --install-extension GrapeCity.gc-excelviewer --force && code-server --install-extension daghostman.vs-treeview --force && code-server --install-extension broadinstitute.wdl-devtools --force && code-server --install-extension Mikhail-Arkhipov.r --force && code-server --install-extension rogalmic.bash-debug --force

# Extentions
RUN  pip install -U scikit-learn xgboost torch pandas numpy nbzip

# RStudio server:
RUN apt-get install -y libclang-dev libssl-dev gdebi-core && wget https://download2.rstudio.org/server/focal/amd64/rstudio-server-2023.06.2-561-amd64.deb -O rstudio.deb && gdebi -n rstudio.deb && apt -f -y install && rm rstudio.deb

# Build GUI
COPY www/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
RUN chsh -s /bin/bash && echo 'export PATH="/opt/conda/bin:$PATH"' >> ~/.bashrc && apt-get install -y --reinstall build-essential apt-utils && add-apt-repository -y ppa:ondrej/php && apt update && apt -y dist-upgrade && apt-get install -y nginx php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap nano apache2-utils nginx-extras libnginx-mod-http-dav-ext libnginx-mod-http-auth-pam sshpass

COPY www/nginx.conf /etc/nginx/nginx.conf
COPY www/php.ini /etc/php/7.3/fpm/php.ini
COPY www/default /etc/nginx/sites-available/default
COPY www/www.conf /etc/php/7.3/fpm/pool.d/www.conf
ADD www /www
COPY .htpasswd /www/.htpasswd

# R packages
# RUN Rscript -e 'devtools::source_url("https://raw.githubusercontent.com/kstawiski/OmicSelector/master/vignettes/setup.R")'

# Tailscale
RUN echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.d/99-tailscale.conf && echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.d/99-tailscale.conf && sysctl -p /etc/sysctl.d/99-tailscale.conf && curl -fsSL https://tailscale.com/install.sh | sh

# File browser
RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# Terminal
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && echo 'export NOTVISIBLE="in users profile"' >> ~/.bashrc && echo "export VISIBLE=now" >> /etc/profile && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && echo 'root:konrad' | chpasswd

# Charliecloud
# RUN sysctl -w kernel.unprivileged_userns_clone=1 && wget https://github.com/hpc/charliecloud/releases/download/v0.29/charliecloud-0.29.tar.gz && tar xvzf charliecloud-0.29.tar.gz && rm charliecloud-0.29.tar.gz && cd charliecloud-0.29 && ./autogen.sh && ./configure && make && make install

# Squid
RUN apt -y install squid && rm -f /etc/squid/squid.conf && wget --no-check-certificate -O /etc/squid/squid.conf https://gist.githubusercontent.com/radenvodka/d26f13fd2f7398d31635bcf17f9330b7/raw/432fbcee54c986248168851263720852a6b11005/squid.conf

ADD Docker_init.sh /
ADD config.yaml /
RUN chmod +x /Docker_init.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 80
EXPOSE 22
CMD ["/usr/bin/supervisord"]
