#!/bin/bash

sudo yum -y install amazon-efs-utils
sudo mkdir /mnt/shared
fs_id="${fs_id}"
sudo mount -t efs -o tls,iam $fs_id:/ /mnt/shared