# PHP Stack with php-fpm and Nginx 

Build and tested by bonaccorsop

## Usage

using the docker command:
```
docker run --rm \
-p "8080:80"  \
-e "APP_CWD=/app/code" \
-e "VHOST_ROOT=/app/code/public" \
-e "PHP_DISPLAYERRORS=On" \
-e "PHP_ERRORREPORTING=E_ALL" \
-e "FPM_CLEARENV=no" \
-e "MY_ENVIRONMENT=develop" \
-v .../host-code-path/:/app/code \
--name my-lep-container \
bonaccorsop/php-lep:7.3
```

using the docker-compose file:
```
version: '3'
services:
    app-node-name:
        image: bonaccorsop/php-lep:7.3
        ports:
            - "8080:80"
        volumes:
            - ./:/app/code
        environment:
            APP_CWD:  /app/code
            VHOST_ROOT:  /app/code/public
            PHP_DISPLAYERRORS: "On"
            PHP_ERRORREPORTING: E_ALL
            FPM_CLEARENV: "no"
            MY_ENVIRONMENT: develop
```

## Application Environment variables

Variable              | Default Value
--------------------- |  ------------------------------------------------------------------------------
`APP_CWD`          | /app/code
`APP_USER`     | application
`APP_GROUP`     | nginx

## PHP Environment variables

Variable              | Default Value
--------------------- |  ------------------------------------------------------------------------------
`PHP_MAXEXECUTIONTIME`          | 30
`PHP_MEMORYLIMIT`     | 128M
`PHP_DISPLAYERRORS`     | Off
`PHP_DISPLASTARTUPERRORS`     | Off
`PHP_ERRORREPORTING`     | E_ALL & ~E_DEPRECATED & ~E_STRICT
`PHP_VARIABLESORDER`     | GPCS
`PHP_POSTMAXSIZE`     | 8M
`PHP_UPLOADMAXFILESIZE`     | 2M
`PHP_SHORTOPENTAG`     | Off

## Virtual Host Environment variables

Variable              | Default Value
--------------------- |  ------------------------------------------------------------------------------
`VHOST_ROOT`          | /app/code
`VHOST_INDEX`     | index.php

## PHP-FPM Environment variables

Variable              | Default Value
--------------------- |  ------------------------------------------------------------------------------
`FPM_USER`          | application
`FPM_GROUP`     | nginx
`FPM_LISTEN`      |    127.0.0.1:9000
`FPM_CLEARENV`     | no