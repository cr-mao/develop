#!/bin/bash

kubectl get pod -A --show-labels

# 打标签
kubectl label pod nginx1 -n dev version=1.0

# 筛选标签
kubectl get pod -l "version=2.0" -n dev --show-labels

kubectl get pod -l "version!=2.0" -n dev --show-labels

# 删除标签
kubectl label pod nginx -n dev 标签名-
kubectl label pod nginx -n dev version-
