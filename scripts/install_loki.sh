#!/usr/bin/env bash
set -euo pipefail
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm upgrade --install loki grafana/loki -n loki --create-namespace -f loki/loki-values.yaml
helm upgrade --install alloy grafana/alloy -n loki -f loki/alloy-values.yaml
