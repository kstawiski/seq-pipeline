# seq-pipeline
NGS pipelines by Konrad Stawiski.



## Start interactive work (Docker-based IDEs):

This is the Docker image with VSCode, RStduio and Jupyter Notebook running. Great for development.

```
docker pull kstawiski/seq-pipeline
docker run --rm -d --name kgs24-work --hostname $(hostname)-work -v $(pwd):/work/ -p 26969:80 --privileged -v /var/run/docker.sock:/var/run/docker.sock kstawiski/seq-pipeline
```
### Check tunnel:

```
docker exec kgs24-work cat /tunnel.log
```

## Start new project:

```
git clone https://github.com/kstawiski/seq-pipeline.git .
./work.sh project_name
```

