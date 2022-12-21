#!/bin/bash

kubectl apply -f dashboard-adminuser.yaml
kubectl apply -f recommended.yaml

kubectl get service -A

#访问测试
# 每次访问都需要令牌
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')


# 访问地址
# https://192.168.56.81:31605
