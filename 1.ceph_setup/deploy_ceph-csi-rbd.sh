#!/bin/bash
#

# vesselサーバで
#export KUBECONFIG=~/.kube/config-production
#export KUBECONFIG=~/.kube/config-development
#export KUBECONFIG=~/.kube/config-sandbox

# Ceph認証情報をSecretとして登録
kubectl create secret generic csi-rbd-secret \
  --from-literal=userID=kubernetes \
  --from-literal=userKey='AQDN3hNpV1MPLxAAUyeZrNjug7UYrqJvtzF5wg==' \
  --namespace=kube-system

# Helmリポジトリ追加
helm repo add ceph-csi https://ceph.github.io/csi-charts
helm repo update


## デプロイ・アップグレード（または再インストール）
helm upgrade  --install ceph-csi-rbd ceph-csi/ceph-csi-rbd \
  --namespace kube-system \
  --values ~/kubernetes/monitoring-configs/ceph-csi-rbd-values.yaml \
  --version 3.12.2

# 確認
kubectl get pods -n kube-system -l app=ceph-csi-rbd
kubectl get storageclass ceph-rbd

