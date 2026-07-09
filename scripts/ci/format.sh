#! /usr/bin/env bash

# Usage: ./scripts/ci/format.sh

HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source $HERE/../helpers/logger.sh

set -eo pipefail

_log "INFO" "Formatting chart"

helmfmt ./charts/ragnerock

_log "SUCCESS" "Doc generation done"