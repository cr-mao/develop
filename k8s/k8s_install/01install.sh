#!/bin/bash

# 为了让 Kubernetes 能够检查、转发网络流量，你需要修改 iptables 的配置，启用“br_netfilter”模块：
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
    br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
  net.bridge.bridge-nf-call-ip6tables = 1
  net.bridge.bridge-nf-call-iptables = 1
  net.ipv4.ip_forward=1 # better than modify /etc/sysctl.conf
EOF


sysctl --system

# 关闭swap
swapoff -a
sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab


# 配置k8s源
apt install -y apt-transport-https ca-certificates curl nfs-common

curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
# 安装 kubeadm、kubelet 和 kubectl 

apt update

apt install -y kubeadm=1.23.3-00 kubelet=1.23.3-00 kubectl=1.23.3-00

# apt-mark hold ，锁定这三个软件的版本，避免意外升级导致版本错误
apt-mark hold kubeadm kubelet kubectl

# check

kubeadm version
kubectl version --client
