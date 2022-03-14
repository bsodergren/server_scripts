#!/bin/bash
HOME_DIR="/home/pi"
SOURCE_DIR="${HOME_DIR}/repo/server_scripts"

function addGit()
{

cat > "${HOME_DIR}/.git-credentials" <<EOL
https://bsodergren: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@github.com
EOL

cat > "${HOME_DIR}/.gitconfig" <<EOL
[user]
        name = bjorn sodergren
        email = bjorn.sodergren@gmail.com
[git]
        name = bsodergren
[credential]
        helper = store
[core]
        excludesFile = ${HOME_DIR}/.gitignore
EOL

    mkdir "${HOME_DIR}/repo"
    cd "${HOME_DIR}/repo"

    git clone https://github.com/bsodergren/server_scripts.git
}


function addPlugins()
{
    while read -r line
    do
        ${HOME_DIR}/oprint/bin/pip install $line

    done < "${SOURCE_DIR}/config/plugins.list"
}

function addAliases()
{
    if [ ! -f "${HOME_DIR}/.bash_aliases" ]; then
        cp "${SOURCE_DIR}/config/aliases.bash" "${HOME_DIR}/.bash_aliases"
        source ~/.bashrc
    fi
}

function addSambaConf()
{
    sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.bk
    sudo cp ${SOURCE_DIR}/config/samba.conf > /etc/samba/smb.conf

    if [ -f "${SOURCE_DIR}/install_wsdd.sh" ]; then
        . ${SOURCE_DIR}/install_wsdd.sh
    fi


    echo "Add pi user using smbpasswd"
}

function updateApt()
{

#    sudo apt-get update
#    sudo apt-get -y upgrade
    # Install Git:
    sudo apt-get -y install git exa  samba  samba-common samba-common-bin

}

updateApt
addGit

if [ -d "${SOURCE_DIR}" ]; then
    cd "${SOURCE_DIR}"

    addSambaConf
    addAliases
    addPlugins
fi





