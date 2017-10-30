#!/usr/bin/env sh

max_payload=${WIOLA_MAX_PAYLOAD_LEN:=65535}

sed -i -e s/__WIOLA_MAX_PAYLOAD_LEN__/${max_payload}/g /usr/local/openresty/nginx/conf/nginx.conf

/usr/local/openresty/bin/openresty -g "daemon off;"