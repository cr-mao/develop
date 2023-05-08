#!/bin/bash 
cd /opt/app
wget https://github.com/feiyu563/PrometheusAlert/releases/download/v4.8.1/linux.zip
unzip linux.zip
mv linux prometheusAlert
cd prometheusAlert
chmod +x PrometheusAlert
# 修改 conf/app.conf ,开启飞书支持,注意端口，有必要修改一下
# open-feishu=1 

# 加入systemd
cat <<EOF > /etc/systemd/system/PrometheusAlert.service

[Unit]
Description=Prometheus Alert
After=network.target
[Service]
Type=simple
WorkingDirectory=/opt/app/prometheusAlert/
ExecStart=/opt/app/prometheusAlert/PrometheusAlert
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=PrometheusAlert
Restart=on-failure
RestartSecs=5s
ExecReload=/bin/kill -HUP $MAINPID
[Install]
WantedBy=multi-user.targe
EOF

systemctl daemon-reload
systemctl enable PrometheusAlert

