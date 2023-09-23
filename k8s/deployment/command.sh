

export out="--dry-run=client -o yaml"
kubectl create deploy ngx-dep --image=nginx:alpine $out # 得到模板



kubectl get deploy

# 应用伸缩
kubectl scale --replicas=5 deploy ngx-dep

kubectl get pod -l app=nginx
kubectl get pod -l 'app in (ngx, nginx, ngx-dep)'



# 创建
kubectl create deployment nginx --image=nginx:1.17.1 --port=80 --replicas=3 --namespace=dev
#查看
kubectl get deployment,pod -n dev

# 查看创建的deployment的详细信息
kubectl describe deploy nginx -n dev
# 删除
kubectl delete deploy nginx -n dev