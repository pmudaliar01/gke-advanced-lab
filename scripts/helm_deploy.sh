#!/usr/bin/env bash
set -euo pipefail
ENV="${1:-dev}"
RELEASE="${2:-app}"
NAMESPACE="${3:-default}"

helm upgrade --install "$RELEASE" ./charts/app \
  --namespace "$NAMESPACE" --create-namespace \
  -f "env/${ENV}/values.yaml"
