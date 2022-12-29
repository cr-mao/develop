#!/bin/bash

# 放到~/.bashrc下 kubectl自动命令补全
source <(kubectl completion bash)

# 运行一个pod
kubectl run ngx --image=nginx:alpine

# 系统命名空间  kube-system
kubectl get pod -n kube-system


kubectl get pod -o wide -A

kubectl delete pod kube-flannel-ds-xnh7g -n kube-system

kubectl get node

kubectl get nodes

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

kubectl config view

# 配置目录
/home/vagrant/.kube
# 集群信息
kubectl cluster-info


#  删除停止掉的容器
sudo docker rm $(sudo docker ps -qf status=exited)


kubectl describe svc mygo -n myweb


kubectl get deployment myngx -n myweb

kubectl get svc myngx-service -n myweb



kubectl get cm
kubectl describe cm info


kubeadm config images list #可以查看安装 Kubernetes 所需的镜像列

# 获得加入集群命令
kubeadm token create --print-join-command



# 健康状态查看
kubectl get cs


kubectl get endpoints
