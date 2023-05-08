#!/bin/bash 
# prometheus 安装脚本

# 是否已安装
if [ -d /opt/app/prometheus ]; then 
    echo "has installed prometheus"
    exit 0
fi 
mkdir -p /opt/app
cd /opt/app
wget https://github.com/prometheus/prometheus/releases/download/v2.37.1/prometheus-2.37.1.linux-amd64.tar.gz
tar zxvf prometheus-2.37.1.linux-amd64.tar.gz  # 2.37.1 是lts 版本 
mv prometheus-2.37.1.linux-amd64 prometheus
cd prometheus 
mkdir data

groupadd prometheus
useradd -g prometheus -M -s /sbin/nologin prometheus
# 把data 目录，以及其他目录都改成prometheus:prometheus 不然起不来
chown -R prometheus:prometheus  /opt/app/prometheus




cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target
[Service]
# 账户和组设置，可以保证数据安全
User=prometheus
Type=simple
ExecStart=/opt/app/prometheus/prometheus --config.file=/opt/app/prometheus/prometheus.yml --storage.tsdb.path=/opt/app/prometheus/data/ --web.console.templates=/opt/app/prometheus/consoles --web.console.libraries=/opt/app/prometheus/console_libraries --web.enable-lifecycle --web.enable-admin-api  --web.listen-address="0.0.0.0:9092"


# --enable-feature=remote-write-receiver  启用 remote write 接收数据的接口，启用该项之后，categraf、grafana-agent 等 agent 就可以通过 /api/v1/write 接口推送数据给 Prometheus
# --web.enable-admin-api 启用管理性 API，比如删除时间序列数据的 /api/v1/admin/tsdb/delete_series 接口
# --query.lookback-delta=2m  即时查询在查询当前最新值的时候，只要发现这个参数指定的时间段内有数据，就取最新的那个点返回，这个时间段内没数据，就不返回了


# web.enable-lifecycle 热更新
Restart=on-failure
RestartSecs=5s
SuccessExitStatus=0
LimitNOFILE=65536
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=prometheus
ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target

EOF


systemctl daemon-reload
systemctl enable prometheus #开机启动
# systemctl start prometheus
# sudo systemctl stop prometheus
# systemctl status prometheus