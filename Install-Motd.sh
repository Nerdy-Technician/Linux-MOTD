#!/bin/sh

#Check for Updates first

#Update the package list
sudo apt-get update -y

#Upgrade the system
sudo apt-get upgrade -y

#Install MOTD Dependencies
#List of software to install

SoftwareList="figlet"

for Software in $SoftwareList
do
  if [ $(dpkg-query -W -f='${Status}' $Software 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
    sudo apt-get install $Software -y
  fi
done

#move motd to /etc/motd

sudo cp /etc/motd /etc/motd.bak
sudo cp ./motd /etc/motd/motd

#add motd to bash_profile
#check if .bash_profile exists
if [ -f ~/.bash_profile ];
then
  echo "if [ -f /etc/motd/motd ]; then cat /etc/motd/motd; fi" >> ~/.bash_profile
else
  echo "if [ -f /etc/motd/motd ]; then cat /etc/motd/motd; fi" >> ~/.bashrc
fi

#copy color script /etc/motd/
sudo cp ./colors.txt /etc/motd/colors.txt

