#! /bin/sh

function echofile()
{
    local filename=$1
    local file_txt

    file_txt=$(tar -zxvf $backup_file "$filename" -O)
    if [[ $? -eq 0 ]]
    then 
        echo $file_txt > "/${filename}"
    fi
    
}

sudo apt-get update
sudo apt-get -y upgrade

# Install Git:
sudo apt-get -y install git

# Install Audio Driver:
sudo apt-get -y install libatlas-base-dev portaudio19-dev

# Install Python and required packages for it:
sudo apt-get -y install python3 python3-pip python3-scipy

# Fallback scipy module if the Pip module fails to install.

sudo apt-get -y install  avrdude arduino arduino-builder jq

sudo apt-get -y install attr samba samba-common-bin samba-common
sudo apt-get -y install dnsmasq hostapd


curl -sSL https://raw.githubusercontent.com/TobKra96/music_led_strip_control/master/setup.sh | sudo bash -s -- -b dev_2.3
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

dest="/home/pi/backup"

backup_file="${dest}/lights-Friday-2-2021.tgz"




# arduino-cli core update-index
# arduino-cli core install esp8266:esp8266
# arduino-cli lib install ArduinoOTA
# arduino-cli lib install "NeoPixelBus by Makuna"


