#!/bin/bash

# master pull 这些镜像
repo=registry.aliyuncs.com/google_containers


for name in `kubeadm config images list --kubernetes-version v1.23.3`; do

    src_name=${name#k8s.gcr.io/}
    src_name=${src_name#coredns/}

    sudo docker pull $repo/$src_name

    sudo docker tag $repo/$src_name $name
    sudo docker rmi $repo/$src_name
done

