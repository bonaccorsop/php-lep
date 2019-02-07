#!/bin/env bash
# $Id: entrypoint.sh,v 0.1 2016/04/10 $ $Author: Pietro Bonaccorso $

docker run --rm \
-p "8056:80"  \
-e "PHP_DISPLAYERRORS=On" \
-e "PHP_ERRORREPORTING=E_ALL" \
-e "SERVER_NAME=locl.mosaicoon.com" \
-e "SERVER_PORT=8056" \
-e "PHP_ERRORREPORTING=E_ALL" \
-v $(pwd)/:/app/code \
--name lep73 \
bonaccorsop/php:lep-7.3