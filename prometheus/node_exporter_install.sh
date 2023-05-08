#!/bin/bash 


if [ -f /usr/local/bin/node_exporter ];then 
    echo "node_exporter has already installed"
    exit 0
fi 
wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz
tar zxvf node_exporter-1.4.0.linux-amd64.tar.gz
mv node_exporter-1.4.0.linux-amd64/node_exporter /usr/local/bin/
groupadd node_exporter
useradd -g node_exporter -M -s /sbin/nologin node_exporter


cat <<EOF >  /etc/systemd/system/node_exporter.service

[Unit]
Description=Node exporter server
After=network-online.target
[Service]
# 账户和组设置，可以保证数据安全
User=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=node_exporter
Restart=on-failure
RestartSecs=5s
ExecReload=/bin/kill -HUP $MAINPID
[Install]
WantedBy=multi-user.target
EOF 

systemctl daemon-reload
systemctl enable  node_exporter #开机启动
# systemctl start node_exporter

# 默认9100端口