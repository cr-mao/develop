
# 查看所有pod
kubectl get pods --all-namespaces
kubeclt get pods -A

# 默认看default 命名空间下的
kubeclt get pods

kubectl create ns dev
kubectl run nginx --image=nginx:1.17.1 --port=80 --namespace dev
kubectl describe pod nginx -n dev
kubectl get pods -n dev -o wide

#删除pod
kubectl delete pod nginx --namespace=dev

kubectl create -f pod-nginx.yaml 