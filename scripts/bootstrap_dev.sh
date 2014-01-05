#!/bin/bash

# update os
sudo apt-get -y update
sudo apt-get upgrade

# install python 3.3 from ppa
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:fkrull/deadsnakes
sudo apt-get update
sudo apt-get install -y build-essential python3.3-dev

# install postgres and postgis from postgres repo
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list'
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y Postgresql-9.3-postgis postgresql-server-dev-9.3

# install geo libs
sudo apt-get install -y binutils libproj-dev gdal-bin

# install dev tools
sudo apt-get install -y vim-nox git

# create venv and install packaging tools and requirements
VENV=/home/vagrant/venv
pyvenv-3.3 $VENV
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | $VENV/bin/python
wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O - | $VENV/bin/python
$VENV/local/bin/pip install -r /vagrant/requirements/dev.txt
echo "export PATH=$VENV/local/bin:\$PATH" >> /home/vagrant/.bashrc
echo "source $VENV/bin/activate" >> /home/vagrant/.bashrc

# set db user password and create database
sudo -u postgres psql -c "ALTER ROLE postgres WITH ENCRYPTED PASSWORD 'geodjango';"
sudo -u postgres createdb geodjango
sudo -u postgres psql -d geodjango -c "CREATE EXTENSION postgis;"

