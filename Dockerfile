FROM openresty/openresty:jessie

RUN apt-get update \
    && apt-get install -y git wget libssl-dev\
    && cd /tmp \
    && wget https://cmake.org/files/v3.9/cmake-3.9.1.tar.gz \
    && tar xf cmake-3.9.1.tar.gz \
    && cd cmake-3.9.1 \
    && ./bootstrap \
    && make -j$(nproc) \
    && make install \
    && /usr/local/openresty/luajit/bin/luarocks install wiola 0.6.1 \
    && cd /tmp/cmake-3.9.1 && make uninstall \
    && rm -rf /tmp/cmake-3.9.1 \
    && apt-get purge -y git wget libssl-dev && apt-get autoremove -y

ADD config.nginx /usr/local/openresty/nginx/conf/nginx.conf

ENTRYPOINT ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]