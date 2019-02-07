#!/bin/env bash
# $Id: bootloader.sh,v 0.1 2016/04/10 $ $Author: Pietro Bonaccorso $

# create group if not exists
# getent group $APP_GROUP || groupadd $APP_GROUP

#create application user if not exists and assig it to the specified application group
# id -u $APP_USER &>/dev/null || adduser -D -s /bin/bash $APP_USER $APP_GROUP


#create application folder if not exists
if ! [[ -d $APP_CWD ]] ; then mkdir -p $APP_CWD ; fi

#assign user and group permission to application folder
# chown $APP_USER:$APP_GROUP $APP_CWD

for var in $(printenv); do

    #explode vars to retrive key/value pairs
    IFS='=' read -r -a array <<< $var

    export KEY=${array[0]}

    if [[ $KEY =~ VHOST_|PHP_|FPM_ ]]; then

        export VALUE=${array[1]}

        sed -i -e 's|<'$KEY'>|'$VALUE'|g' "$PHPFPM_CONF_DIR/php-fpm.conf"
        sed -i -e 's|<'$KEY'>|'$VALUE'|g' "$NGINX_CONF_DIR/default.conf"
        sed -i -e 's|<'$KEY'>|'$VALUE'|g' "$PHP_INI_DIR/php.ini"

    fi

done