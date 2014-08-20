#!/bin/bash

apt-get update

#dependencies for mitmproxy
apt-get -y install python-pip python-dev build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev iptables
pip -v install mitmproxy

# this rules redirect all local traffic done by user vagrant to the transparent proxy running at 8080
# iptables -t nat -I OUTPUT -m owner --uid-owner vagrant -p tcp --dport 80 -j REDIRECT --to-port 8080
# iptables -t nat -I OUTPUT -m owner --uid-owner vagrant -p tcp --dport 443 -j REDIRECT --to-port 8080

# You have to manually run as root:
# OUTPUT_FILE=dump-`date +%Y-%m-%d`
# mitmproxy -T --host -w $OUTPUT_FILE
# or
# mitmdump -T --host -w $OUTPUT_FILE
#
# To replay a session
# mitmdump -T --host -S $OUTPUT_FILE
