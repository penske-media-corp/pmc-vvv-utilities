#!/bin/bash

function update_repos() {
  echo "UPDATING PLUGIN AND THEME REPOSITORIES"
  echo ""

  local WP_CONTENT_DIR
  WP_CONTENT_DIR=$(pwd)

  local DIRECTORIES=(
    "${WP_CONTENT_DIR}/mu-plugins"
    "${WP_CONTENT_DIR}/plugins"
    "${WP_CONTENT_DIR}/plugins/pmc-plugins"
  )

  # Find theme repos.
  while IFS= read -r -d $'\0'; do
      DIRECTORIES+=("$REPLY")
  done < <(find "${WP_CONTENT_DIR}/themes" -maxdepth 2 -type d -iname "pmc-*" -print0)

  # Check each directory and update if possible.
  for DIR in "${DIRECTORIES[@]}"; do
    echo "${DIR}"
    if \
      [ -z "$(git -C "${DIR}" -c core.fileMode=false status --porcelain)" ] && \
      [ "$(git -C "${DIR}" remote show origin | grep 'HEAD branch' | sed 's/.*: //')" == "$(git -C "${DIR}" rev-parse --abbrev-ref HEAD)" ] \
    ; then
      echo " -> Updating!"
      git -C "${DIR}" -c core.fileMode=false pull --quiet --ff-only
    else
      echo " -> Not updating; directory either isn't on the default branch, or local changes were detected."
    fi
  done

  echo ""
  echo "DONE"
}

update_repos
