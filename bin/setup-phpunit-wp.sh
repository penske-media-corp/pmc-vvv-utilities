#!/bin/bash

################################################################################
# Script Name: setup-phpunit-wp.sh
#
# Description:
#   This script sets up PHPUnit and WordPress for automated testing on a Vagrant
#   virtual machine. To use this script, you must first SSH into the Vagrant
#   machine and navigate to the directory where the script is located. Before
#   running the script, you must also make it executable by running the command:
#
#     chmod +x setup-phpunit-wp.sh
#
# Usage:
#   ./setup-phpunit-wp.sh [app-name]
#
# Examples:
#   ./setup-phpunit-wp.sh sportico-com
#   ./setup-phpunit-wp.sh rollingstone-com
#
# Links:
#   - Unit Tests: https://github.com/penske-media-corp/pmc-vvv/blob/master/docs/unit-tests.md
#   - Test Exports: https://github.com/penske-media-corp/pmc-vvv/blob/master/docs/test-exports.md
#
# Created: 20 Apr 2023
################################################################################

# Get the app name argument
app_name="$1"

# Create phpunit directory.
sudo mkdir -p /usr/share/php/phpunit

# Navigate to new directory
cd /usr/share/php/phpunit

# Add composer require for phpunit
# User will be prompted to continue as root/super user.
sudo composer require --dev phpunit/phpunit ^9 \
  --update-with-all-dependencies

# Create symlink in user directory
sudo ln -sf /usr/share/php/phpunit/vendor/bin/phpunit /usr/bin/phpunit

# Navigate to home directory
cd ~

# Clone WordPress develop only if directory doesn't exist
if [ ! -d ~/wordpress-develop ]; then
    git clone --depth 1 git@github.com:WordPress/wordpress-develop.git
fi

# Copy newly created tests directory to theme
cp -r ~/wordpress-develop/tests/ /srv/www/"$app_name"/public_html/

# Composer require phpunit polyfill
composer require --dev yoast/phpunit-polyfills

# Copy newly created tests config to theme
cp ~/wordpress-develop/wp-tests-config-sample.php \
  /srv/www/"$app_name"/public_html/wp-tests-config.php

# Define test exports for project
PMC_PHPUNIT_BOOTSTRAP=/srv/www/"$app_name"/public_html/wp-content/plugins/pmc-plugins/pmc-unit-test/bootstrap.php
WP_TESTS_DIR=/srv/www/"$app_name"/public_html/tests/phpunit

# Replace ABSPATH definition and database credentials in wp-tests-config.php
sed -i "s|define( 'ABSPATH', dirname( __FILE__ ) . '/src/' );|define( 'ABSPATH', dirname( __FILE__ ) . '/' );|g" \
  /srv/www/"$app_name"/public_html/wp-tests-config.php
sed -i "s|define( 'DB_NAME', 'youremptytestdbnamehere' );|define( 'DB_NAME', '$app_name' );|g" \
  /srv/www/"$app_name"/public_html/wp-tests-config.php
sed -i "s|define( 'DB_USER', 'yourusernamehere' );|define( 'DB_USER', 'wp' );|g" \
  /srv/www/"$app_name"/public_html/wp-tests-config.php
sed -i "s|define( 'DB_PASSWORD', 'yourpasswordhere' );|define( 'DB_PASSWORD', 'wp' );|g" \
  /srv/www/"$app_name"/public_html/wp-tests-config.php

# Add additional lines to wp-tests-config.php
echo "define( 'PMC_IS_VIP_GO_SITE', true );" \
  >> /srv/www/"$app_name"/public_html/wp-tests-config.php
echo "define( 'VIP_GO_APP_ENVIRONMENT', 'development' );" \
  >> /srv/www/"$app_name"/public_html/wp-tests-config.php
echo "define( 'WP_TESTS_PHPUNIT_POLYFILLS_PATH', '/home/vagrant/vendor/yoast/phpunit-polyfills/' );" \
  >> /srv/www/"$app_name"/public_html/wp-tests-config.php

# Apply lines to ~/.bash_profile
echo "export PMC_PHPUNIT_BOOTSTRAP='$PMC_PHPUNIT_BOOTSTRAP'" \
  >> ~/.bash_profile
echo "export WP_TESTS_DIR='$WP_TESTS_DIR'" \
  >> ~/.bash_profile

# Output message with instructions for user
echo "Done! To apply changes to your bash profile, run the following command:"
echo ""
echo "source ~/.bash_profile"
echo ""
echo "This will make the changes available in your current terminal session. If"
echo "you open a new terminal session, you may need to run this command again to"
echo "apply the changes."
