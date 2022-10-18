#!/bin/bash
git pull
mkdir Analysis
mkdir Results
mkdir Data
mkdir Temp
screen -S $1 docker run --name $1 --rm -it -v $(pwd):/work/ --privileged -v /var/run/docker.sock:/var/run/docker.sock kstawiski/seq-pipeline