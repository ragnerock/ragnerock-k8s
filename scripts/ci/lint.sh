#! /usr/bin/env bash

# Usage: ./scripts/ci/check.sh

HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source $HERE/../helpers/logger.sh

set -eo pipefail

_log "INFO" "Linting repo"

_log "DEBUG" "Linting Helm chart"

cd $HERE/../..
helm lint charts/ragnerock

_log "SUCCESS" "Linting done"