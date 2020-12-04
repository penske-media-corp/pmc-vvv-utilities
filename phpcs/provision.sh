#!/usr/bin/env bash

STANDARDS_DIR="/srv/www/phpcs/CodeSniffer/Standards/"

vvv_info " * Removing PHCPS standards provisioned by VVV..."
rm -rf $STANDARDS_DIR

vvv_info " * Install PMC Codesniffer..."
git clone git@bitbucket.org:penskemediacorp/pmc-codesniffer.git "$STANDARDS_DIR"
noroot composer update --no-ansi --no-autoloader --no-progress -d "$STANDARDS_DIR"

vvv_info " * Setting PmcWpVip as default PHPCS standard..."
phpcs --config-set installed_paths ./CodeSniffer/Standards/PmcWpVip/,./CodeSniffer/Standards/PmcLaravel/,./CodeSniffer/Standards/vendor/wp-coding-standards/wpcs/,./CodeSniffer/Standards/vendor/automattic/vipwpcs/,./CodeSniffer/Standards/vendor/sirbrillig/phpcs-variable-analysis/
phpcs --config-set default_standard PmcWpVip
phpcs -i
phpcs --config-show
