#!/bin/bash
sudo add-apt-repository -y ppa:alessandro-strada/ppa && sudo apt update && sudo apt-get -y install google-drive-ocamlfuse

google-drive-ocamlfuse

mkdir /drive
google-drive-ocamlfuse /drive