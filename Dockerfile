FROM ubuntu:16.04

ENV SQUID_USER="proxy" \
    SQUID_CONF="/etc/squid/squid.conf" \
    SQUID_CACHE_DIR="/var/spool/squid"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y squid && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY conf/entrypoint.sh /usr/local/bin
COPY conf/squid.conf ${SQUID_CONF}

RUN chmod 644 ${SQUID_CONF} && \
    chmod 755 /usr/local/bin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["squid"]
