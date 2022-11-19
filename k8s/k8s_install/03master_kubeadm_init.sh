#!/bin/bash


kubeadm init \
    --pod-network-cidr=10.10.0.0/16 \
    --apiserver-advertise-address=192.168.56.80 \
    --kubernetes-version=v1.23.3

mkdir -p $HOME/.kube

cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

chown $(id -u):$(id -g) $HOME/.kube/config


export KUBECONFIG=/etc/kubernetes/admin.conf


