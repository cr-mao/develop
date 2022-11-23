#!/bin/bash 
cd /opt/
wget https://github.com/goharbor/harbor/releases/download/v2.6.2/harbor-online-installer-v2.6.2.tgz
tar -zxvf harbor-offline-installer-v2.6.2.tgz
# # 修改hostname: 192.168.80.56  harbor_admin_password: 123456   ,注释https
cp harbor.yml /opt/harbor/

/opt/harbor/install.sh --with-trivy --with-chartmuseum

# docker-compose ps 查看是否安装成功
