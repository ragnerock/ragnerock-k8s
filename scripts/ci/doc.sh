#! /usr/bin/env bash

# Usage: ./scripts/ci/doc.sh

HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source $HERE/../helpers/logger.sh

set -eo pipefail

_log "INFO" "Generating documentation"

_log "DEBUG" "Generation Helm chart documentation"

cd $HERE/../../charts/ragnerock
helm-docs .

_log "SUCCESS" "Doc generation done"