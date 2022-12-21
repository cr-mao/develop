#!/bin/bash

 # 查看污点。默认k8s master节点有污点，不会被daemonset调度
 kubectl describe node k8smaster  | grep Taints


# 去掉master的污点
kubectl taint node master node-role.kubernetes.io/master:NoSchedule-



