#!/bin/bash
if [ -z "$1" ]
  then
    OUTPUT_FILE=dump-`date +%Y-%m-%d`
    echo "No argument supplied, using $OUTPUT_FILE"
  else
    OUTPUT_FILE=$1
fi

PIDFILE=/var/run/mitmdump.pid

if [ -f "$PIDFILE" ]; then
    echo "There is a mitmdump instance running."
    exit
fi

mitmdump -T --host --anticache -q -z --keepserving -w $OUTPUT_FILE &
echo $! > $PIDFILE

# iptables-save > /tmp/working.iptables.rules

iptables -t nat -I OUTPUT -m owner --uid-owner vagrant -p tcp --dport 80 -j REDIRECT --to-port 8080
iptables -t nat -I OUTPUT -m owner --uid-owner vagrant -p tcp --dport 443 -j REDIRECT --to-port 8080
