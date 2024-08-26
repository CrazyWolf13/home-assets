#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install update-manager-core -y
sudo do-release-upgrade -d
reboot
