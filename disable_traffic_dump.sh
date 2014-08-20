#!/bin/bash
iptables -t nat -D OUTPUT -m owner --uid-owner vagrant -p tcp ! -d 127.0.0.1 --dport 80 -j REDIRECT --to-port 8080
iptables -t nat -D OUTPUT -m owner --uid-owner vagrant -p tcp ! -d 127.0.0.1 --dport 443 -j REDIRECT --to-port 8080

# iptables-restore < /tmp/working.iptables.rules

pid=`cat /var/run/mitmdump.pid`
kill $pid
rm /var/run/mitmdump.pid
