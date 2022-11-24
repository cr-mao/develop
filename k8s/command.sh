#!/bin/bash

# 放到~/.bashrc下 kubectl自动命令补全
source <(kubectl completion bash)

kubectl run ngx --image=nginx:alpine

kubectl get pod -o wide -A

kubectl delete pod kube-flannel-ds-xnh7g -n kube-system

kubectl get node 

# kubelet 节点代理 ，指挥创建容器，管理pod 的生命周期
# ps -ef|grep kubelet



kubectl api-resources

kubectl get pod --v=9

kubectl apply -f ngx-pod.yml


# 如何写yaml
kubectl explain pod
kubectl explain pod.metadata
kubectl explain pod.spec
kubectl explain pod.spec.containers
# export out="--dry-run=client -o yaml"
kubectl run ngx --image=nginx:alpine --dry-run=client -o yaml

kubectl apply -f ngx-pod.yml
kubectl delete -f ngx-pod.yml


kubectl apply -f busy-pod.yml
kubectl describe pod busy-pod


kubectl logs ngx-pod

# echo 'aaa' > a.txt
kubectl cp a.txt ngx-pod:/tmp

kubectl exec -it ngx-pod -- sh

