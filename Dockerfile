FROM php:fpm-alpine

LABEL mantainer="Pietro Bonaccorso 'bonaccorso.p@gmail.com'"
LABEL description='This image embeds Nginx 1.14.2 and php-fpm using PHP 7.3'

ENV \
PHPFPM_CONF_DIR='/usr/local/etc' \
NGINX_CONF_DIR='/etc/nginx/conf.d' \
APP_CWD='/app/code' \
PHP_MAXEXECUTIONTIME='30' \
PHP_MEMORYLIMIT='128M' \
PHP_DISPLAYERRORS='Off' \
PHP_DISPLASTARTUPERRORS='Off' \
PHP_ERRORREPORTING='E_ALL & ~E_DEPRECATED & ~E_STRICT' \
PHP_VARIABLESORDER='GPCS' \
PHP_POSTMAXSIZE='8M' \
PHP_UPLOADMAXFILESIZE='2M' \
PHP_SHORTOPENTAG='Off' \
FPM_CLEARENV='no' \
FPM_LISTEN='127.0.0.1:9000' \
FPM_USER='www-data' \
FPM_GROUP='www-data' \
VHOST_ROOT='/app/code' \
VHOST_INDEX='index.php'


#install supervisord
RUN apk --update add supervisor nginx bash git && mkdir -p /run/nginx

#install composer
RUN wget https://getcomposer.org/composer.phar -O /usr/bin/composer && chmod +x /usr/bin/composer

#Add configuration files
COPY . /docker

# remove apk cache
RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*

# Install common php extensions
RUN docker-php-ext-install pdo_mysql tokenizer

# Copy configuration templates
RUN cp /docker/configuration/php-fpm.conf "$PHPFPM_CONF_DIR/php-fpm.conf"
RUN cp /docker/configuration/default.conf "$NGINX_CONF_DIR/default.conf"
RUN cp /docker/configuration/php.ini "$PHP_INI_DIR/php.ini"

# Expose ports
EXPOSE 80 443

WORKDIR $APP_CWD

ENTRYPOINT ["bash", "/docker/scripts/entrypoint.sh"]
CMD ["start-stack"]




