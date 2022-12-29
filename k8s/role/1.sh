
# 创建rolebinding
kubectl create rolebinding mypodbinding  -n default  --role mypod --user crmao


# 普通用户
kubectl config use-context user_context

# 管理员
kubectl config use-context  kubernetes-admin@kubernetes


# 查看用户
kubectl config get-contexts




# 创建角色，和角色绑定。
kubectl apply -f mypod_role.yaml
kubectl apply -f mypod_rolebinding.yaml


# 创建集群角色 和 集群角色绑定
kubectl apply -f cluster_role.yaml
kubectl apply -f cluster_rolebinding.yaml

