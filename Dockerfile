FROM openresty/openresty:alpine-fat

ARG RESTY_LUAROCKS_VERSION="2.3.0"

RUN apk add --no-cache --virtual .build-deps \
            make \
            curl \
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
        && rm -rf /usr/local/openresty/luajit/share/lua/5.1/wiola/* \
        && curl -fSL https://raw.githubusercontent.com/KSDaemon/wiola/dev/lib/cleanup.lua -o /usr/local/openresty/luajit/share/lua/5.1/wiola/cleanup.lua \
        && curl -fSL https://raw.githubusercontent.com/KSDaemon/wiola/dev/lib/config.lua -o /usr/local/openresty/luajit/share/lua/5.1/wiola/config.lua \
        && curl -fSL https://raw.githubusercontent.com/KSDaemon/wiola/dev/lib/handler.lua -o /usr/local/openresty/luajit/share/lua/5.1/wiola/handler.lua \
        && curl -fSL https://raw.githubusercontent.com/KSDaemon/wiola/dev/lib/flushdb.lua -o /usr/local/openresty/luajit/share/lua/5.1/wiola/flushdb.lua \
        && curl -fSL https://raw.githubusercontent.com/KSDaemon/wiola/dev/lib/headers.lua -o /usr/local/openresty/luajit/share/lua/5.1/wiola/headers.lua \
        && curl -fSL https://raw.githubusercontent.com/KSDaemon/wiola/dev/lib/json_serializer.lua -o /usr/local/openresty/luajit/share/lua/5.1/wiola/json_serializer.lua \
        && curl -fSL https://raw.githubusercontent.com/KSDaemon/wiola/dev/lib/msgpack_serializer.lua -o /usr/local/openresty/luajit/share/lua/5.1/wiola/msgpack_serializer.lua \
        && curl -fSL https://raw.githubusercontent.com/KSDaemon/wiola/dev/lib/post-handler.lua -o /usr/local/openresty/luajit/share/lua/5.1/wiola/post-handler.lua \
        && curl -fSL https://raw.githubusercontent.com/KSDaemon/wiola/dev/lib/wiola.lua -o /usr/local/openresty/luajit/share/lua/5.1/wiola/wiola.lua \
        && curl -fSL https://raw.githubusercontent.com/KSDaemon/lua-resty-redis/d738951e55ddaedecf7719c36c5a8200a2b2387f/lib/resty/redis.lua -o /usr/local/openresty/lualib/resty/redis.lua \
        && apk del .build-deps

ADD config.nginx /usr/local/openresty/nginx/conf/nginx.conf
ADD startup.sh /usr/local/wiola/startup

ENTRYPOINT ["/usr/local/wiola/startup"]