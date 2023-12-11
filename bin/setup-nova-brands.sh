#!/bin/bash

################################################################################
# Script Name: setup-nova-brands.sh
# Script Location: /srv/provision/extensions/pmc/bin/setup-nova-brands.sh
#
# Description:
#   This script installs all nova themes, so that you can set up all nova themes under
#   single site installation. You can run this script from inside vagrant shh under any sites theme folder.
#
#   You must also make it executable by running the command:
#     chmod +x setup-nova-brands.sh
#
# Usage:
#    Suppose I want to clone all theme under artforum site, I would then navigate
#    to artforum theme folder and run the script with its location :
#
#    cd /srv/www/artforum-com/public_html/wp-content/themes
#    ./srv/provision/extensions/pmc/bin/setup-nova-brands.sh
#
# Created: 7 Sept 2023
################################################################################

# Clone all nova brands
git clone git@github.com:penske-media-corp/pmc-artforum-2023.git
git clone git@github.com:penske-media-corp/pmc-indiewire-2023.git
git clone git@github.com:penske-media-corp/pmc-nova-theme.git
git clone git@github.com:penske-media-corp/pmc-rr-giftguide-2023.git
git clone git@github.com:penske-media-corp/pmc-stylecaster-2023.git
git clone git@github.com:penske-media-corp/pmc-tvline-2023.git

echo "All themes downloaded !!"
