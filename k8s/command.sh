#!/bin/bash
# 查看版本信息
kubectl version
# 查看Node状态
kubectl get node 
# 查看Master组件状态
kubectl get cs 
# 集群接口信息
kubectl cluster-info
# 列出k8s所有资源
kubectl api-resources
# 查看apiserver聚合层注册信息
kubectl get apiservice
# 查看api的版本
kubectl api-versions
# 查看某个node的详细信息
kubectl describe node `node_name`     




# namespace  命名空间
kubectl get ns
kubectl get ns kube-system -o yaml
kubectl describe ns kube-system

# 创建namespace 
kubectl create ns dev

kubectl get ns  -A
kubectl delete ns dev 

