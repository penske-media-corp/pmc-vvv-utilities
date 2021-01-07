#!/usr/bin/env bash

STANDARDS_DIR="/srv/www/phpcs/CodeSniffer/Standards/"

vvv_info " * Removing PHCPS standards provisioned by VVV..."
rm -rf $STANDARDS_DIR

vvv_info " * Install PMC Codesniffer..."
git clone git@bitbucket.org:penskemediacorp/pmc-codesniffer.git "$STANDARDS_DIR"
noroot composer update --no-ansi --no-autoloader --no-progress -d "$STANDARDS_DIR"

vvv_info " * Setting PmcWpVipGo as default PHPCS standard..."

PMCCS_STANDARDS=$(find $STANDARDS_DIR -maxdepth 1 -type d -name "Pmc*")
PMCCS_DEPENDENCIES=$(find "${STANDARDS_DIR}vendor/" -maxdepth 3 -type f -name composer.json -not -path "${STANDARDS_DIR}vendor/dealerdirect/*" -not -path "${STANDARDS_DIR}vendor/squizlabs/*" | sed -e 's,/composer.json$,,')

PMCCS_STANDARDS=$(echo "${PMCCS_STANDARDS},${PMCCS_DEPENDENCIES}" | sed -e 's,/srv/www/phpcs,.,g' | sed -e :a -e N -e 's/\n/,/' -e ta)

phpcs --config-set installed_paths "$PMCCS_STANDARDS"
phpcs --config-set default_standard PmcWpVipGo
phpcs -i
phpcs --config-show
