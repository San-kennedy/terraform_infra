#!/bin/bash

hostnamectl set-hostname ${vm_hostname}

sed -i 's/preserve_hostname.*/preserve_hostname: true/' /etc/cloud/cloud.cfg
