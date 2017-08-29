FROM openresty/openresty:xenial

RUN apt-get update
RUN apt-get install -y git cmake wget libssl-dev

RUN /usr/local/openresty/luajit/bin/luarocks install wiola

RUN apt-get purge -y git wget libssl-dev && apt-get autoremove -y

ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

ENTRYPOINT ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]