#! /usr/bin/env bash

# Usage: ./scripts/ci/doc.sh
#
# Regenerates the chart's README from values.yaml with helm-docs, then fails if
# that changed anything: a local run leaves the README fixed and ready to
# commit, while CI fails on drift. The check compares the file before and after
# generation rather than diffing against git, so a README that is already
# correct but not yet committed (staged or unstaged) passes.

HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$HERE"/../helpers/logger.sh

set -eo pipefail

_log "INFO" "Generating documentation"

if ! command -v helm-docs >/dev/null 2>&1; then
  _log "FATAL" "helm-docs is not installed (brew install norwoodj/tap/helm-docs)"
fi

_log "DEBUG" "Generating Helm chart documentation"

cd "$HERE"/../../charts/ragnerock

previous="$(mktemp)"
trap 'rm -f "${previous}"' EXIT
if [[ -f README.md ]]; then
  cp README.md "${previous}"
fi

helm-docs .

if ! cmp -s "${previous}" README.md; then
  _log "ERROR" "The chart README is out of date, regenerated it:"
  diff -u "${previous}" README.md || true
  _log "FATAL" "Doc generation check failed"
fi

_log "SUCCESS" "Doc generation done"
