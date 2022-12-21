
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



