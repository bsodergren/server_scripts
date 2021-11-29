#!/bin/bash



systemctl stop mlsc.service
systemctl stop hostapd_cli.service
backup_files=(
    "/etc/sysctl.conf"
    "/etc/systemd/system/hostapd_cli.service"
    "/usr/share/alsa/alsa.conf"
    "/etc/asound.conf"
    "/etc/sudoers"
    "/etc/dhcpcd.conf"
    "/etc/dnsmasq.conf"
    "/etc/dhcp/"
    "/etc/hostapd/"
    "/etc/samba/"
    "/etc/udev/"
    "/etc/wpa_supplicant/"
    "/home/pi/Arduino/libraries"
    "/home/pi/Arduino/NodeMCU_Client/build/"
    "/home/pi/Arduino/NodeMCU_Client/header.h"
    "/home/pi/Arduino/NodeMCU_Client/NodeMCU_Client.ino"
    "/home/pi/.arduino15/arduino-cli.yaml"
    "/home/pi/.arduino15/inventory.yaml"
    "/home/pi/.arduino15/library_index.json"
    "/home/pi/.arduino15/package_esp8266com_index.json"
    "/home/pi/.arduino15/package_index.json"    
    "/home/pi/bin"
    "/share/.mlsc"
    "/home/pi/.bashrc"
    "/home/pi/.profile"
    "/home/pi/.ssh"
)


dest="/home/pi/backup"
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day-2021.tgz"

tar -cvpzf $dest/$archive_file ${backup_files[*]}

ls -lh $dest

systemctl start mlsc.service
systemctl start hostapd_cli.service
