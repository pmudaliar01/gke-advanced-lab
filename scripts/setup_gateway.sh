#!/usr/bin/env bash
set -euo pipefail
kubectl apply -f manifests/gateway.yaml
kubectl wait --for=condition=Programmed gateway/web-gw -n default --timeout=5m
