#!/bin/bash 

mkdir -p /opt/app/
cd /opt/app
wget https://github.com/prometheus/alertmanager/releases/download/v0.24.0/alertmanager-0.24.0.linux-amd64.tar.gz
tar zxvf alertmanager-0.24.0.linux-amd64.tar.gz
mv alertmanager-0.24.0.linux-amd64 alertmanager

cat <<EOF > /etc/systemd/system/alertmanager.service
[Unit]
Description="alertmanager"
After=network.target

[Service]
Type=simple

ExecStart=/opt/app/alertmanager/alertmanager
WorkingDirectory=/opt/app/alertmanager

Restart=on-failure
SuccessExitStatus=0
LimitNOFILE=65536
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=alertmanager
ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target

EOF

systemctl daemon-reload
systemctl enable  alertmanager 
# systemctl start alertmanager