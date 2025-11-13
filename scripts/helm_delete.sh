#!/usr/bin/env bash
set -euo pipefail
RELEASE="${1:-app}"
NAMESPACE="${2:-default}"
helm uninstall "$RELEASE" -n "$NAMESPACE" || true
