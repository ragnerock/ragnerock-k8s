#! /usr/bin/env bash

# Usage: ./scripts/ci/format.sh
#
# Formats the Helm chart with helmfmt.
#
# Formatting is applied in place and then reported as a failure, matching
# `ruff format --exit-non-zero-on-format` in the platform repo: a local run
# leaves the tree fixed and ready to commit, while CI still fails on drift.

HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$HERE"/../helpers/logger.sh

set -eo pipefail

cd "$HERE"/../..

_log "INFO" "Formatting chart"

if ! command -v helmfmt >/dev/null 2>&1; then
  _log "FATAL" "helmfmt is not installed (https://github.com/digitalstudium/helmfmt)"
fi

if ! helmfmt --check ./charts/ragnerock; then
  _log "ERROR" "Chart was not correctly formatted, fixing"
  helmfmt ./charts/ragnerock
  _log "FATAL" "Formatting check failed"
fi

_log "SUCCESS" "Formatting done"
