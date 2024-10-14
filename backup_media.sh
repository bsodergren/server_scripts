#!/bin/bash

dest="$HOME/OneDrive/UbuntuBackup"
sqlBackup="$HOME"
plexSql="$sqlBackup/plex_web.sql"
cwpSql="$sqlBackup/cwp.sql"

date=$(date +%F)

hostname=$(hostname -s)

archive_file="$dest/$hostname-$date.tgz"


[ -e $archive_file ] && rm -- $archive_file
[ -e $plexSql ] && rm -- $plexSql
[ -e $cwpSql ] && rm -- $cwpSql

mysqldump --routines plex_web > $plexSql
mysqldump --routines cwp > $cwpSql

backup_files=(
    "/etc/apache2/conf-available/cwp_apache.conf"
    "/etc/apache2/conf-available/plex_apache.conf"
    "/etc/apache2/sites-available/000-default.conf"
    "$HOME/.bash*"
    "$HOME/.profile"
    "$HOME/.ssh"
    "$HOME/.git*"
    "$HOME/.config/yt-dlp"
    "$HOME/.git-credentials"
    "$HOME/.my.cnf"
    "$HOME/.config/onedrive"
    "$HOME/.config/gh"
    "$cwpSql"
    "$plexSql"
)

envFiles=$(find ~/scripts ~/www -iname ".env*")
iniFiles=$(find ~/scripts ~/www -iname "config.ini")



tar -cvpzf $archive_file ${backup_files[*]} ${envFiles[*]} ${iniFiles[*]}

onedrive -s --upload-only