#!/bin/bash
#

## ネームスペース作成
kubectl create namespace monitoring

# Prometheusデプロイ
helm install prometheus-cluster prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --values values-development.yaml \
  --version 67.4.0 \
  --wait \
  --timeout 20m

# 確認
kubectl get pods -n monitoring
kubectl get pvc -n monitoring
