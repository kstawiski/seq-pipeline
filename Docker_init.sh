#!/bin/bash

# get current version of pipelines
cd /
git clone https://github.com/kstawiski/seq-pipeline

# set up code-server
# export PASSWORD=konrad
# nohup code-server --password --disable-update-check &
# nohup /ngrok http 8080 --log=stdout > /ngrok.log &

cp /www/f_config.php /www/f/config.php

mkdir -p /run/
mkdir -p /run/php/

ln -s /work /root/work

conda init bash

curl -s https://install.zerotier.com | bash || true
nohup zerotier-one >/dev/null 2>&1
sleep 5
zerotier-cli join b15644912ef91ff6

/bin/bash