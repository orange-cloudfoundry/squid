FROM alpine:3.7

ENV SQUID_VERSION="3.5.23-r4"
ENV SQUID_USER="squid"
ENV SQUID_CONF="/etc/squid/squid.conf"
ENV SQUID_CACHE_DIR="/var/spool/squid"
ENV SQUID_LOG_DIR="/var/log/squid"

COPY conf/entrypoint.sh /sbin/entrypoint.sh
COPY conf/squid.conf ${SQUID_CONF}

RUN apk update && \
    apk add --no-cache su-exec && \
    apk add --no-cache squid=${SQUID_VERSION} && \
    chmod 644 ${SQUID_CONF} && \
    chmod 777 /sbin/entrypoint.sh

EXPOSE 3128
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["squid"]
