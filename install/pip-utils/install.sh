#!/usr/bin/env bash

set eu
cd $(dirname $0)

# Install pip
sudo apt install python3-pip
# Upgrade pip first
python3 -m pip install -U pip
# Install utilities
python3 -m pip install -r requirements.txt
