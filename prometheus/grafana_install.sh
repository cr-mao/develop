#!/bin/bash

apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_9.1.0_amd64.deb
dpkg -i grafana_9.1.0_amd64.deb

systemctl daemon-reload
systemctl enable grafana
systemctl start grafana-server.service
# 访问地址 http://ip:3000
# 默认账户:admin    密码： admin  修改密码alalal123
