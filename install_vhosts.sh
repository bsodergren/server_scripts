#!/bin/bash

CWP_CONF="cwp_apache"
PLEX_CONF="plexweb_apache"
CWP="/home/bjorn/scripts/server_scripts/cwp_apache.conf"
PLEX="/home/bjorn/scripts/server_scripts/plexweb_apache.conf"
APACHE_CONF="/etc/apache2/conf-available"


ln -sf $CWP $APACHE_CONF 
ln -sf $PLEX $APACHE_CONF

a2enconf $CWP_CONF
a2enconf $PLEX_CONF

systemctl reload apache2
