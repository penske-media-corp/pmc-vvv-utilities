#!/bin/bash

WP_CONTENT_DIR=$(pwd)

git -C "${WP_CONTENT_DIR}/mu-plugins" pull origin master
git -C "${WP_CONTENT_DIR}/plugins" pull origin master
git -C "${WP_CONTENT_DIR}/plugins/pmc-plugins" pull origin master

find "${WP_CONTENT_DIR}/themes" -maxdepth 2 -type d -name "pmc-*" -exec git pull origin master
