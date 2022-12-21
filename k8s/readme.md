
```bash 
vagrant@k8smaster:~/.kube$ kubectl cluster-info
Kubernetes control plane is running at https://192.168.56.80:6443
CoreDNS is running at https://192.168.56.80:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```


## kubelet

负责master和节点（node）之间的通信、交互和数据上报 到master的apiserver

整体来讲 的职责是
- 1、Node管理
- 2、pod管理
- 3、容器健康检查
- 4、容器监控
- 5、资源清理
- 6、和容器运行时交互(docker 、rkt、Virtlet等等)



一般情况下kubectl会暴露 10250端口 用于和apiserver 交互
常用的查询API ( 看看就好)
GET  
- /pods
- /stats/summary
- /metrics
- /healthz

```bash
vagrant@k8smaster:~/.kube$ sudo netstat -ntlp | grep 10250
tcp6       0      0 :::10250                :::*                    LISTEN      929/kubelet


vagrant@k8smaster:~/.kube$ curl -k https://localhost:10250/healthz
Unauthorized


# token 获得
# kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

curl -k https://localhost:10250/metrics --header "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6InpUVFN0aktKMFU3Sng5bjJ5YzFzdDZ4SkN2M1JhUVMtTHAxLV92RHJJb2sifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLTQ3a2NwIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJlNDM2OTIzZi1jNjY1LTQ5OGMtOGIyNS03NzY1YTBlYWM2ZjYiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.MjGVSKT4uianc2DN3fniLEhZ2HPm_jbfxIYQMYtrw7EX8yFAOorQt3IpnzLeprNclGlFVWlatduvdSg4Mrw9uujsoDfVnoMFrU_l1OWn2wp7BNhIFOGBh4ylznZqPUIcpEuxl4R7-1azh9UweRKngqq5UkL0EmA-CTQPnLglP47sTsBV71tKs9q3dVkLghnBEyxQKmWe9y3XjRCyvFY6MiiDl2sDIQrNq9cFFYTtTocUCPcZIIqaDii1Dy3BR27nWit4x85RuhTnfmTjHjtr-BFse7bfSC0JkFMhd3iCvqnpxiNSCF52rG3EUY9MzaaNdrfkiP6LpKO-b4jvs_R8IA"
```




### node label 和 nodeSelector
```shell
# 显示标签
kubectl get node --show-labels
# 添加标签
kubectl label nodes <node-name> <label-key>=<label-value>

kubectl label  nodes k8snode1 nodename=a1

#  删除标签
kubectl label nodes k8snode1  nodename-

#  修改标签
kubectl label nodes <node-name> <label-key>=<label-value> --overwrite
```

```text
vagrant@k8snode1:/home/www/develop_study/k8s/dashboard$ kubectl get node --show-labels
NAME        STATUS   ROLES                  AGE   VERSION   LABELS
k8smaster   Ready    control-plane,master   29d   v1.23.3   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=k8smaster,kubernetes.io/os=linux,node-role.kubernetes.io/control-plane=,node-role.kubernetes.io/master=,node.kubernetes.io/exclude-from-external-load-balancers=
k8snode1    Ready    <none>                 29d   v1.23.3   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=k8snode1,kubernetes.io/os=linux,nodename=a1
```






