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
    "/home/pi/.arduino15/arduino-cli.yaml"
    "/home/pi/.arduino15/inventory.yaml"
    "/home/pi/.arduino15/library_index.json"
    "/home/pi/.arduino15/package_esp8266com_index.json"
    "/home/pi/.arduino15/package_index.json"
    "/home/pi/.mlsc"
    "/share/.mlsc"
    "/home/pi/.bash*"
    "/home/pi/.profile"
    "/home/pi/.ssh"
    "/home/pi/.git*"
    "/home/pi/.git-credentials"
    "/home/pi/server_scripts/"
    "/etc/X11/openbox/"
)


dest="/home/pi/backup"
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day-2-2021.tgz"

tar -cvpzf $dest/$archive_file ${backup_files[*]}

ls -lh $dest

systemctl start mlsc.service
systemctl start hostapd_cli.service
