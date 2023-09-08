#!/bin/bash

################################################################################
# Script Name: setup-nova-brands.sh
# Script Location: /srv/provision/extensions/pmc/bin/setup-nova-brands.sh
#
# Description:
#   This script installs all nova themes, so that you can set up all nova themes under
#   single site installation. Nova theme will be used as the base theme.
#   You must also make it executable by running the command:
#     chmod +x setup-nova-brands.sh
#
# Usage:
#   ./setup-nova-brands.sh
#
# Created: 7 Sept 2023
################################################################################

# Navigate to nova theme directory
cd /srv/www/nova/public_html/wp-content/themes

# Clone all nova brands
sudo git clone git@github.com:penske-media-corp/pmc-artforum-2023.git
sudo git clone git@github.com:penske-media-corp/pmc-indiewire-2023.git
sudo git clone git@github.com:penske-media-corp/pmc-stylecaster-2023.git
sudo git clone git@github.com:penske-media-corp/pmc-tvline-2023.git

echo "All themes downloaded !!"