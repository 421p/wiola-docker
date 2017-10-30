FROM openresty/openresty:alpine-fat

ARG RESTY_LUAROCKS_VERSION="2.3.0"

RUN apk add --no-cache --virtual .build-deps \
            make \
            gd-dev \
            geoip-dev \
            libxslt-dev \
            perl-dev \
            readline-dev \
            zlib-dev \
            git \
            cmake \
            openssl-dev \
            build-base \
            curl \
            gd \
            geoip \
            libgcc \
            libxslt \
            linux-headers \
            make \
            perl \
            unzip \
            zlib \
        && luarocks install wiola \
        && apk del .build-deps

ADD config.nginx /usr/local/openresty/nginx/conf/nginx.conf
ADD startup.sh /usr/local/wiola/startup

ENTRYPOINT ["/usr/local/wiola/startup"]