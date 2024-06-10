#!/usr/bin/env bash

####################
# Author: Emmanuel Kariithi
# Date: 10/06/2024
#
# This script installs Terraform CLI automatically without the need of user input.
#
# Version: 1.0
####################

#PROJECT_ROOT='/workspace/TerraTowns' Set an environment varible but since I used `gp env`, this is not needed.

cd /workspace #Used to avoid installing in the project folder.

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform -y

cd $PROJECT_ROOT