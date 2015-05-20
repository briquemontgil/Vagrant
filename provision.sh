#!/bin/bash
# Author: Jon Klem <jonathonklemp@gmail.com>
# Written for Ubuntu Trusty, should be adaptable to other distros.

## Variables
HOME=/root
DOCKERSCRIPT=/vagrant/connectToDocker.sh
cd $HOME

apt-get update -qq
apt-get install -yq git docker.io

# build our docker container
docker build -t apache2 /home/vagrant

# run it in daemon mode
docker run -d -p 80:80 -v /vagrant:/vagrant1 apache2 /bin/bash

# make sure our script is executable
chmod +x $DOCKERSCRIPT
