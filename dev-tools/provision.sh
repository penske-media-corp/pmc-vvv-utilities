#!/usr/bin/env bash

npm install -g coolaj86/yaml2json

apt-get update

apt-get install -y \
  awscli \
  git-extras \
  httpie \
  jq \
  neovim \
  ranger \
  siege \
  tig \
  vifm

apt-get clean -y
