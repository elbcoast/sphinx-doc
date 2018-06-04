#!/bin/bash

set -e

CUSER="sphinx"
MYUID=`stat -c "%u" .`
MYGID=`stat -c "%g" .`

if [[ "$MYUID" -gt '0' && "$MYUID" != `id -u ${CUSER}` ]]; then
    usermod -u ${MYUID} ${CUSER}
    groupmod -g ${MYGID} ${CUSER}
    chown ${CUSER}:${CUSER} /tmp
fi

if [ -z "$DOCKERHOST" ]; then
    DOCKERHOST=`ip route list | grep ^default |awk '/default/ { print  $3}'`
fi

case "$1" in
    "root")
      exec /bin/bash ;;
    "shell")
      gosu ${CUSER} "/bin/bash" ;;
    *)
      gosu ${CUSER} "$@" ;;
esac