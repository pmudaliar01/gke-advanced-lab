#!/usr/bin/env bash
set -euo pipefail
K6_URL="${1:-http://localhost}"
docker run --rm -i grafana/k6 run -e BASE_URL="$K6_URL" - < loadtest/k6.js
