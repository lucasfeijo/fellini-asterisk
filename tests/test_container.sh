#!/bin/sh
set -e
IMAGE=asterisk-test

if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  echo "Running Docker-based test"
  docker build -t $IMAGE docker
  CONTAINER_ID=$(docker run -d -p 5060:5060/udp $IMAGE)
  trap "docker rm -f $CONTAINER_ID" EXIT
  sleep 5
  docker exec $CONTAINER_ID asterisk -rx "dialplan show default"
else
  echo "Running host-based test"
  TMPDIR=$(mktemp -d)
  mkdir -p "$TMPDIR"/{var,db,keys,spool,run,log}
  cp docker/config/*.conf "$TMPDIR/"
  cat > "$TMPDIR/asterisk.conf" <<CONF
[directories]
astetcdir => $TMPDIR
astmoddir => /usr/lib/x86_64-linux-gnu/asterisk/modules
astvarlibdir => $TMPDIR/var
astdbdir => $TMPDIR/db
astkeydir => $TMPDIR/keys
astdatadir => /usr/share/asterisk
astagidir => /usr/share/asterisk/agi-bin
astspooldir => $TMPDIR/spool
astrundir => $TMPDIR/run
astlogdir => $TMPDIR/log
CONF

  asterisk -C "$TMPDIR/asterisk.conf" -f -vvv >/tmp/asterisk.log 2>&1 &
  ASTPID=$!
  trap "kill $ASTPID" EXIT
  sleep 5
  asterisk -C "$TMPDIR/asterisk.conf" -rx "dialplan show default"
fi
