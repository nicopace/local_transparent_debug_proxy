#!/bin/bash
if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit
fi

OUTPUT_FILE=$1
PIDFILE=/var/run/mitmdump.pid

if [ -f "$PIDFILE" ]; then
    echo "There is a mitmdump instance running."
    exit
fi

mitmdump -T --host --anticache --norefresh --no-pop -S $OUTPUT_FILE &
echo $! > $PIDFILE

# iptables-save > /tmp/working.iptables.rules

iptables -t nat -I OUTPUT -m owner --uid-owner vagrant -p tcp --dport 80 -j REDIRECT --to-port 8080
iptables -t nat -I OUTPUT -m owner --uid-owner vagrant -p tcp --dport 443 -j REDIRECT --to-port 8080
