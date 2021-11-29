#! /bin/sh

prompt -i "\n[1/4] Updating and installing required packages..."
sudo apt-get update
sudo apt-get -y upgrade


# Install Git:
sudo apt-get -y install git

# Install Audio Driver:
sudo apt-get -y install libatlas-base-dev portaudio19-dev

# Install Python and required packages for it:
sudo apt-get -y install python3 python3-pip python3-scipy

# Fallback scipy module if the Pip module fails to install.

sudo apt-get -y install  avrdude arduino arduino-builder jq hostapd

sudo apt-get -y install attr samba samba-common-bin samba-common
sudo apt-get -y install dnsmasq dnsmasq-base

curl -sSL https://raw.githubusercontent.com/TobKra96/music_led_strip_control/master/setup.sh | sudo bash -s -- -b dev_2.3

# Upgrade Pip to the latest version.
sudo pip3 install --no-input --upgrade pip
sudo pip3 install --no-input -r requirements.txt
