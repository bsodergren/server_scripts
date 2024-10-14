#!/bin/bash

dest="$HOME/backup"
sqlBackup="$dest/SQL"

date=$(date +%F)

hostname=$(hostname -s)

archive_file="$dest/$hostname-$date.tgz"


[ -e $archive_file ] && rm -- $archive_file

backup_files=(
    "/etc/apache2/conf-available/cwp_apache.conf"
    "/etc/apache2/conf-available/plex_apache.conf"
    "/etc/apache2/sites-available/000-default.conf"
    "$HOME/.bash*"
    "$HOME/.profile"
    "$HOME/.ssh"
    "$HOME/.git*"
    "$HOME/.config/yt-dlp/config"
    "$HOME/.git-credentials"
    "$HOME/.my.cnf"

    "$sqlBackup/*"
)

envFiles=$(find ~/scripts ~/www -iname ".env*")
iniFiles=$(find ~/scripts ~/www -iname "config.ini")

mysqldump --routines plex_web >"$sqlBackup/plexweb.sql"
mysqldump --routines cwp >"$sqlBackup/cwp.sql"

tar -cvpzf $archive_file ${backup_files[*]} ${envFiles[*]} ${iniFiles[*]}
