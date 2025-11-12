#!/bin/bash

echo "=== Monitoring Health Check ==="

# anchor
echo -n "anchor Prometheus: "
curl -sf http://172.16.200.200:9090/-/healthy && echo "✓ OK" || echo "✗ NG"
echo -n "anchor Grafana: "
curl -sf http://172.16.200.200:3000/api/health > /dev/null && echo "✓ OK" || echo "✗ NG"

# Production
echo -n "Production Prometheus: "
curl -sf http://172.16.100.101:32090/-/healthy && echo "✓ OK" || echo "✗ NG"
echo -n "Production Grafana: "
curl -sf http://172.16.100.101:32000/api/health > /dev/null && echo "✓ OK" || echo "✗ NG"

# Development
echo -n "Development Prometheus: "
curl -sf http://172.16.100.121:32090/-/healthy && echo "✓ OK" || echo "✗ NG"
echo -n "Development Grafana: "
curl -sf http://172.16.100.121:32000/api/health > /dev/null && echo "✓ OK" || echo "✗ NG"

# Sandbox
echo -n "Sandbox Prometheus: "
curl -sf http://172.16.100.131:32090/-/healthy && echo "✓ OK" || echo "✗ NG"
echo -n "Sandbox Grafana: "
curl -sf http://172.16.100.131:32000/api/health > /dev/null && echo "✓ OK" || echo "✗ NG"

# クラスタラベル確認
echo ""
echo "=== Cluster Labels on anchor ==="
curl -s 'http://172.16.200.200:9090/api/v1/label/cluster/values' | jq

echo ""
echo "=== Complete ==="
