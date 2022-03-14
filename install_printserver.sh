#! /bin/sh

sudo apt-get update
sudo apt-get -y upgrade
# Install Git:
sudo apt-get -y install git

cat >~/.git-credentials <<EOL
https://bsodergren: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@github.com
EOL

cat >~/.gitconfig <<EOL
[user]
        name = bjorn sodergren
        email = bjorn.sodergren@gmail.com
[git]
        name = bsodergren
[credential]
        helper = store
[core]
        excludesFile = /home/pi/.gitignore
EOL

sudo apt install samba  samba-common samba-common-bin

mkdir ~/repo
cd ~/repo
git clone https://github.com/bsodergren/server_scripts.git

cd server_scripts

sudo cat samba.conf > /etc/samba/smb.conf



