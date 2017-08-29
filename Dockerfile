FROM openresty/openresty:jessie

RUN apt-get update
RUN apt-get install -y git wget libssl-dev

RUN cd /tmp \
    && wget https://cmake.org/files/v3.9/cmake-3.9.1.tar.gz \
    && tar xf cmake-3.9.1.tar.gz \
    && cd cmake-3.9.1 \
    && ./bootstrap && make && make install

RUN /usr/local/openresty/luajit/bin/luarocks install wiola

RUN cd /tmp/cmake-3.9.1 && make uninstall

RUN rm -rf /tmp/cmake-3.9.1

RUN apt-get purge -y git wget libssl-dev && apt-get autoremove -y

ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

ENTRYPOINT ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]