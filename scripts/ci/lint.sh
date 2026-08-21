#! /usr/bin/env bash

# Usage: ./scripts/ci/lint.sh
#
# Runs `helm lint` over the chart.

HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$HERE"/../helpers/logger.sh

set -eo pipefail

cd "$HERE"/../..

_log "INFO" "Linting repo"

_log "DEBUG" "Linting Helm chart"

helm lint charts/ragnerock

_log "SUCCESS" "Linting done"
