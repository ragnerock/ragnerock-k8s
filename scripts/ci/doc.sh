#! /usr/bin/env bash

# Usage: ./scripts/ci/doc.sh
#
# Regenerates the chart's README from values.yaml with helm-docs, then fails if
# that changed anything: a local run leaves the README fixed and ready to
# commit, while CI fails on drift.

HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$HERE"/../helpers/logger.sh

set -eo pipefail

_log "INFO" "Generating documentation"

if ! command -v helm-docs >/dev/null 2>&1; then
  _log "FATAL" "helm-docs is not installed (brew install norwoodj/tap/helm-docs)"
fi

_log "DEBUG" "Generating Helm chart documentation"

cd "$HERE"/../../charts/ragnerock
helm-docs .

if ! git diff --quiet -- README.md; then
  _log "ERROR" "The chart README is out of date, regenerated it:"
  git diff --stat -- README.md
  _log "FATAL" "Doc generation check failed"
fi

_log "SUCCESS" "Doc generation done"
