# k8s 


### 1. master,node节点安装  kubeadm、 kubelet、 kubectl 及初始化修改配置工作
```shell
sudo /bin/bash 01install.sh
```

### 2. master节点 pull k8s集群需要的镜像

```shell
sudo /bin/bash 02master_image_pull.sh
```
```bash
vagrant@k8smaster:/home/www/develop_study/k8s$ sudo docker images
REPOSITORY                           TAG       IMAGE ID       CREATED         SIZE
k8s.gcr.io/kube-apiserver            v1.23.3   f40be0088a83   9 months ago    135MB
k8s.gcr.io/kube-controller-manager   v1.23.3   b07520cd7ab7   9 months ago    125MB
k8s.gcr.io/kube-scheduler            v1.23.3   99a3486be4f2   9 months ago    53.5MB
k8s.gcr.io/kube-proxy                v1.23.3   9b7cc9982109   9 months ago    112MB
k8s.gcr.io/etcd                      3.5.1-0   25f8c7f3da61   12 months ago   293MB
k8s.gcr.io/coredns/coredns           v1.8.6    a4ca41631cc7   13 months ago   46.8MB
k8s.gcr.io/pause                     3.6       6270bb605e12   14 months ago   683kB
```

### 3. master节点 kubeadm init 

```shell
suod /bin/bash 03master_kubeadm_init.sh
```
```bash
# 输出这个 去node 节点运行
kubeadm join 192.168.56.80:6443 --token c16ltc.pn0pgx9ja14o3oqx \
	--discovery-token-ca-cert-hash sha256:f82676842a85f23a5a2e671f2d62584cb088016f48364a72b3678b360eab070d

# kubectl get node 验证
```


### 4. master节点 安装 calico 网络插件

```shell
# kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml 已经在仓库中
kubectl apply -f calico.yaml
```
以下代表已经网络ok
```bash
vagrant@k8smaster:/home/www/deve lop_study/k8s$ sudo  kubectl get node
NAME        STATUS   ROLES                  AGE   VERSION
k8smaster   Ready    control-plane,master   28m   v1.23.3
```

### 5. node节点加入集群
所有node 都运行
```shell
kubeadm join 192.168.56.80:6443 --token c16ltc.pn0pgx9ja14o3oqx \
	--discovery-token-ca-cert-hash sha256:f82676842a85f23a5a2e671f2d62584cb088016f48364a72b3678b360eab070d
```
等待几分钟 ，和机器配置有关系,出现下面，就代表OK
```bash
vagrant@k8smaster:/home/www/develop_study/k8s$ sudo kubectl get nodes
NAME        STATUS   ROLES                  AGE     VERSION
k8smaster   Ready    control-plane,master   36m     v1.23.3
k8snode1    Ready    <none>                 4m29s   v1.23.3
```


###  加入集群命令
```shell
kubeadm token create --print-join-command
kubeadm token create --ttl 0 --print-join-command # 不过期
```
### 重新加入
```shell
kubeadm reset
```


