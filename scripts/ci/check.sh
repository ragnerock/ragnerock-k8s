#! /usr/bin/env bash

# Usage: ./scripts/ci/check.sh
#
# Renders the chart and checks it three ways: the manifests validate against the
# Kubernetes schemas (kubeconform), every configMapRef/secretRef resolves to a
# resource the chart defines, and every .Values path the templates read is
# declared in values.yaml.

HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$HERE"/../helpers/logger.sh

set -eo pipefail

cd "$HERE"/../..

_log "INFO" "Static checking repo"

_log "DEBUG" "Checking Helm chart"

pip install pyyaml

helm template charts/ragnerock | kubeconform -strict -verbose
python "$HERE"/../helpers/check-configmaps.py
python "$HERE"/../helpers/check-values.py charts/ragnerock

_log "SUCCESS" "Static checking done"
