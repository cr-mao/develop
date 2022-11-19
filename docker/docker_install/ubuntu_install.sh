apt-get install -y docker.io 
service docker start         #启动docker服务
usermod -aG docker ${USER}   #当前用户加入docker组

cat <<EOF | sudo tee /etc/docker/daemon.json
  {  "exec-opts": ["native.cgroupdriver=systemd"],  
    "log-driver": "json-file",  
    "log-opts": {    "max-size": "100m"  },
    "storage-driver": "overlay2",
    "registry-mirrors": ["http://hub-mirror.c.163.com"]  
  }
EOF


systemctl enable docker
systemctl daemon-reload
systemctl restart docker
