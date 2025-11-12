#!/bin/bash

# Prometheusヘルスチェック
curl http://172.16.100.101:32090/-/healthy

# メトリクス確認
curl -s -G http://172.16.100.101:32090/api/v1/query \
  --data-urlencode 'query=up' | jq '.data.result[] | select(.metric.job | contains("node-exporter")) | .metric.instance'

# Ceph RBDボリューム確認
ssh jaist-lab@172.16.100.101 "sudo rbd du -p kubernetes"

# anchorへのRemote Write確認
curl -s 'http://172.16.200.200:9090/api/v1/label/cluster/values' | jq
