#!/usr/bin/env bash

PROVISION_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

COMMON_CONFIG=/etc/nginx/nginx-wp-common.conf

INSERT_MARKER="charset utf-8;"
CHECK_STRING="/_static/"

CONCAT_CONFIG="${PROVISION_DIR}/nginx-http-concat.conf"

# Ignoring as pipefail interferes, as cautioned in sniff help.
# shellcheck disable=SC2143
if [ -n "$(grep "$CHECK_STRING" "$COMMON_CONFIG")" ]; then
  vvv_info " * Nothing to do"
  return
fi

vvv_info " * Adding nginx-concat configuration to ${COMMON_CONFIG}"

sed -i -e "/${INSERT_MARKER}/r${CONCAT_CONFIG}" "$COMMON_CONFIG"
