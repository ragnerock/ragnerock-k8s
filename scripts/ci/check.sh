#! /usr/bin/env bash

# Usage: ./scripts/ci/check.sh

HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source $HERE/../helpers/logger.sh

set -eo pipefail

_log "INFO" "Static checking repo"

_log "DEBUG" "Checking Helm chart"

helm template charts/ragnerock | kubeconform -strict -verbose
python $HERE/../helpers/check-configmaps.py
python $HERE/../helpers/check-values.py $HERE/../../charts/ragnerock

_log "SUCCESS" "Static checking done"