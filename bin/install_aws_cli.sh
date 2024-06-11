#!/usr/bin/env bash

####################
# Author: Emmanuel Kariithi
# Date: 11/06/2024
#
# This script installs AWS CLI.
#
# Version: 1.0
####################


cd /workspace #Used to avoid installing in the project folder.

# Uninstall AWS CLI if it exists
sudo apt remove awscli

# Delete the AWS CLI file if it exists
rm -f '/workspace/awscliv2.zip'
rm -rf '/workspace/aws'

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Verify credentials
aws sts get-caller-identity

cd $PROJECT_ROOT