#!/usr/bin/env bash

PHPCS_DIR="/srv/www/phpcs"
PHPCS_CMD="${PHPCS_DIR}/bin/phpcs"

vvv_info " * Removing PHCPS provisioned by VVV..."
rm -rf $PHPCS_DIR

vvv_info " * Install PMC Codesniffer..."
noroot git clone git@bitbucket.org:penskemediacorp/pmc-codesniffer.git "$PHPCS_DIR"
noroot composer update --no-ansi --no-autoloader --no-progress -d "$PHPCS_DIR"

# Symlink bin directory added to $PATH by VVV.
ln -s "${PHPCS_DIR}/vendor/bin" "${PHPCS_DIR}/bin"

vvv_info " * Setting PmcWpVipGo as default PHPCS standard..."

$PHPCS_CMD --config-set default_standard PmcWpVipGo
$PHPCS_CMD -i
$PHPCS_CMD --config-show
