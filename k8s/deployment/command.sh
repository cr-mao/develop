

export out="--dry-run=client -o yaml"
kubectl create deploy ngx-dep --image=nginx:alpine $out # 得到模板



kubectl get deploy

# 应用伸缩
kubectl scale --replicas=5 deploy ngx-dep

kubectl get pod -l app=nginx
kubectl get pod -l 'app in (ngx, nginx, ngx-dep)'
