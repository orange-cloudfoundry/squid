#!/bin/sh
#===========================================================================
# Entrypoint for docker squid container
#===========================================================================

create_dir() {
  mkdir -p $1
  chmod -R 755 $1
  chown -R ${SQUID_USER}:${SQUID_USER} $1
}

if [ "$1" = "squid" ] ; then
  echo "Create log and cache directories..."
  create_dir "${SQUID_CACHE_DIR}"
  chown ${SQUID_USER} /dev/stdout
  chown ${SQUID_USER} /dev/stderr

  echo "Initialize squid cache..."
  SQUID=`which squid`
  if [ ! -d ${SQUID_CACHE_DIR}/00 ] ; then
    ${SQUID} -f ${SQUID_CONF} -N -z
  fi

  echo "Start squid..."
  exec ${SQUID} -f ${SQUID_CONF} -NYCd 1
else
  exec "$@"
fi
