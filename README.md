# Welcome to seq-pipeline!
Workspace for data science projects and NGS pipelines by Konrad Stawiski. Contains everything you can imagine. Can connect to tailscale network to bypass firewalls. [Also contains OmicSelector preinstalled.](https://biostat.umed.pl/OmicSelector)

![Screenshot](https://github.com/kstawiski/seq-pipeline/blob/main/www/Screenshot%202022-11-02%20142553.png?raw=true)

## Start to work:

This is the Docker image with VSCode, RStudio, Jupyter Notebook and file manager running. Great for development.

```
docker pull kstawiski/seq-pipeline
docker run --rm -d --name kgs24-work --hostname $(hostname)-work -v $(pwd):/work/ -p 26969:80 --privileged -v /var/run/docker.sock:/var/run/docker.sock kstawiski/seq-pipeline
```

Command above mounts your working directory as `/work`. Just go to `http://localhost:26969` to start work or setup tunnel as below.

### Nvidia CUDA:

For NVIDIA CUDA support use `kstawiski/seq-pipeline-gpu` image:

```
docker pull kstawiski/seq-pipeline
docker run --rm -d --gpus all --name kgs24-work --hostname $(hostname)-work -v $(pwd):/work/ -p 26969:80 --privileged -v /var/run/docker.sock:/var/run/docker.sock kstawiski/seq-pipeline-gpu
```
### Setup tunnel:

You need your free Tailscale network ID `XXX`, than run:

```
docker exec kgs24-work tailscale up --advertise-exit-node --accept-routes --authkey=XXX
```

Authkey setup - https://login.tailscale.com/admin/settings/keys

Alternatively, you can use ngrok, e.g. `/ngrok http 8080 --log=stdout > /ngrok.log &` (may require ngrok setup, ngrok is located in `/ngrok`).

## Start new project:

Alternatively, you can set up directory for projects and operate using delivered pipelines and scripts:

```
git clone https://github.com/kstawiski/seq-pipeline.git .
./work.sh project_name
```

# Pipelines

- Whole Exome Sequencing (tumor only somatic mutations) - TO DO

# Tools used (credits)

- RStudio - https://www.rstudio.com/
- Jupyter Notebook - https://jupyter.org/
- VSCode - https://code.visualstudio.com/, https://github.com/coder/code-server
- Terminal is based on https://github.com/jcubic/jsh.php
- Resources monitor uses https://github.com/DanielnetoDotCom/ServerMonitor 