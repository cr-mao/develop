#!/bin/bash

# 创建集群内部可访问的service
kubectl expose deployment nginx --name=svc-nginx1 --type=ClusterIP --port=80 --target-port=80 -n dev
# 创建集群外部也可以访问的service
kubectl expose deploy nginx --name=svc-nginx2 --type=NodePort --port=80 --target-port=80 -n dev

# 删除service
kubectl delete svc svc-nginx2 -n dev
