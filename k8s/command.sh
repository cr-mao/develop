#!/bin/bash

 kubectl get pod -o wide -A

kubectl delete pod kube-flannel-ds-xnh7g -n kube-system
