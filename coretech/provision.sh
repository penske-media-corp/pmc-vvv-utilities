#!/usr/bin/env bash

CORETECH_DIR="/tmp/pmc-coretech"

PROVISION_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_LIST="${PROVISION_DIR}/repos.yml"

function pmc_git_trust_all() {
  git config --global --add safe.directory '*'
}

vvv_info " * Forcing git to trust all repos..."
pmc_git_trust_all
noroot pmc_git_trust_all

vvv_info " * Preparing to clone common code for reuse during site provisioning..."

rm -rf "$CORETECH_DIR"
noroot mkdir "$CORETECH_DIR"
cd "$CORETECH_DIR"

vvv_info " * Starting clone operations..."

set +e
noroot shyaml get-values-0 < "${REPO_LIST}" |
while IFS='' read -r -d '' key &&
      IFS='' read -r -d '' value; do
  vvv_info "  + Cloning '${value}' into '${CORETECH_DIR}/${key}'"
  noroot git clone --recursive --quiet "${value}" "${CORETECH_DIR}/${key}"
done
set -e
