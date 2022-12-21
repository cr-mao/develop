# 部署顺序
kubectl apply -f ingress.yaml
./setup.sh
kubectl apply -f deploy-nginx-ingress-controller.yaml


