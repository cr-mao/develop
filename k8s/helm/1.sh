#!/bin/bash

# https://github.com/helm/helm

# 安装
wget https://get.helm.sh/helm-v3.10.3-linux-amd64.tar.gz
tar zxvf helm-v3.10.3-linux-amd64.tar.gz
mv xx/helm /usr/local/bin/helm


# 添加源
helm repo add stable http://mirror.azure.cn/kubernetes/charts/
helm repo update

# 搜索
helm search repo stable/mysql
# xxx 自己取的名字
helm install xxx  stable/mysql




# helm 安装 ingress-nginx 这个只装了ingress classes, 在kubectl apply -f ingress.yaml 即可


