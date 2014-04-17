#!/usr/bin/env bash
#
# This shell script prepares a Ubuntu environment to execute Chef-solo. At its core,
# it installs Chef & Ruby then clones itself and executes Chef-solo.

# Update package repository
sudo apt-get update -y

# Install curl (useful)
sudo apt-get -y install curl

# Install build essentials
sudo apt-get -y install build-essential curl zlib1g-dev libssl-dev openssl libreadline-gplv2-dev libyaml-dev 

# Install XML tools (necessary for Nokogiri and Gollum gem)
sudo apt-get -y install libxslt-dev libxml2-dev

# Install Git
sudo apt-get -y install git-core

# Install Chef
curl -L https://www.opscode.com/chef/install.sh | sudo bash

# Install RVM (Single-user)
curl -L https://get.rvm.io | bash -s -- --version 1.24.4
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
source "$HOME/.rvm/scripts/rvm"

# Install Ruby (via RVM)
rvm install 1.9.3
rvm use 1.9.3 --default