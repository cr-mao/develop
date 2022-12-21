
开门狗

默认 每个node节点都会调度到，除污点（master节点默认是污点）


```shell 
kubectl describe node k8smaster  | grep Taints

# 去掉master的污点
kubectl taint node master node-role.kubernetes.io/master:NoSchedule-

```



