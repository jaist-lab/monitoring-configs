#!/bin/bash
#
kubectl apply -f dcgm-servicemonitor.yaml

# GPUメトリクス確認
curl -s -G http://172.16.100.101:32090/api/v1/query \
  --data-urlencode 'query=DCGM_FI_DEV_GPU_TEMP' | jq

# anchorで確認
curl -s -G http://172.16.200.200:9090/api/v1/query \
  --data-urlencode 'query=DCGM_FI_DEV_GPU_TEMP{cluster="production"}' | jq
