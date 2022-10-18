#!/bin/bash

# get current version of pipelines
cd /
git clone https://github.com/kstawiski/seq-pipeline

# set up code-server
# export PASSWORD=konrad
# nohup code-server --password --disable-update-check &
# nohup /ngrok http 8080 --log=stdout > /ngrok.log &

conda init bash
/bin/bash