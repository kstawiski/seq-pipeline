# Welcome to seq-pipeline!
Workspace for data science projects and NGS pipelines by Konrad Stawiski. Contains everything you can imagine. Can connect to tailscale network to bypass firewalls.

![Screenshot](https://github.com/kstawiski/seq-pipeline/blob/main/www/Screenshot%202022-11-01%20105955.png?raw=true)

## Start to work:

This is the Docker image with VSCode, RStudio, Jupyter Notebook and file manager running. Great for development.

```
docker pull kstawiski/seq-pipeline
docker run --rm -d --name kgs24-work --hostname $(hostname)-work -v $(pwd):/work/ -p 26969:80 --privileged -v /var/run/docker.sock:/var/run/docker.sock kstawiski/seq-pipeline
```

Command above mounts your working directory as `/work`. Just go to `http://localhost:26969` to start work or setup tunnel as below.

### Setup tunnel:

You need your free Tailscale network ID `XXX`, than run:

```
docker exec kgs24-work tailscale up --advertise-exit-node --accept-routes --authkey=XXX
```

Authkey setup - https://login.tailscale.com/admin/settings/keys

## Start new project:

Alternatively, you can set up directory for projects and operate using delivered pipelines and scripts:

```
git clone https://github.com/kstawiski/seq-pipeline.git .
./work.sh project_name
```

# Pipelines

- Whole Exome Sequencing (tumor only somatic mutations) - TO DO