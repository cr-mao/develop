#!/bin/bash
#

apt install resolvconf

cat <<EOF | sudo tee /etc/resolvconf/resolv.conf.d/head
nameserver 223.5.5.5
nameserver 114.114.114.114
nameserver 8.8.8.8
EOF

resolvconf --enable-updates
systemctl restart systemd-resolved.service
