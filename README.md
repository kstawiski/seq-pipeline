# seq-pipeline
NGS pipelines by Konrad Stawiski.



## Start interactive work (Docker-based IDEs):

This is the Docker image with VSCode, RStduio and Jupyter Notebook running. Great for development.

```
docker pull ghcr.io/kstawiski/seq-pipeline:main
docker run --rm -d --name kgs24-work -v $(pwd):/work/ -p 26969:80 --privileged -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/kstawiski/seq-pipeline:main
```
### Check tunnel:

```
docker exec kgs24-work cat /tunnel.log
```
### Change password for user konrad:

```
docker exec -it kgs24-work htpasswd /www/.htpasswd konrad
```

## Start new project:

```
git clone https://github.com/kstawiski/seq-pipeline.git .
./work.sh project_name
```

