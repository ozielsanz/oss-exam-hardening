#!/bin/bash

version=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f1)
echo "  Hi, you´re using Centos "$version

echo " The installation of the clamav antivirus is running..."
echo " Checking if you have another version installed..."

sudo yum list | grep clamav &> /dev/null

if [ $? -ne 0 ];then
	echo
	sudo yum install -y "https://www.clamav.net/downloads/production/clamav-0.104.1.linux.x86_64.rpm" &> /dev/null
	echo " Clamav antivirus has been installed succesfully"


        else
	echo " We have found another version installed..."
	echo " Proceding to uninstall and install a fresh version..."
	sudo yum remove clamav -y &> /dev/null
	sudo yum install -y "https://www.clamav.net/downloads/production/clamav-0.104.1.linux.x86_64.rpm" &> /dev/null
        echo " Clamav antivirus has been installed succesfully"
    fi 

if [ "$version" -eq 7 ]; then
    echo "Installing  EPEL repositories for CENTOS7 please wait..."
    sudo yum install -y  "https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm" &> /dev/null
    echo "EPEL repositories has been installed succesfully"

fi

echo "Updating all packages with an available update in the repositories..."
sudo yum update -y &> /dev/null
echo "Update is complete."

